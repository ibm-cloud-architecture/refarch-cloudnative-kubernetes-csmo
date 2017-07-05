
function import_single_dashboard {
   SERVER=$1
   PASS=$2
   DASH=$3

   if [ -z "$4" ]; 
   then
      REV=1
   else
      REV=$4
   fi
 
   curl -s https://grafana.com/api/dashboards/$DASH/revisions/$REV/download -o raw_$DASH.json
   TITLE=$(cat raw_$DASH.json | jq -r .title)
   echo Importing dashboard $DASH, called $TITLE 
   DS=$(cat raw_$DASH.json | jq -r .__inputs[0].name)
   #echo sed "s/\${$DS}/\${Prometheus}/"  raw_$DASH.json 
   sed "s/\${$DS}/\${Prometheus}/"  raw_$DASH.json > dash_$DASH.json
   sed 's/${Prometheus}/Prometheus/' -i dash_$DASH.json
   #grep Prom dash_$DASH.json
   sed -i '1i{ "dashboard": ' dash_$DASH.json
   echo   , \"overwrite\": true} >> dash_$DASH.json
   curl -s -u admin:$PASS -H "Content-Type: application/json" -X POST http://$SERVER/api/dashboards/db -d @dash_$DASH.json
   echo
}


if [ -z "$1" ]; 
then
	echo "No Grafana server name or IP passed to script"
	exit 1 
fi
if [ -z "$2" ];
then
        echo "No Grafana password passed to script"
        exit 1
fi

#                       IP Password   Dash  Revision

import_single_dashboard $1 $2         159    1 
import_single_dashboard $1 $2           2    2 
import_single_dashboard $1 $2         741    1 
import_single_dashboard $1 $2         315    2 
import_single_dashboard $1 $2        1471    1 



