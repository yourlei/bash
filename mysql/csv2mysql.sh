#!/bin/sh

# mysql info
DATABASE="test"
TABLE="cnarea_2017"
# 导入的csv文件路径
CSV_DATA="area.csv"

# 检查文件是否存在
if [ -f ${CSV_DATA} ]; then
	echo "File ${CSV_DATA} Existed."
else 
	echo "File ${CSV_DATA} Not Existed."
	echo 
	exit 2
fi

# ################################
# 按行读取文件
# while read line
# do
# echo $line
# done < $file
# ################################

while read line;
do

	# echo `echo $line | awk -F, '{printf("%s, %s, %s, %s", $2, $3, $4, $5)}'`
  query=`echo $line | awk -F, '{printf("%s, %s, %s, %s, %s, %s", $2, $5, $6, $7, $8, $9)}'`
	statement=`echo "insert into ${TABLE}(parent_id, zip_code, zip_city, city_code, name, short_name) values($query)"`
	echo $statement

	mysql $DATABASE << EOF
	insert into ${TABLE}(parent_id, zip_code, city_code, name, short_name, merger_name) values($query);
EOF
done < $CSV_DATA

# 检查最后一条bash脚本执行是否成功
if [ $? -eq 0 ]; then
	echo "Insert Data Into $TABLE Success."
fi