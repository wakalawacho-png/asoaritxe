#!/bin/bash

CONFIG_FILE="security/configPorts.conf"
LOG_FILE="security/grups.log"
MAX_LOG_SIZE=1048576  # 1MB
USER_EXEC=$(whoami)

declare -A PROCESSED

log(){
    LEVEL=$1
    MSG=$2
    echo "$(date '+%Y-%m-%d %H:%M:%S'):$LEVEL:$USER_EXEC:$MSG" >> "$LOG_FILE"
}

rotate_logs(){
    if [ -f "$LOG_FILE" ]; then
        SIZE=$(stat -c%s "$LOG_FILE")
        if [ "$SIZE" -gt "$MAX_LOG_SIZE" ]; then
            gzip -c "$LOG_FILE" > "$LOG_FILE.gz.1"
            > "$LOG_FILE"
            log INF "Rotacio de logs executada"
        fi
    fi
}

# validar fitxer config
if [ ! -f "$CONFIG_FILE" ]; then
    echo "ERROR: no existeix configPorts.conf"
    log ERR "Fitxer config no trobat"
    exit 1
fi

if [ ! -r "$CONFIG_FILE" ]; then
    echo "ERROR: no tens permisos per llegir configPorts.conf"
    log ERR "Sense permisos per llegir config"
    exit 1
fi

log INF "Execucio del script iniciada"

rotate_logs

# obtenir SG existents
EXISTING_SG=$(aws ec2 describe-security-groups \
    --query "SecurityGroups[*].GroupName" \
    --output text)

VALID_SG_LIST="default"

while IFS= read -r line; do
    [ -z "$line" ] && continue

    SERVICE=$(echo "$line" | cut -d ':' -f1)
    PORTS=$(echo "$line" | cut -d ':' -f2)

    # evitar duplicats
    if [[ -n "${PROCESSED[$SERVICE]}" ]]; then
        log WAR "Servei duplicat ignorat: $SERVICE"
        continue
    fi
    PROCESSED[$SERVICE]=1

    # determinar SG
    if [ "$SERVICE" == "ssh" ]; then
        SG_NAME="default"
    else
        SG_NAME="$SERVICE"
        VALID_SG_LIST="$VALID_SG_LIST $SERVICE"
    fi

    # obtenir ID SG
    SG_ID=$(aws ec2 describe-security-groups \
        --filters Name=group-name,Values=$SG_NAME \
        --query "SecurityGroups[0].GroupId" \
        --output text)

    # crear si no existeix
    if [ "$SG_ID" = "None" ] || [ -z "$SG_ID" ]; then
        SG_ID=$(aws ec2 create-security-group \
            --group-name "$SG_NAME" \
            --description "$SG_NAME security group" \
            --query "GroupId" \
            --output text)

        log INF "Creat SG: $SG_NAME ($SG_ID)"
    fi

    # ports definits
    IFS=',' read -ra PORT_ARRAY <<< "$PORTS"

    declare -A ALLOWED_PORTS

    for entry in "${PORT_ARRAY[@]}"; do
        PROTOCOL=$(echo "$entry" | cut -d '/' -f1)
        PORT=$(echo "$entry" | cut -d '/' -f2)

        ALLOWED_PORTS["$PROTOCOL/$PORT"]=1

        # comprovar si existeix
        RULE=$(aws ec2 describe-security-groups \
            --group-ids "$SG_ID" \
            --query "SecurityGroups[0].IpPermissions[?IpProtocol==\`$PROTOCOL\` && FromPort<=\`$PORT\` && ToPort>=\`$PORT\`]" \
            --output text)

        if [ -z "$RULE" ]; then
            aws ec2 authorize-security-group-ingress \
                --group-id "$SG_ID" \
                --protocol "$PROTOCOL" \
                --port "$PORT" \
                --cidr 0.0.0.0/0

            log INF "Obert port $PORT/$PROTOCOL en $SG_NAME"
        fi
    done

    # eliminar ports sobrants
    EXISTING_RULES=$(aws ec2 describe-security-groups \
        --group-ids "$SG_ID" \
        --query "SecurityGroups[0].IpPermissions[*].[IpProtocol,FromPort,ToPort]" \
        --output text)

    while read proto from to; do
        KEY="$proto/$from"
        if [[ -z "${ALLOWED_PORTS[$KEY]}" ]]; then
            aws ec2 revoke-security-group-ingress \
                --group-id "$SG_ID" \
                --protocol "$proto" \
                --port "$from" \
                --cidr 0.0.0.0/0

            log WAR "Eliminat port $from/$proto de $SG_NAME"
        fi
    done <<< "$EXISTING_RULES"

done < "$CONFIG_FILE"

# eliminar SG sobrants
for sg in $EXISTING_SG; do
    if [[ "$sg" != "default" && ! " $VALID_SG_LIST " =~ " $sg " ]]; then

        SG_ID=$(aws ec2 describe-security-groups \
            --filters Name=group-name,Values=$sg \
            --query "SecurityGroups[0].GroupId" \
            --output text)

        # comprovar si esta associat
        ATTACHED=$(aws ec2 describe-network-interfaces \
            --filters Name=group-id,Values=$SG_ID \
            --query "NetworkInterfaces[*]" \
            --output text)

        if [ -z "$ATTACHED" ]; then
            aws ec2 delete-security-group --group-id "$SG_ID"
            log WAR "eliminat SG no utilitzat: $sg"
        else
            log WAR "No es pot eliminar SG $sg (en ús)"
        fi
    fi
done

log INF "Execucio completada correctament"
echo " Sistema verificat i corregit"
