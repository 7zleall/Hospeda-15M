#!/bin/bash

# Configurações de cores personalizadas
export DIALOGRC=$(mktemp)
echo "screen_color = (WHITE,MAGENTA,ON)
border_color = (WHITE,MAGENTA,ON)
title_color = (YELLOW,MAGENTA,ON)
button_active_color = (BLACK,CYAN,ON)" > "$DIALOGRC"

# Diretório base do script
BASE_DIR=$(dirname "$(realpath "$0")")

# Função para escolher a linguagem do bot
choose_language() {
    dialog --title " Hospeda 15M " --menu "Escolha a linguagem do bot:" 15 50 4 \
    1 "Python" \
    2 "Java" \
    3 "JavaScript (Node.js)" \
    4 "Outra" 2>&1 >/dev/tty
}

# Função para encontrar o arquivo do bot
find_bot_file() {
    dialog --inputbox "Insira o caminho completo do arquivo do bot:" 10 50 2> "$BASE_DIR/bot_file.txt"
    FILE=$(cat "$BASE_DIR/bot_file.txt")

    if [ -f "$FILE" ]; then
        echo "$FILE"
    else
        echo ""
    fi
}

# Função para iniciar o bot
start_bot() {
    LANGUAGE=$(choose_language)
    dialog --title " Hospeda 15M " --inputbox "Insira o nome do bot (ex: lealzin):" 10 50 2> "$BASE_DIR/bot_name.txt"
    BOT_NAME=$(cat "$BASE_DIR/bot_name.txt")

    if [ -z "$BOT_NAME" ]; then
        dialog --msgbox "Nome do bot não pode ser vazio!" 10 50
        return
    fi

    BOT_FILE=$(find_bot_file)

    if [ -z "$BOT_FILE" ]; then
        dialog --msgbox "Arquivo do bot não encontrado!" 10 50
        return
    fi

    case $LANGUAGE in
        1) COMMAND="python \"$BOT_FILE\"" ;;
        2) javac "$BOT_FILE" && COMMAND="java -cp $(dirname "$BOT_FILE") $(basename "$BOT_FILE" .java)" ;;
        3) COMMAND="node \"$BOT_FILE\"" ;;
        4) COMMAND="bash \"$BOT_FILE\"" ;;
        *) dialog --msgbox "Opção inválida!" 10 50
           return ;;
    esac

    tmux new-session -d -s "$BOT_NAME" "$COMMAND"
    dialog --msgbox "Bot $BOT_NAME iniciado com sucesso!" 10 50
}

# Função para desligar o bot
stop_bot() {
    dialog --inputbox "Insira o nome do bot:" 10 50 2> "$BASE_DIR/bot_name.txt"
    BOT_NAME=$(cat "$BASE_DIR/bot_name.txt")

    if [ -z "$BOT_NAME" ]; then
        dialog --msgbox "Nome do bot não pode ser vazio!" 10 50
        return
    fi

    tmux kill-session -t "$BOT_NAME" 2>/dev/null &&
    dialog --msgbox "Bot $BOT_NAME desligado com sucesso!" 10 50 ||
    dialog --msgbox "Erro ao parar o bot!" 10 50
}

# Função para verificar status do bot
check_bot_status() {
    dialog --inputbox "Insira o nome do bot:" 10 50 2> "$BASE_DIR/bot_name.txt"
    BOT_NAME=$(cat "$BASE_DIR/bot_name.txt")

    if [ -z "$BOT_NAME" ]; then
        dialog --msgbox "Nome do bot não pode ser vazio!" 10 50
        return
    fi

    if tmux has-session -t "$BOT_NAME" 2>/dev/null; then
        dialog --msgbox "O bot $BOT_NAME está rodando." 10 50
    else
        dialog --msgbox "O bot $BOT_NAME não está rodando." 10 50
    fi
}

# Loop principal do menu
while true; do
    choice=$(dialog --title " Hospeda 15M " --menu "by 7zlealzx" 15 50 5 \
    1 "Ligar bot" \
    2 "Desligar bot" \
    3 "Verificar status do bot" \
    4 "Hospedar bot" \
    5 "Sair" 2>&1 >/dev/tty)

    case $choice in
        1) start_bot ;;
        2) stop_bot ;;
        3) check_bot_status ;;
        4) start_bot ;;
        5) dialog --msgbox "Saindo..." 10 50
           break ;;
        *) dialog --msgbox "Opção inválida!" 10 50 ;;
    esac
done
