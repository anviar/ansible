#!/bin/bash

[[ -d ${DNP_ROOT}/${DNP_VERSION} ]] && cd ${DNP_ROOT}/${DNP_VERSION} || exit 1

if [[ -f .environment ]]
then
	. .environment
fi

if [[ -f package.json ]]
then
	if [[ ! -d node_modules ]]
	then
		echo "Installing modules"
		npm install
	else
		npm outdated
	fi
fi

echo "Starting service"
if [[ -f dist/server.js ]]
then
	node --use_strict --expose-gc dist/server.js --config=production
elif [[ -f src/server.js ]]
then
	node --use_strict --expose-gc src/server.js --config=production
elif [[ -f server.js ]]
then
	node --use_strict --expose-gc server.js --config=production
else
	echo "Error: server.js not found in ${PWD}"
	exit 1
fi
