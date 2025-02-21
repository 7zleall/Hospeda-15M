# Hospeda-15M

---

# 🚀 Painel de Gerenciamento de Bots

Bem-vindo ao **Painel de Gerenciamento de Bots**! Este é um painel interativo e fácil de usar para gerenciar bots no Termux. Com ele, você pode **ligar**, **desligar**, **hospedar** e **verificar o status** dos seus bots de forma simples e rápida. Ideal para quem trabalha com bots em Python, Java, JavaScript e outras linguagens.

---

## ✨ Funcionalidades

- **✅ Ligar bot**: Inicia o bot com um comando simples.
- **❌ Desligar bot**: Para o bot de forma segura.
- **🌐 Hospedar bot**: Roda o bot em segundo plano usando `tmux`.
- **🔍 Verificar status**: Confira se o bot está rodando.
- **🎨 Interface amigável**: Menu interativo com cores personalizadas.

---

## 🛠️ Como Instalar

Siga os passos abaixo para instalar e configurar o painel no seu Termux.

### Pré-requisitos

- **Termux**: Instale o Termux no seu dispositivo Android.
- **Git**: Para clonar o repositório.
- **Dependências**: Certifique-se de ter as dependências necessárias instaladas (Python, Java, Node.js, etc.).

### Passo a Passo

1. **Instale as dependências**:
   No Termux, execute os seguintes comandos:
   ```bash
   pkg update && pkg upgrade
   pkg install git dialog tmux python nodejs openjdk-17
   ```

2. **Clone o repositório**:
   ```bash
   git clone https://github.com/7zleall/Hospeda-15M.git
   cd Hospeda-15M
   ```

3. **Dê permissão de execução ao script**:
   ```bash
   chmod +x setup.sh
   ```

4. **Execute o painel**:
   ```bash
   ./setup.sh
   ```

---

## 🎮 Como Usar

O painel é super intuitivo! Basta seguir as instruções na tela.

### Passo a Passo

1. **Ligar um bot**:
   - Escolha a opção **Ligar bot**.
   - Selecione a linguagem do bot (Python, Java, JavaScript, etc.).
   - Insira o nome do bot (ex: `meu_bot`).
   - O painel iniciará o bot automaticamente.

2. **Hospedar um bot**:
   - Escolha a opção **Hospedar bot**.
   - O bot será iniciado em uma sessão `tmux` em segundo plano.

3. **Verificar o status de um bot**:
   - Escolha a opção **Verificar status do bot**.
   - Insira o nome do bot.
   - O painel informará se o bot está rodando ou não.

4. **Desligar um bot**:
   - Escolha a opção **Desligar bot**.
   - Insira o nome do bot.
   - O painel parará o bot.

---

## 🎨 Personalização

O painel é altamente personalizável! Aqui estão algumas ideias:

- **Cores**: Altere as cores do painel editando o arquivo de configuração.
- **Banner**: Adicione um banner personalizado ao painel.
- **Novas funcionalidades**: O código é modular e fácil de expandir. Adicione novas funcionalidades conforme necessário.

---

## 📂 Estrutura do Projeto

- **`setup.sh`**: Script principal do painel.
- **`README.md`**: Documentação do projeto (este arquivo).
- **`banner.txt`**: Arquivo opcional para exibir um banner personalizado.

---

## 🤝 Contribuindo

Quer contribuir para o projeto? Siga estas etapas:

1. Faça um **fork** do repositório.
2. Crie uma nova branch com sua feature ou correção:
   ```bash
   git checkout -b minha-feature
   ```
3. Faça commit das suas alterações:
   ```bash
   git commit -m "Adicionando nova funcionalidade"
   ```
4. Envie as alterações para o repositório remoto:
   ```bash
   git push origin minha-feature
   ```
5. Abra um **Pull Request** no GitHub.

---

## 📜 Licença

Este projeto está licenciado sob a **MIT License**. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 🌟 Por que Usar Este Painel?

- **Simplicidade**: Interface fácil de usar, mesmo para iniciantes.
- **Versatilidade**: Suporta múltiplas linguagens de programação.
- **Eficiência**: Gerencie seus bots de forma rápida e eficiente.
- **Customização**: Adapte o painel às suas necessidades.

---
