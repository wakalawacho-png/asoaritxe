#!/bin/bash

echo "comprovant grups creats..."

#total de grups
TOTAL=$(aws ec2 describe-security-groups \
	--query "SecurityGroups[*].GroupId" \
	--output text | wc -w)
echo "total de grups: $TOTAL"

#comprovar si default esta

DEFAULT=$(aws ec2 describe-security-groups \
	--filters Name=group-name,Values=default \
	--query "SecurityGroups[0].GroupId" \
	--output text)

#si no esta, crearlo
if ["$DEFAULT" = "None" ] || [ -z "$DEFAULT" ]; then
echo "no existe default"

DEFAUlT=$(aws ec2 create-security-group \
	--group-name default \
	--description "Default Security Group" \
	--query "GrouId" \
	--output text)

echo "creat grup $DEFAULT"

else
echo "ja existeix $DEFAULT"
fi
