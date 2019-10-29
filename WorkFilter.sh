#!/bin/sh

tokens='/home/saptarshi/SparkData/Tokenized'
Stop='/home/saptarshi/SparkData/StopWords'
NoStop='/home/saptarshi/SparkData/NoStopWords.txt'
input_file='/home/saptarshi/SparkData/IntelliJData'
input='/home/saptarshi/SparkData/Checking.txt'
output_file='/home/saptarshi/SparkData/HugeDataSet.csv'
output='/home/saptarshi/SparkData/FilteredData.txt'
location_file='/home/saptarshi/SparkData/Location.txt'
id='/home/saptarshi/SparkData/UserIDs.txt'

#while inotifywait -q -e modify $input_file >/dev/null; do

         IFS="
        "
        # Loop through the file

        #foreach line ( "`cat $input_file`" )
        while read line; do

                grep \"lang\":\"en\"\,\"timestamp_ms\"  $input_file> $input
                if [ $? -eq 0 ];

                #if $input_file| grep -Fxq \"lang\":\"en\">$input;
                then

                        cat $input|grep -o "\"text\":\".*"|sed 's/source//g'|sed 's/[ |\t]{2,}//g'|sed 's/display_text_range//g'|sed 's/url//g'|sed 's/"//g'|sed 's/RT//g'|sed 's/https//g'|sed 's/href=//g'|sed 's/rel=//g'|sed 's%@[^ ]*%%g'|sed 's/[#]*//g'|sed 's%\\[^ ]*%%g'|cut -f2 -d:> $output

#cat $input|grep -o "\"text\":\".*"|sed 's/source//g'|sed 's/[ |\t]{2,}//g'|sed 's/display_text_range//g'|sed 's/url//g'|sed 's/"//g'|sed 's/RT//g'|sed 's/https//g'|sed 's/href=//g'|sed 's/rel=//g'|sed 's%@[^ ]*%%g'|sed 's/[#]*//g'|sed 's%\\[^ ]*%%g'|cut -f2 -d:> $output_file



                        cat $input|grep -o "\"location\":.*"|sed 's/,//g'|sed 's/url//g'|sed 's/"//g'|cut -f2 -d:>$location_file
			cat $input|grep -o "\"id\":.*"|sed 's/,"id_str"//g'|cut -f2 -d:> $id 

                        
      			paste $location_file $output $id > $output_file
			
                fi
        done<$input_file
	
	 #paste $location_file $output $id|column > $output_file


	tr -s '[[:digit:][:punct:][:space:]]' '\n' < $output_file > $tokens
        grep -i -F -n -v -w -f $Stop $tokens > $NoStop


#done

