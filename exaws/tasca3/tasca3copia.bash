#!/bin/bash
CONFIG_FILE="configPorts.conf"
echo "iniciant configuracio"

while IFS= read -r line; do
	[ -z "$line" ] && continue
	SERVICE=$(echo "$line" | cut -d ':' -f1)
	PORTS=$(echo "$line" | cut -d ':' -f2)

	echo ""
	echo "procesant servei:$SERVICE"

	if [ "$SERVICE" == "ssh" ]; then
		SG_NAME="default"
	else
		SG_NAME="$SERVICE"
	fi

	echo "security group: $SG_NAME"
#buscar sg
	SG_ID=$(aws ec2 describe-security-groups \
		--filters Name=group-name,Values=$SG_NAME \
		--query "SecurityGroups[0].GroupId" \
		--output text)
#si no esta crear
	if [ "$SG_ID" = "None" ] || [ -z " $SG_ID" ]; then
		echo "$SG_NAME no existeix. creant..."
	SG_ID=$(aws ec2 create-security-group \
		--group-name $SG_NAME \
		--description "$SG_NAME security group" \
		--query "GroupId" \
		--output text)
	echo " creat sg amb ID: SG_ID"
	else
	echo " sg existenent : $SG_ID"
	fi
#separar ports per comes

	IFS=',' read -ra PORT_ARRAY <<< "$PORTS"
	for entry in "${PORT_ARRAY[@]}"]"; do
		PROTOCOL=$(echo "$entry" | cut -d '/' -f1)
		PORT=$(echo "$entry" | cut -d '/' -f2)
		echo " verificant $PROTOCOL/$PORT..."
#comprovar port obert
	RULE_EXISTS=$(aws ec2 describe-security-groups \
		--groups-ids "$SG_ID" \
		--query "SecurityGroups[0].IpPermissions[?IpProtocol==\'$PROTOCOL\' && FromPort<=\'$PORT\' && ToPort>=\'$PORT\']" \
		--output text)
	if [ -n "$RULE_EXISTS" ]; then
		echo " obert "
	else
		echo "obrint port $PORT/$PROTOCOL.."
	aws ec2 authorize-security-group-ingress \
		--group-id "$SG_ID" \
		--protocol "$PROTOCOL" \
		--port "$PORT" \
		--cidr 0.0.0.0/0
	echo " port obert "
	fi

	done
done < "$CONFIG_FILE"

echo ''
echo  'completat'
