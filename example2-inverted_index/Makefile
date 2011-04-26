jarpath=${HADOOP_HOME}/contrib/streaming/ha*streaming*.jar
file=inverted_index.pm

all:    streaming
local:  reduce
map:    map.out
reduce: reduce.out

map.out: input.txt ${file}
	cat input.txt | perl inverted_index.pm > map.out 2>/dev/null

map.sort: map.out
	sort map.out > map.sort
	
reduce.out: map.sort
	cat map.sort | perl inverted_index.pm REDUCE > reduce.out

streaming:
	hadoop jar ${jarpath}              \
	-input   'shakespeare-stream/*'    \
	-output  'inverted-index'          \
	-file    "${file}"                 \
	-mapper  'perl ${file}'            \
	-reducer 'perl ${file} REDUCE' 

rm:
	hadoop fs -rmr inverted-index
