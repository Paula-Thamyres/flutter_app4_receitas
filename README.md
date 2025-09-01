# 🍲 App de Receitas com Flutter + Supabase

Aplicativo de receitas desenvolvido em **Flutter**, utilizando **Supabase** para autenticação e armazenamento de dados.  
O projeto segue uma arquitetura organizada em camadas para facilitar a manutenção, escalabilidade e testes.  
Além do desenvolvimento, realizei também todo o processo de **deploy para produção**, incluindo a configuração de chaves de assinatura e a geração do **APK assinado**, pronto para publicação.

---

## 👩‍💻 Autora

Desenvolvido por **Paula Thamyres** 💜  
[GitHub](https://github.com/Paula-Thamyres)

---
## 🚀 Tecnologias Utilizadas

- [Flutter](https://flutter.dev/) — Framework para desenvolvimento multiplataforma  
- [Dart](https://dart.dev/) — Linguagem de programação  
- [Supabase](https://supabase.com/) — Backend-as-a-Service (autenticação e banco de dados)  
- [Provider](https://pub.dev/packages/provider) — Gerenciamento de estado  
- Arquitetura limpa em camadas: **UI, Domínio, Dados, Core**

---

## 📂 Estrutura de Pastas

```plaintext
lib/
├── ui/
│   ├── screens/
│   │   ├── login_screen.dart
│   │   └── recipes_screen.dart
│   ├── controllers/
│   │   ├── login_controller.dart
│   │   └── recipes_controller.dart
│   └── widgets/
│       └── drawer_widget.dart
│
├── domain/
│   ├── entities/
│   │   ├── recipe_entity.dart
│   │   └── user_entity.dart
│   ├── repositories/
│   │   └── auth_contract.dart
│   └── usecases/
│       └── authenticate_user.dart
│
├── data/
│   ├── services/
│   │   └── supabase_auth_service.dart
│   ├── repositories/
│   │   └── recipe_data_repository.dart
│   └── sources/
│       ├── supabase_source.dart
│       └── local_cache.dart
│
└── core/
    ├── di/
    │   └── injector.dart
    ├── routing/
    │   └── app_routes.dart
    └── errors/
        └── app_failure.dart
```

---

## ⚙️ Configuração do Projeto

### 1️⃣ Pré-requisitos
- [Flutter SDK](https://docs.flutter.dev/get-started/install)  
- [Dart](https://dart.dev/get-dart)  
- Conta no [Supabase](https://supabase.com/)  

### 2️⃣ Clone o repositório
```bash
git clone https://github.com/Paula-Thamyres/seu_projeto.git
cd flutter_app4_receitas
```

### 3️⃣ Instale as dependências
```bash
flutter pub get
```

### 4️⃣ Configure o ambiente
Crie um arquivo **`.env`** na raiz do projeto:

```env
SUPABASE_URL=https://vxdrunmmwoafyokaarfr.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ4ZHJ1bm1td29hZnlva2FhcmZyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ0MzE0OTYsImV4cCI6MjA3MDAwNzQ5Nn0.iOQQw5VnXvJMSdgTsOC__V47eEgY-7Ym2435W0c5OGo
```

### 5️⃣ Execute o projeto
```bash
flutter run
```

---

## 📦 Deploy e Geração de APK

Durante o processo de entrega, realizei todas as etapas para preparar a aplicação para produção:

  1. Criação e configuração do keystore para assinatura do app.

  2. Ajuste do arquivo key.properties e integração no Gradle.

  3. Build otimizado por arquitetura:
```bash
flutter build apk --split-per-abi
```
  4. Resultado: APK assinado gerado com sucesso, pronto para ser instalado em dispositivos Android ou publicado na Play Store.

  ➡️ Esse processo garante segurança, versionamento adequado e compatibilidade com múltiplos dispositivos.

---

## 🛠️ Estrutura de Branches

- `main` → versão estável  
- `dev` → branch de desenvolvimento  
- `feature/*` → novas funcionalidades  
  - ex: `feature/authentication`, `feature/recipes`  
- `fix/*` → correções específicas  
  - ex: `fix/login-error`  

---

## ✨ Convenção de Commits

Adotamos commits descritivos e com ícones para fácil leitura:

- `✨ feat(ui): adiciona tela de login com Supabase`
- `🛠️ refactor(domain): renomeia recipe.dart para recipe_entity.dart`
- `🐛 fix(auth): trata erro de e-mail não confirmado`
- `🚀 chore: configuração inicial do Supabase`
- `🧪 test(auth): cria mocks para autenticação`
- `📚 docs: atualiza README com fluxo de autenticação`

---

## 📌 Observações

- O arquivo **`.gitignore`** já está configurado para ignorar build, cache, configurações locais e `.env`.  
- Sempre mantenha o **`.env`** fora do versionamento para proteger as chaves sensíveis.  
- Estrutura organizada para facilitar evolução e manutenção.
- O projeto foi desenvolvido do zero até a entrega em produção, incluindo o build final assinado.

---

# 🔑 Supabase Config

# URL projeto no Supabase
SUPABASE_URL=https://vxdrunmmwoafyokaarfr.supabase.co

# Chave anônima (anon key) gerada pelo Supabase
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ4ZHJ1bm1td29hZnlva2FhcmZyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ0MzE0OTYsImV4cCI6MjA3MDAwNzQ5Nn0.iOQQw5VnXvJMSdgTsOC__V47eEgY-7Ym2435W0c5OGo

# =========================
# ⚙️ Configurações do App

# Ambiente atual (development | production)
APP_ENV=development

# Nome do aplicativo
APP_NAME=AppReceitas

# URL base da API (se usar backend adicional)
API_BASE_URL=http://localhost:3000


===============
📘 .gitignore

# Flutter/Dart/Pub related
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
build/
coverage/

# IntelliJ related
*.iml
.idea/

# VS Code related
.vscode/

# macOS/Linux/Windows system files
.DS_Store
*.lock
*.log

# Environment variables
.env
.env.*

# Others
*.bak
*.tmp
*.swp
