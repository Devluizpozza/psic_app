<div align="center">

# PsicApp

**Plataforma mobile de agendamento de consultas psicológicas**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7.2+-0175C2?style=flat-square&logo=dart)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=black)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

</div>

---

## Sobre o Projeto

O **PsicApp** é uma plataforma mobile desenvolvida em Flutter que conecta **pacientes** a **psicólogos**, facilitando o processo de triagem de saúde mental, descoberta de profissionais e agendamento de consultas.

O app oferece fluxos distintos para cada perfil de usuário — pacientes podem realizar uma triagem inicial, buscar psicólogos por especialidade e agendar sessões; psicólogos gerenciam sua agenda e acompanham os pacientes vinculados.

---

## Funcionalidades

### Para Pacientes
- Triagem de saúde mental (estado emocional, nível de ansiedade, dificuldades)
- Busca e seleção de psicólogos por especialidade
- Agendamento de consultas com escolha de horário disponível
- Histórico e acompanhamento de consultas

### Para Psicólogos
- Gerenciamento de perfil profissional com especialidade
- Agenda/calendário de consultas
- Acompanhamento de pacientes vinculados
- Gerenciamento de horários disponíveis

### Geral
- Autenticação via número de telefone (SMS) e Google Sign-In
- Seleção de perfil no cadastro (Paciente ou Psicólogo)
- Upload de foto de perfil
- Serviços de geolocalização e mapas
- Detecção de conectividade de rede
- Interface responsiva para Android, iOS e Web

---

## Stack Tecnológica

| Camada | Tecnologia |
|---|---|
| Framework | Flutter |
| Linguagem | Dart 3.7.2+ |
| Autenticação | Firebase Auth (Telefone + Google) |
| Banco de Dados | Cloud Firestore |
| Armazenamento | Firebase Storage |
| Gerenciamento de Estado | GetX |
| Geolocalização | Geolocator + Flutter Map |
| HTTP | http |
| Arquitetura | Clean Architecture (Domain / Data / Presentation) |

---

## Arquitetura

O projeto segue os princípios de **Clean Architecture** com separação clara em três camadas:

```
lib/
└── app/
    ├── core/           # Utilitários, tema, constantes, extensões
    ├── data/           # Repositórios, datasources (Firestore), serviços
    ├── domain/         # Modelos de domínio (entidades de negócio)
    └── presentation/   # UI, controllers (GetX), rotas e bindings
```

**Padrões utilizados:**
- Repository Pattern para abstração de acesso a dados
- Service Locator com GetX para injeção de dependência
- GetPages + Bindings para gerenciamento de dependências por rota
- Reactive State com variáveis `Rx` do GetX

---

## Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (canal stable)
- [Dart SDK](https://dart.dev/get-dart) 3.7.2+
- [Android Studio](https://developer.android.com/studio) ou [VS Code](https://code.visualstudio.com/) com extensão Flutter
- Conta e projeto configurado no [Firebase Console](https://console.firebase.google.com/)
- Para iOS: macOS com Xcode instalado

---

## Instalação e Configuração

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/psic_app.git
cd psic_app
```

### 2. Instale as dependências

```bash
flutter pub get
```

### 3. Configure o Firebase

Este projeto utiliza Firebase como backend. É necessário configurar seu próprio projeto no Firebase Console e adicionar os arquivos de configuração:

**Android:**
1. Acesse o [Firebase Console](https://console.firebase.google.com/) e crie um projeto
2. Adicione um app Android com o package name do projeto
3. Baixe o arquivo `google-services.json`
4. Coloque-o em `android/app/google-services.json`

**iOS:**
1. Adicione um app iOS no mesmo projeto Firebase
2. Baixe o arquivo `GoogleService-Info.plist`
3. Coloque-o em `ios/Runner/GoogleService-Info.plist`

**Serviços necessários no Firebase:**
- Authentication — habilite os provedores: **Telefone** e **Google**
- Cloud Firestore — crie o banco de dados
- Firebase Storage — habilite o armazenamento

### 4. Execute o projeto

```bash
# Verifica o ambiente Flutter
flutter doctor

# Executa em modo debug
flutter run

# Executa em plataforma específica
flutter run -d android
flutter run -d ios
flutter run -d chrome   # Web
```

---

## Build de Produção

```bash
# Android (APK)
flutter build apk --release

# Android (App Bundle — recomendado para Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

---

## Estrutura de Pastas

```
psic_app/
├── lib/
│   ├── main.dart
│   └── app/
│       ├── core/
│       │   ├── constants/       # Enums e constantes da aplicação
│       │   ├── extensions/      # Extension methods
│       │   ├── theme/           # Paleta de cores
│       │   └── utils/           # Validadores, formatadores, utilitários
│       │
│       ├── data/
│       │   ├── datasources/     # Configuração e referências do Firestore
│       │   ├── repositories/    # Acesso a dados (9 repositórios)
│       │   └── services/        # Geolocalização, upload de imagens, conectividade
│       │
│       ├── domain/
│       │   └── models/          # Entidades de negócio (AppUser, Patient, Psychologist, Schedule...)
│       │
│       └── presentation/
│           ├── modules/         # Módulos de feature (auth, home, patient, schedule, agenda...)
│           ├── routes/          # Definição de rotas e páginas
│           └── shared/          # Controllers, componentes e handlers compartilhados
│
├── android/
├── ios/
├── web/
├── windows/
├── macos/
├── linux/
├── assets/
│   └── images/
├── test/
├── pubspec.yaml
└── README.md
```

---

## Modelos de Domínio Principais

| Modelo | Descrição |
|---|---|
| `AppUser` | Perfil base do usuário com papel (paciente/psicólogo) e etapa de onboarding |
| `Patient` | Dados específicos do paciente |
| `Psychologist` | Dados do psicólogo com especialidade |
| `Schedule` | Consulta agendada com status (`solicitada`, `agendada`, `cancelada`) |
| `TimeSlot` | Horários disponíveis para agendamento |
| `Follower` | Vínculo entre paciente e psicólogo |

---

## Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do repositório
2. Crie uma branch para sua feature (`git checkout -b feature/minha-feature`)
3. Realize as alterações e faça commit (`git commit -m 'feat: adiciona minha feature'`)
4. Envie para a branch (`git push origin feature/minha-feature`)
5. Abra um Pull Request

---

## Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

<div align="center">
  Desenvolvido por <strong>Luiz Pozza</strong>
</div>
