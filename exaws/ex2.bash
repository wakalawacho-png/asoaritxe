#!/bin/bash

SECURITY_GROUP_ID=$(aws ec2 describe-security-groups \
	--filters Name=group-name,Values=default \
	--query "SecurityGroups[0].GroupId" \
	--output text)

aws ec2 authorize-security-group-ingress \
	--group-id "$SECURITY_GROUP_ID" \
	--protocol tcp \
	--port 22 \
	--cidr 0.0.0.0/0
