jarpath=${HADOOP_HOME}/contrib/streaming/ha*streaming*.jar
file=inverted_index.pm

all: streaming

map:
	cat input.txt | perl inverted_index.pm

reduce:
	cat input.txt | perl inverted_index.pm | sort | perl inverted_index.pm REDUCE

streaming:
	hadoop jar ${jarpath}              \
	-input   'shakespeare-stream/*'    \
	-output  'inverted-index'          \
	-file    "${file}"                 \
	-mapper  'perl ${file}'            \
	-reducer 'perl ${file} REDUCE' 

rm:
	hadoop fs -rmr inverted-index
