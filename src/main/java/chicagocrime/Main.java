package chicagocrime;

import java.util.Properties;

import cascading.flow.Flow;
import cascading.flow.FlowDef;
import cascading.flow.hadoop.HadoopFlowConnector;
import cascading.operation.Aggregator;
import cascading.operation.aggregator.Count;
import cascading.pipe.*;

import cascading.pipe.assembly.Coerce;
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

      Fields inFields = new Fields("Case Number","Date","Block","IUCR","Primary Type","Description","Location Description","Arrest","Domestic","Beat","Ward","FBI Code","X Coordinate","Y Coordinate","Year","Latitude","Longitude","Location");

      Tap inTap = new Hfs( new TextDelimited( inFields,true,true, ",", "\"" ), "data/crimes_2008.csv" );

      //Tap outTap = new Hfs(new TextDelimited( new Fields("Primary Type","Ward","Latitude","Longitude","Month","Hour","Week"),true, ","), "RawCrimeData");
      Tap outTap = new Hfs(new TextDelimited( Fields.ALL,false,true,","), "RawCrimeData");
      Tap trap = new Hfs(new TextDelimited( Fields.ALL,","), "TrappedData");





      // pipe
      Pipe pipe = new Pipe( "Test" );
      pipe = new Each(pipe,new DateExtract(new Fields("Date"),new Fields("Month","Hour","Week")),Fields.ALL);
      pipe = new GroupBy( pipe, new Fields( "Primary Type", "Ward","Month","Hour","Week") );

      Aggregator count = new Count( new Fields( "Count" ) );
      pipe = new Every( pipe, count );
      pipe = new Coerce(pipe,Fields.ALL,String.class, Integer.class,Integer.class,Integer.class,Integer.class,Integer.class);

      FlowDef flowDef = FlowDef.flowDef()
        .addSource( pipe, inTap )
        .addTrap(pipe,trap)
        .addTailSink(pipe, outTap);


    //flow
      Flow f = flowConnector.connect(flowDef);
      f.writeDOT("docs/flow.dot");
      f.complete();

    }
  }
