package chicagocrime;

import cascading.flow.FlowProcess;
import cascading.operation.BaseOperation;
import cascading.operation.Buffer;
import cascading.operation.BufferCall;
import cascading.tuple.Fields;
import cascading.tuple.Tuple;
import cascading.tuple.TupleEntry;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

public class ExponentialDecay extends BaseOperation implements Buffer
{

  Fields declared;
  public ExponentialDecay(Fields fields) {
    super(fields);

  }

  public void operate( FlowProcess flowProcess, BufferCall bufferCall )
  {
    // get all the current argument values for this grouping
    Iterator<TupleEntry> arguments = bufferCall.getArgumentsIterator();

    HashMap<Integer,Integer> keyVal = new HashMap<Integer, Integer>();
    Tuple result = new Tuple();
    List<Tuple> allTuple = new ArrayList<Tuple>();

    while( arguments.hasNext() )
    {
      TupleEntry argument = arguments.next();
      Integer year = argument.getInteger(argument.getFields().getPos("Year"));

      Integer count = argument.getInteger(argument.getFields().getPos("Total"));


      keyVal.put(year,count);
      allTuple.add(argument.getTupleCopy());

      // insert some values into the result Tuple based on the arguemnts
    }



    for(Tuple t:allTuple)
    {
      Tuple resultTuple = new Tuple();
      System.out.println("Test");

      Integer year = t.getInteger(5);
      resultTuple.addAll(t);
      if(keyVal.containsKey(year-1))
      {
        resultTuple.add(Math.pow(keyVal.get(year-1),0.98));
      }
      else
        resultTuple.add(0.0);

      if(keyVal.containsKey(year-2))
      {
        resultTuple.add(Math.pow(keyVal.get(year-2),0.98*0.98));
      }
      else
        resultTuple.add(0.0);


      // insert some values into the result Tuple based on the arguemnts
      bufferCall.getOutputCollector().add(resultTuple);
    }


  }
}