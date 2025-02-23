
---

# 🚀 **Hospeda 15M - Setup no Termux** 🚀

Bem-vindo ao **Hospeda 15M**! Este é um script poderoso para hospedar bots diretamente no Termux. Ele suporta bots escritos em **Python**, **Java**, **JavaScript (Node.js)** e outras linguagens. Tudo o que você precisa fazer é copiar o código e configurar o ambiente! 🤖

---

## 🎯 **O que este script faz?**
- **Hospeda bots** em segundo plano usando `tmux`.
- Suporta múltiplas linguagens: Python, Java, Node.js e mais!
- Interface interativa com menus fáceis de usar.
- Verifica se o arquivo do bot está correto antes de executar.
- Gerencia bots (iniciar, parar, verificar status) de forma simples.

---

## 🛠️ **Requisitos**
Antes de começar, você precisa ter:
- **Termux** instalado ([Google Play](https://play.google.com/store/apps/details?id=com.termux) ou [F-Droid](https://f-droid.org/en/packages/com.termux/)).
- Conexão com a internet para instalar dependências.

---

## ⚙️ **Como configurar?**

### **Passo 1: Atualize os pacotes do Termux**
Abra o Termux e execute:
```bash
pkg update && pkg upgrade
```

### **Passo 2: Instale as dependências**
Instale as ferramentas necessárias:
```bash
pkg install dialog tmux python nodejs openjdk-17
```

### **Passo 3: Copie o código do script**
Crie um arquivo chamado `setup.sh` no Termux:
```bash
nano setup.sh
```

Cole o código abaixo no arquivo e salve (`Ctrl + O`, `Enter`, `Ctrl + X`):

```bash
#!/bin/bash

# Configurações de cores personalizadas
export DIALOGRC=$(mktemp)
echo "screen_color = (WHITE,MAGENTA,ON)
border_color = (WHITE,MAGENTA,ON)
title_color = (YELLOW,MAGENTA,ON)
button_active_color = (BLACK,CYAN,ON)" > $DIALOGRC

# Função para escolher a linguagem do bot
choose_language() {
    dialog --title " Hospeda 15M " --menu "Escolha a linguagem do bot:" 15 50 4 \
        1 "Python" \
        2 "Java" \
        3 "JavaScript (Node.js)" \
        4 "Outra" \
        2>&1 >/dev/tty
}

# Função para exibir logs de depuração
debug_log() {
    echo "[DEBUG] $1"
    dialog --infobox "[DEBUG] $1" 10 50
}

# Função para encontrar o arquivo do bot
find_bot_file() {
    local BOT_NAME=$1
    local LANGUAGE=$2

    case $LANGUAGE in
        1)
            FILE="$BOT_NAME.py"
            ;;
        2)
            FILE="$BOT_NAME.java"
            ;;
        3)
            FILE="$BOT_NAME.js"
            ;;
        4)
            dialog --inputbox "Insira o nome do arquivo do bot (ex: bot):" 10 50 2> bot_file.txt
            FILE=$(cat bot_file.txt)
            ;;
        *)
            FILE=""
            ;;
    esac

    if [ -f "$FILE" ]; then
        echo "$FILE"
    else
        echo ""
    fi
}

# Função para iniciar o bot
start_bot() {
    LANGUAGE=$(choose_language)
    dialog --title " Hospeda 15M " --inputbox "Insira o nome do bot (ex: lealzin):" 10 50 2> bot_name.txt
    BOT_NAME=$(cat bot_name.txt)

    if [ -z "$BOT_NAME" ]; then
        dialog --title " Hospeda 15M " --msgbox "Nome do bot não pode ser vazio!" 10 50
        return
    fi

    BOT_FILE=$(find_bot_file "$BOT_NAME" "$LANGUAGE")

    if [ -z "$BOT_FILE" ]; then
        debug_log "Arquivo do bot não encontrado para o nome: $BOT_NAME"
        dialog --title " Hospeda 15M " --msgbox "Arquivo do bot não encontrado para o nome: $BOT_NAME" 10 50
        return
    fi

    debug_log "Arquivo do bot encontrado: $BOT_FILE"

    case $LANGUAGE in
        1)
            COMMAND="python $BOT_FILE"
            ;;
        2)
            CLASS_NAME=$(basename "$BOT_FILE" .java)
            COMMAND="java $CLASS_NAME"
            debug_log "Compilando o arquivo Java: $BOT_FILE"
            javac "$BOT_FILE"
            if [ $? -ne 0 ]; then
                debug_log "Erro ao compilar o arquivo Java!"
                dialog --title " Hospeda 15M " --msgbox "Erro ao compilar o arquivo Java!" 10 50
                return
            fi
            ;;
        3)
            COMMAND="node $BOT_FILE"
            ;;
        4)
            COMMAND="./$BOT_FILE"
            ;;
        *)
            dialog --title " Hospeda 15M " --msgbox "Opção inválida!" 10 50
            return
            ;;
    esac

    # Verifica se o bot já está rodando
    if tmux has-session -t "$BOT_NAME" 2>/dev/null; then
        debug_log "O bot $BOT_NAME já está rodando."
        dialog --title " Hospeda 15M " --msgbox "O bot $BOT_NAME já está rodando." 10 50
        return
    fi

    debug_log "Iniciando o bot $BOT_NAME com o comando: $COMMAND"
    tmux new-session -d -s "$BOT_NAME" "$COMMAND"
    if [ $? -ne 0 ]; then
        debug_log "Erro ao iniciar o bot: $BOT_NAME"
        dialog --title " Hospeda 15M " --msgbox "Erro ao iniciar o bot: $BOT_NAME" 10 50
        return
    fi

    dialog --title " Hospeda 15M " --msgbox "Bot $BOT_NAME iniciado com sucesso!" 10 50
}

# Função para desligar o bot
stop_bot() {
    dialog --title " Hospeda 15M " --inputbox "Insira o nome do bot (ex: lealzin):" 10 50 2> bot_name.txt
    BOT_NAME=$(cat bot_name.txt)

    if [ -z "$BOT_NAME" ]; then
        dialog --title " Hospeda 15M " --msgbox "Nome do bot não pode ser vazio!" 10 50
        return
    fi

    debug_log "Parando o bot: $BOT_NAME"
    tmux kill-session -t "$BOT_NAME" 2>/dev/null
    if [ $? -ne 0 ]; then
        debug_log "Erro ao parar o bot: $BOT_NAME"
        dialog --title " Hospeda 15M " --msgbox "Erro ao parar o bot: $BOT_NAME" 10 50
        return
    fi

    dialog --title " Hospeda 15M " --msgbox "Bot $BOT_NAME desligado com sucesso!" 10 50
}

# Função para verificar o status do bot
check_bot_status() {
    dialog --title " Hospeda 15M " --inputbox "Insira o nome do bot (ex: lealzin):" 10 50 2> bot_name.txt
    BOT_NAME=$(cat bot_name.txt)

    if [ -z "$BOT_NAME" ]; then
        dialog --title " Hospeda 15M " --msgbox "Nome do bot não pode ser vazio!" 10 50
        return
    fi

    if tmux has-session -t "$BOT_NAME" 2>/dev/null; then
        dialog --title " Hospeda 15M " --msgbox "O bot $BOT_NAME está rodando." 10 50
    else
        dialog --title " Hospeda 15M " --msgbox "O bot $BOT_NAME não está rodando." 10 50
    fi
}

# Loop principal do menu
while true; do
    # Exibir o menu de opções
    choice=$(dialog --title " Hospeda 15M " --menu "by 7zlealzx" 15 50 5 \
        1 "Ligar bot" \
        2 "Desligar bot" \
        3 "Verificar status do bot" \
        4 "Hospedar bot" \
        5 "Sair" \
        2>&1 >/dev/tty)

    # Verificar a escolha do usuário
    case $choice in
        1)
            start_bot
            ;;
        2)
            stop_bot
            ;;
        3)
            check_bot_status
            ;;
        4)
            start_bot # Hospedar é o mesmo que iniciar em segundo plano
            ;;
        5)
            dialog --title " Hospeda 15M " --msgbox "Saindo..." 10 50
            break
            ;;
        *)
            dialog --title " Hospeda 15M " --msgbox "Opção inválida!" 10 50
            ;;
    esac
done
```

### **Passo 4: Torne o script executável**
Dê permissão de execução ao script:
```bash
chmod +x setup.sh
```

### **Passo 5: Execute o script**
Agora, execute o script:
```bash
./setup.sh
```

---

## 🖥️ **Como usar o script?**
O script exibirá um menu interativo com as seguintes opções:
1. **Ligar bot**: Inicia o bot.
2. **Desligar bot**: Para o bot.
3. **Verificar status do bot**: Verifica se o bot está rodando.
4. **Hospedar bot**: Inicia o bot em segundo plano.
5. **Sair**: Fecha o menu.

---

## 📂 **Organização dos arquivos**
Certifique-se de que o arquivo principal do bot (por exemplo, `index.js`, `bot.py`, `bot.java`) esteja no mesmo diretório que o script. O script usa o nome do arquivo para rodar o bot.

---

## 🚨 **Importante**
- O bot só será executado se o arquivo principal estiver correto e presente no diretório.
- Para bots em Java, o script compila o arquivo `.java` antes de executar.
- Use `tmux` para gerenciar sessões e manter o bot rodando em segundo plano.

---

## 🤝 **Contribuições**
Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

---

## 📜 **Licença**
Este projeto está licenciado sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---
