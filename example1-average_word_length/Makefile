java=    AverageWordLengthMapper.java  AverageWordLengthReducer.java  AverageWordLengthDriver.java  
classes= AverageWordLengthMapper.class AverageWordLengthReducer.class AverageWordLengthDriver.class 

default: jar
jar: awl.jar

awl.jar: ${classes}
	jar cvf awl.jar -C . ${classes}

AverageWordLengthDriver.class: ${classes}
	javac -classpath ${HADOOP_HOME}/hadoop*core.jar ${java}

AverageWordLengthMapper.class: AverageWordLengthMapper.java
	javac -classpath ${HADOOP_HOME}/hadoop*core.jar AverageWordLengthMapper.java

AverageWordLengthReducer.class: AverageWordLengthReducer.java
	javac -classpath ${HADOOP_HOME}/hadoop*core.jar AverageWordLengthReducer.java

hadoop: awl.jar
	hadoop jar awl.jar AverageWordLengthDriver shakespeare awl_shakespeare

dir:
	hadoop fs -rmr awl_shakespeare
