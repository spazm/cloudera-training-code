jarpath=${HADOOP_HOME}/contrib/streaming/ha*streaming*.jar
input=streamtest_in/*
output=streamtest_out
file=kvtest.pm


all:    streaming
local:  reduce
map:    map.out
reduce: reduce.out

map.out: input.txt ${file}
	cat input.txt | perl ${file} > map.out 2>/dev/null

map.sort: map.out
	sort map.out > map.sort
	
reduce.out: map.sort
	cat map.sort | perl ${file} REDUCE > reduce.out

streaming:
	hadoop jar ${jarpath}              \
	-input   '${input}'                \
	-output  '${output}'               \
	-file    '${file}'                 \
	-mapper  'perl ${file}'            \
	-reducer 'perl ${file} REDUCE' 

streaming-join:
	hadoop jar ${jarpath}              \
	-input   '${input}'                \
	-output  '${output}-join'          \
	-file    'joinmap.pl'              \
	-file 	 'joinreduce.pl'           \
	-mapper  'perl joinmap.pl'         \
	-reducer 'perl joinreduce.pl' 

streaming-join2:
	hadoop jar ${jarpath}              \
	-D 'mapred.line.input.format.keyvaluetextinputformat' \
	-input   '${input}'                \
	-output  '${output}-join2'          \
	-file    'joinmap.pl'              \
	-file 	 'joinreduce.pl'           \
	-mapper  'perl joinmap.pl'         \
	-reducer 'perl joinreduce.pl' 

rm:
	hadoop fs -rmr '${output}'
