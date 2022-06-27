checkedaln=$1

echo >hhalign_eachfatotemplate_cmd
for fa in *.fa
do
	echo "hhalign -i ${fa} -t ${checkedaln} -all -glob -o /dev/null" >>hhalign_eachfatotemplate_cmd
done
