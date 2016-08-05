#!/bin/bash

k=$(find /tomcat/appagent/ -maxdepth 1 -type d -name "ver*" | sed "s:^/tomcat/appagent/::")
sed -i "s/127.0.0.1/${IP_ADDRESS}/g" /tomcat/appagent/$k/external-services/npm/npm-service.properties
sed -i "s/localhost/${IP_ADDRESS}/g" /tomcat/appagent/$k/external-services/npm/npm-service.properties

if [ -z "${CONTROLLER}" ]; then
	export CONTROLLER="controller";
fi

if [ -z "${APPD_PORT}" ]; then
	export APPD_PORT=8090;
fi

if [ -z "${APP_NAME}" ]; then
	export APP_NAME="Fulfillment";
fi

if [ -z "${NODE_NAME}" ]; then
	export NODE_NAME="SynapseESB1";
fi
		
if [ -z "${TIER_NAME}" ]; then
	export TIER_NAME="FulfillmentESB";
fi

JAVA_OPTS="-Dappdynamics.controller.hostName=${CONTROLLER} -Dappdynamics.controller.port=${APPD_PORT} -Dappdynamics.agent.applicationName=${APP_NAME} -Dappdynamics.agent.tierName=${TIER_NAME} -Dappdynamics.agent.nodeName=${NODE_NAME} -Dappdynamics.agent.accountName=${ACCOUNT_NAME%%_*} -Dappdynamics.agent.accountAccessKey=${ACCESS_KEY}";

source /start-machine-agent.sh
source /start-appserver-agent.sh


cd ${SYNAPSE_HOME};
bin/synapse.sh	
