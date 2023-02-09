#!/bin/bash

## example command
# ./notisJenkins.sh tnt-haioo haioo-backoffice release true 80 40 rubenson initialcommit http://
endpoint=$1 #endpoint hooks
appname=$2 #PRODUCT_NAME
servicename=$3 #DOCKER_IMAGE_NAME
branch=$4 #BRANCH_NAME
status=$5 # true or false
buildnumber=$6 #BUILD_NUMBER
coverage=$7 # number percentage
commitauthor=$8
commitmessage=$9
buildurl=$10 #BUILD_URL

#variable date
currDate=$(date '+%Y-%m-%d')

##Image Mang Jenkins
image="data:image/png;base64,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"

#condition for statusString
statusstring="❌Failure"
if [ $status = true ]; then
  statusstring="✅Success"
fi

##color coverage
coveragecolor="🟥"
if [ $coverage -gt 80 ]; then
    coveragecolor="🟩"
elif [ $coverage -gt 60 ]; then
     coveragecolor="🟨"
elif [ $coverage -gt 40 ]; then
     coveragecolor="🟧"
fi

##environment parameter
declare -A listEnv
    listEnv['develop']='Development'
    listEnv['release']='Staging'
    listEnv['master']='Production'

# call api hooks
NOTICE=$(curl --location --request POST ${endpoint} \
    --header 'Content-Type: application/json' \
    --data-raw '{
    "@context": "https://schema.org/extensions",
    "@type": "MessageCard",
    "themeColor": "0072C6",
    "text": "****",
    "sections": [
        {
            "id":"activity",
            "activityTitle": "**Jenkins Melapor**",
            "activitySubtitle": "'$currDate'",
            "activityImage": "'$image'",
            "facts": [
                {
                    "name": "App",
                    "value": "'$appname'"
                },
                {
                    "name": "Status:",
                    "value": "'$statusstring'"
                },
                {
                    "name": "Environment:",
                    "value": "'${listEnv[$branch]}'"
                },
                {
                    "name": "Coverage(approx):",
                    "value": "'$coveragecolor' **'$coverage'%**"
                },
                {
                    "name": "Commit Author:",
                    "value": "'$commitauthor'"
                },
                {
                    "name": "Commit Message:",
                    "value": "'$commitmessage'"
                }
            ],
            "text": "Jenkins Build **#'$buildnumber'** for service **'$servicename'** from branch **'$branch'**"
        }
    ],
    "potentialAction": [
        {
            "@type": "OpenUri",
            "name": "Jenkins",
            "targets": [
                {
                    "os": "default",
                    "uri": "'$buildurl'"
                }
            ]
        },
        {
            "@type": "OpenUri",
            "name": "SonarQube",
            "targets": [
                {
                    "os": "default",
                    "uri": "https://sonarqube.playcourt.id/dashboard?id='$servicename'"
                }
            ]
        },
        {
            "@type": "OpenUri",
            "name": "DevSecOps",
            "targets": [
                {
                    "os": "default",
                    "uri": "https://devsecops.playcourt.id/simple_search?query=tag:'$servicename'"
                }
            ]
        }   
    ]
}')

echo $NOTICE
