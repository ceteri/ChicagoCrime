package chicagocrime;

import java.util.Properties;

import cascading.flow.Flow;
import cascading.flow.FlowDef;
import cascading.flow.hadoop.HadoopFlowConnector;
import cascading.operation.Aggregator;
import cascading.operation.aggregator.Count;
import cascading.pipe.*;

import cascading.pipe.assembly.Coerce;
import cascading.pipe.assembly.SumBy;
import cascading.property.AppProps;
import cascading.scheme.hadoop.TextDelimited;
import cascading.tap.Tap;
import cascading.tap.hadoop.Hfs;
import cascading.tuple.Fields;


public class
  Main
{
  public static void
  main( String[] args )
  {


    Properties properties = new Properties();
    AppProps.setApplicationJarClass( properties, Main.class );
    HadoopFlowConnector flowConnector = new HadoopFlowConnector( properties );

    // source tap

    Fields inFields = new Fields("Case Number","Date","Block","IUCR","crime_id","Description","Location Description","Arrest","Domestic","Beat","ward","FBI Code","X Coordinate","Y Coordinate","Year","Latitude","Longitude","Location");
    Fields dataField = new Fields( "crime_id", "ward","month","hour","Count");

    Tap inTap = new Hfs( new TextDelimited( inFields,true, ",", "\"" ), "data/crimes_2008.csv" );
    Tap inTap2= new Hfs( new TextDelimited( dataField,true, ",", "\"" ), "data/cube_defaults.csv" );

    //Tap outTap = new Hfs(new TextDelimited( new Fields("Primary Type","Ward","Latitude","Longitude","Month","Hour","Week"),true, ","), "RawCrimeData");
    Tap outTap = new Hfs(new TextDelimited( Fields.ALL,true,true,","), "RawCrimeData");
    Tap trap = new Hfs(new TextDelimited( Fields.ALL,false,true,","), "TrappedData");





    // pipe
    Pipe pipe = new Pipe( "Test" );
    Pipe genPipe = new Pipe( "Gen" );
    genPipe = new Coerce(genPipe,String.class, Integer.class,Integer.class,Integer.class,Integer.class);

    pipe = new Each(pipe,new DateExtract(new Fields("Date"),new Fields("month","hour","week")),Fields.ALL);

    pipe = new GroupBy( pipe, new Fields( "crime_id", "ward","month","hour") );

    Aggregator count = new Count( new Fields( "Count" ) );
    pipe = new Every( pipe, count );
    pipe = new Coerce(pipe,new Fields( "crime_id", "ward","month","hour","Count"),String.class, Integer.class,Integer.class,Integer.class,Integer.class);

    Pipe merged = new Merge("Merged",pipe, genPipe);
    merged = new SumBy( merged,new Fields( "crime_id", "ward","month","hour"), new Fields("Count"),
                  new Fields("Total") , Double.class );



    FlowDef flowDef = FlowDef.flowDef()
      .addSource( pipe, inTap )
      .addSource(genPipe,inTap2)
      .addTrap(pipe, trap)
      .addTrap(genPipe,trap)
      .addTrap(merged,trap)
      .addTailSink(merged, outTap);


    //flow
    Flow f = flowConnector.connect(flowDef);
    f.writeDOT("docs/flow.dot");
    f.complete();

  }
}
