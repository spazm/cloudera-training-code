import java.io.IOException;
import java.util.StringTokenizer;

// AverageWordLengthMapper Import type for input and output keys and values.

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.Mapper;
import org.apache.hadoop.mapred.MapReduceBase;
import org.apache.hadoop.mapred.OutputCollector;
import org.apache.hadoop.mapred.Reporter;

public class AverageWordLengthMapper extends MapReduceBase 
		implements Mapper<Object, Text, Text, IntWritable> {

	private Text letter = new Text();
	
	public void map(Object key, 
			Text value, 
			OutputCollector<Text, IntWritable> output, 
			Reporter reporter) 
	throws IOException {
		StringTokenizer wordList = new StringTokenizer(value.toString());
		String word = "";

		while( wordList.hasMoreTokens() )
		{
			word = wordList.nextToken();
			letter.set (word.substring(0,1));
			output.collect(letter, new IntWritable( word.length() ) );
		}
	}
}
