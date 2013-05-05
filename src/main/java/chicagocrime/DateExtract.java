package chicagocrime;

import cascading.flow.FlowProcess;
import cascading.operation.*;
import cascading.tuple.Fields;
import cascading.tuple.Tuple;
import cascading.tuple.TupleEntry;
import cascading.tuple.TupleException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateExtract extends BaseOperation implements Function {
    private static final Logger LOG = LoggerFactory.getLogger(DateExtract.class);

    private Fields dateFields = new Fields();

    public DateExtract(Fields dateFields,Fields outFields) {
        super(outFields);
        this.dateFields = dateFields;
    }

  @Override
  public void operate(FlowProcess flowProcess, FunctionCall functionCall) {

    TupleEntry arguments = functionCall.getArguments();
    String a = arguments.getString(functionCall.getArguments().getFields().getPos(dateFields.get(0)));
    DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a");
    Date d = null;
    Integer month=null;
    Integer hour=null;
    Integer week=null;

    try {
      d = formatter.parse(a);
      Calendar cal = Calendar.getInstance();
      cal.setTime(d);

      month = cal.get(Calendar.MONTH);
      hour = cal.get(Calendar.HOUR_OF_DAY);
      week = cal.get(Calendar.DAY_OF_WEEK);


    } catch (ParseException e) {
      LOG.info("Parse Error  "+a);
      throw new TupleException();
    }


    Tuple t = new Tuple();
    t.add(month);
    t.add(hour);
    t.add(week);

    functionCall.getOutputCollector().add(t);

  }

}

