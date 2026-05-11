#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <IP_DO_ALVO>"
    exit 1
fi

TARGET_IP=$1
USERS_FILE="users.txt"
PASSWORDS_FILE="passwords.txt"

echo "-----"
echo "[*] Inicio de auditoria no alvo: $TARGET_IP"
echo "-----"

echo "[*] Executando Medusa contra o serviço FTP (Porta 21)"
medusa -h $TARGET_IP -U $USERS_FILE -P $PASSWORDS_FILE -M ftp
echo ""

echo "[*] Executando Medusa contra o serviço SMB (Portas 139/445)"
medusa -h $TARGET_IP -U $USERS_FILE -P $PASSWORDS_FILE -M smbnt

echo "-----"
echo "[*] Auditoria finalizada."
echo "-----"
