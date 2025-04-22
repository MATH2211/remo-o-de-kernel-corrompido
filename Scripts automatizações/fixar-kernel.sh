#!/bin/bash

# ------------------------------
# Script para gerenciar kernels no Fedora
# Autor: Matheus (adaptado para uso prático)
# ------------------------------

# Solicita permissões root desde o início
if [[ $EUID -ne 0 ]]; then
    echo "[ERRO] Este script precisa ser executado como root. Use: sudo ./fixar-kernel.sh"
    exit 1
fi

# Lista os kernels instalados
echo "[INFO] Listando kernels instalados:"
rpm -q kernel-core

# Define o nome do kernel funcional que deve ser mantido (editar conforme necessário)
KERNEL_OK="Fedora Linux (6.13.9-200.fc41.x86_64) 41 (Workstation Edition)"
KERNEL_OK_VERSAO="kernel-core-6.13.9-200.fc41.x86_64"
KERNEL_ANTIGO_VERSAO="kernel-core-6.13.7-200.fc41.x86_64"
KERNEL_BUGADO="kernel-core-6.14.2-300.fc42.x86_64"

# Define como padrão no GRUB
echo "[INFO] Definindo '$KERNEL_OK' como entrada padrão do GRUB..."
grub2-set-default "$KERNEL_OK"
grub2-editenv list

# Remove kernel bugado, se estiver instalado
if rpm -q $KERNEL_BUGADO &>/dev/null; then
    echo "[INFO] Removendo kernel com problema: $KERNEL_BUGADO"
    dnf remove -y $KERNEL_BUGADO
else
    echo "[INFO] Kernel bugado já foi removido ou não está presente."
fi

# Verifica qual kernel está ativo
KERNEL_ATUAL=$(uname -r)
echo "[INFO] Kernel atual em uso: $KERNEL_ATUAL"

# Se o kernel atual for o funcional, remove o mais antigo
if [[ "$KERNEL_ATUAL" == *"6.13.9-200.fc41.x86_64"* ]]; then
    if rpm -q $KERNEL_ANTIGO_VERSAO &>/dev/null; then
        echo "[INFO] Removendo kernel antigo de backup: $KERNEL_ANTIGO_VERSAO"
        dnf remove -y $KERNEL_ANTIGO_VERSAO
    else
        echo "[INFO] Kernel antigo já foi removido."
    fi
else
    echo "[AVISO] Você está usando a versão $KERNEL_ATUAL. Não será removido nenhum kernel de backup."
fi

# Fim
echo "[SUCESSO] Configuração finalizada. Reinicie o sistema para aplicar as mudanças."
exit 0

