#!/bin/bash

# Terminal Colors
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'
coffee=$'\xE2\x98\x95'
coffee3="${coffee} ${coffee} ${coffee}"
URL=$1
PASSWORD=$2

function print_usage {
        printf "\n\n${yel}Usage:${end}\n"
        printf "\t${cyn}./install_bluecompute_ce.sh <grafana-url> <grafana-admin-password>${end}\n\n"
}


if [[ -z "${URL// }" ]]; then
		print_usage
		echo "${red}Please provide Grafana URL. Exiting..${end}"
		exit 1

elif [[ -z "${PASSWORD// }" ]]; then
		print_usage
		echo "${red}Please provide Grafana admin user password. Exiting..${end}"
		exit 1
fi


FILES=docs/dashboards/*.json
for f in $FILES
do
  printf "\nProcessing $f : "
  curl -s -u admin:$PASSWORD -H "Content-Type: application/json" -X POST $URL/api/dashboards/db -d@$f
done


printf "\n\nYou can now access a variety of dashboards to show monitoring data on the Kubernetes cluster."
printf "\n\t${URL}/dashboard/db/prometheus-system-from-159?refresh=30s is a good default dashboard"
printf "\n\t${URL}/dashboard/db/prometheus-data-exploration?refresh=5s allows to you explore all the available metrics"
printf "\n"
