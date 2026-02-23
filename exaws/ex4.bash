#!/bin/bash

SECURITY_GROUP_ID=$(aws ec2 describe-security-groups \
	--filters Name=group-name,Values=default \
	--query "SecurityGroups[0].GroupId" \
	--output text)

if [ "$SECURITY_GROUP_ID" = "None" ] || [ -z "$SECURITY_GROUP_ID" ]; then
	echo "el grup 'default' no existeix"
	exit 1
fi

echo "grup de seguretat trobat: $SECURITY_GROUP:ID"

PORT22_OPEN=$(aws ec2 describe-security-groups \
	--filters Name=group-name,Values=default \
	 --query 'SecurityGroups[0].IpPermissions' \
	--output table)


if [ -n "$PORT""_OPEN" ]; then
	echo "port obert"
	exit 0
fi

echo "obrint port22"
aws ec2 authorize-security-group-ingress \
	--group-id "$SECURITY_GROUP_ID" \
	--protocol tcp \
	--port 22 \
	--cidr 0.0.0.0/0
echo "port obert"
