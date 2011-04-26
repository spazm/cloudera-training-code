import java.io.IOException;
import java.util.Iterator;

// AverageWordLength Import types for input and output keys and values.

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.OutputCollector;
import org.apache.hadoop.mapred.MapReduceBase;
import org.apache.hadoop.mapred.Reducer;
import org.apache.hadoop.mapred.Reporter;

public class AverageWordLengthReducer extends MapReduceBase 
		implements Reducer<Text, IntWritable, Text, FloatWritable> {
	
	public void reduce(Text key, 
		Iterator<IntWritable> values, 
		OutputCollector<Text, FloatWritable> output, 
		Reporter reporter)
	throws IOException {
		
		FloatWritable avg = new FloatWritable();
		int sum = 0;
		int count = 0;

		while (values.hasNext()) {
			sum += values.next().get();
			count += 1;
		}
		avg.set(count/sum);
		output.collect( key , avg );
	}
}
