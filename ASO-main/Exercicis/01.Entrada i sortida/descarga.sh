#!/bin/bash
mkdir aptaut 2>> /dev/null
wget -P aptaut $1 >> aptaut/apt.log 2>> aptaut/apt.err
ls -l aptaut >> aptaut/apt.log
