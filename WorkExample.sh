#!/bin/sh
testing='/home/saptarshi/SparkData/Testing.txt'
tokens='/home/saptarshi/SparkData/Tokenized'
Stop='/home/saptarshi/SparkData/StopWords'
NoStop='/home/saptarshi/SparkData/NoStopWords.csv'
input_file='/home/saptarshi/SparkData/IntelliJData'
input='/home/saptarshi/SparkData/Checking.txt'
output_file='/home/saptarshi/SparkData/HugeDataSet.csv'
output='/home/saptarshi/SparkData/FilteredData.txt'
#while inotifywait -q -e modify $input_file >/dev/null; do
#echo `date`
rm -f $testing
while read line; do var1=`echo "$line"` 
  while read line; do var2=`echo "$line"`
var1=`echo $var1 | sed -e 's/[^a-zA-Z ]/ /g; s/ '$var2' / /g'`
done <$Stop
echo $var1>>$testing
done <$output
#echo `date`
#done
