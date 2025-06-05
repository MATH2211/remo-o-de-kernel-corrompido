Script: fixar-kernel.sh

Este script tem como objetivo facilitar o gerenciamento de versões do kernel no Fedora, especialmente em situações onde uma nova versão do kernel apresenta bugs ou incompatibilidades (como falha no reconhecimento do Wi-Fi).

📅 Objetivo do Script

Definir um kernel específico como padrão no GRUB

Remover o kernel com problemas (versão bugada)

Remover o kernel antigo de backup (caso o atual esteja funcionando perfeitamente)

Automatizar e documentar todo o processo com mensagens claras no terminal

⚙️ Requisitos

Sistema operacional: Fedora Linux

Acesso root (sudo)

Terminal bash

🔧 Como usar

Clone ou copie o script:

Salve o script fixar-kernel.sh no diretório desejado (ex: ~/Documentos).

Dê permissão de execução:

chmod +x fixar-kernel.sh

Execute como root:

sudo ./fixar-kernel.sh

🔢 Lógica do Script

Verifica se o usuário tem permissão root

Lista os kernels instalados usando rpm -q kernel-core

Define como padrão o kernel desejado via grub2-set-default

Remove o kernel bugado (se ainda estiver instalado)

Verifica qual é o kernel atualmente em uso com:

uname -r

Se o kernel atual for o funcional, remove o kernel antigo de backup

🔹 Variáveis editáveis no script

O script pode ser facilmente adaptado para outras versões, basta editar estas variáveis dentro do arquivo:

KERNEL_OK="Fedora Linux (6.13.9-200.fc41.x86_64) 41 (Workstation Edition)"
KERNEL_OK_VERSAO="kernel-core-6.13.9-200.fc41.x86_64"
KERNEL_ANTIGO_VERSAO="kernel-core-6.13.7-200.fc41.x86_64"
KERNEL_BUGADO="kernel-core-6.14.2-300.fc42.x86_64"

Use o comando abaixo para ver todos os kernels instalados no seu sistema e ajustar os nomes conforme sua necessidade:

rpm -q kernel-core

🚀 Resultado Esperado

O kernel estável será definido como padrão no boot

O kernel bugado será removido

O kernel antigo de backup será removido (se seguro)

📢 Atenção: não remova todos os kernels se não tiver certeza que o kernel atual está 100% funcional.

Feito com ❤️ por Matheus (usuário Fedora)

