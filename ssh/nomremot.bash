#!/bin/bash
USUARI="1$"
HOST_REMOT="2$"
HOSTNAMENUEVO="3$"
ssh "$USUARI"@"$HOST_REMOT" << EOF

	hostnamectl
	hostnamectl set-hostname test
	hostnamectl
EOF
