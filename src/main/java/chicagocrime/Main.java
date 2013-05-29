package chicagocrime;

import cascading.flow.Flow;
import cascading.flow.FlowDef;
import cascading.flow.hadoop.HadoopFlowConnector;
import cascading.operation.Aggregator;
import cascading.operation.AssertionLevel;
import cascading.operation.aggregator.Count;
import cascading.operation.assertion.AssertNotNull;
import cascading.operation.regex.RegexReplace;
import cascading.pipe.*;
import cascading.pipe.assembly.Coerce;
import cascading.pipe.assembly.Discard;
import cascading.pipe.assembly.SumBy;
import cascading.pipe.joiner.LeftJoin;
import cascading.property.AppProps;
import cascading.scheme.hadoop.TextDelimited;
import cascading.tap.Tap;
import cascading.tap.hadoop.Hfs;
import cascading.tuple.Fields;

import java.util.Properties;


public class
  Main
{
  public static void
  main( String[] args )
  {
    Properties properties = new Properties();
    AppProps.setApplicationJarClass( properties, Main.class );
    HadoopFlowConnector flowConnector = new HadoopFlowConnector( properties );

    // source taps

    Fields inFields = new Fields("ID","Case Number","Date","Block","IUCR","crime_id","Description","Location Description","Arrest","Domestic","Beat","District","ward","community_area","FBI Code","X Coordinate","Y Coordinate","Year","Updated On","Latitude","Longitude","Location");
    Fields dataField = new Fields( "crime_id", "community_area","month","hour","week","Year","Count");

    Fields censusFields = new Fields("COMMUNITY AREA","COMMUNITY AREA NAME","PERCENT_OF_HOUSING_CROWDED","PERCENT_HOUSEHOLDS_BELOW_POVERTY","PERCENT_AGED_16_UNEMPLOYED","PERCENT_AGED_25_WITHOUT_HIGH_SCHOOL_DIPLOMA","PERCENT_AGED_UNDER_18_OR_OVER_64","PER_CAPITA_INCOME","HARDSHIP_INDEX");
    Fields languageFields = new Fields("Community Area","Community Area Name","PREDOMINANT NON-ENGLISH LANGUAGE (%)","AFRICAN_LANGUAGES","ARABIC","ARMENIAN","CAMBODIAN_MON_KHMER","CHINESE","CREOLE","FRENCH","GERMAN","GREEK","GUJARATI","HEBREW","HINDI","HMONG","HUNGARIAN","ITALIAN","JAPANESE","KOREAN","LAOTIAN","NAVAJO","OTHER_ASIAN","OTHER_INDIC","OTHER_INDO_EURPOEAN","OTHER_NATIVE_NORTH_AMERICAN","OTHER_PACIFIC_ISLAND","OTHER_SLAVIC","OTHER_WEST_GERMANIC","PERSIAN","POLISH","PORTUGUESE","RUSSIAN","SCANDINAVIAN","SERBO-CROATIAN","SPANISH","TAGALOG","THAI","UNSPECIFIED","URDU","VIETNAMESE","YIDDISH");

    Tap inTap = new Hfs( new TextDelimited( inFields,true, ",", "\"" ), "data/crimes.csv" );
    Tap genTap = new Hfs( new TextDelimited( dataField,true, ",", "\"" ), "data/cube_defaults.csv" );
    Tap censusTap = new Hfs( new TextDelimited( censusFields,true, ",", "\"" ), "data/census.csv" );
    Tap langTap = new Hfs( new TextDelimited( languageFields,true, ",", "\"" ), "data/language.csv" );

    Tap outTap = new Hfs(new TextDelimited(Fields.ALL,true,true,","), "RawCrimeData");
    Tap trap = new Hfs(new TextDelimited( Fields.ALL,false,true,","), "TrappedData");



    // pipe

    Pipe pipe = new Pipe( "Test" );
    Pipe censusPipe = new Pipe("Census");
    censusPipe = new Discard(censusPipe,new Fields("COMMUNITY AREA NAME"));
    censusPipe = new Coerce(censusPipe, new Fields("COMMUNITY AREA"), Integer.class);
    RegexReplace regexReplace = new RegexReplace(new Fields("PER_CAPITA_INCOME_FORMATED"),"\\$","", true);
    censusPipe = new Each(censusPipe,new Fields("PER_CAPITA_INCOME"),regexReplace,Fields.ALL);

    AssertNotNull notNull = new AssertNotNull();
    pipe = new Each( pipe,new Fields("community_area"), AssertionLevel.STRICT, notNull );



    Pipe langPipe = new Pipe("Lang");
    langPipe = new Coerce(langPipe,new Fields("Community Area"), Integer.class);
    langPipe = new Discard(langPipe, new Fields("PREDOMINANT NON-ENGLISH LANGUAGE (%)","Community Area Name"));



    Pipe genPipe = new Pipe( "Gen" );
    genPipe = new Coerce(genPipe,String.class, Integer.class,Integer.class,Integer.class,Integer.class,Integer.class,Integer.class);

    pipe = new Each(pipe,new DateExtract(new Fields("Date"),new Fields("month","hour","week")),Fields.ALL);

    pipe = new GroupBy( pipe, new Fields( "crime_id", "community_area","month","hour","week","Year") );
    Aggregator count = new Count( new Fields( "Count" ) );
    pipe = new Every( pipe, count );
    pipe = new Coerce(pipe,String.class, Integer.class,Integer.class,Integer.class,Integer.class,Integer.class,Integer.class);
    Pipe merged = new Merge("Merged",pipe, genPipe);
    merged = new SumBy( merged,new Fields( "crime_id", "community_area","month","hour","week","Year"), new Fields("Count"),
      new Fields("Total") , Double.class );

    merged = new GroupBy(merged,new Fields( "crime_id", "community_area","month","hour","week") );

    merged = new  Every(merged, new ExponentialDecay(new Fields( "crime_id", "community_area","month","hour","week","Year","Total","YearExp","YearExp2")), Fields.RESULTS);

    Pipe joinedPipe = new HashJoin(merged,new Fields("community_area"),censusPipe, new Fields("COMMUNITY AREA"), new LeftJoin());

    Pipe joinedPipe2 = new HashJoin(joinedPipe,new Fields("community_area"),langPipe, new Fields("Community Area"), new LeftJoin());





    FlowDef flowDef = FlowDef.flowDef()
      .addSource(pipe, inTap)
      .addSource(censusPipe, censusTap)
      .addSource(langPipe, langTap)
      .addSource(genPipe, genTap)
      .addTrap(censusPipe, trap)
      .addTrap(langPipe, trap)
      .addTrap(pipe, trap)
      .addTrap(genPipe, trap)
      .addTrap(merged,trap)
      .addTailSink(joinedPipe2, outTap);

    // flow planner

    Flow f = flowConnector.connect(flowDef);
    f.writeDOT("docs/flow.dot");
    f.complete();
  }
}
