<div align="center">

<img src="assets/images/logo.png" alt="PsicApp Logo" width="120" />

# Amplsic

**Plataforma mobile de saúde mental e agendamento de consultas psicológicas**
**Mobile platform for mental health care and psychology appointment scheduling**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7.2+-0175C2?style=flat-square&logo=dart)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=black)](https://firebase.google.com)
[![GetX](https://img.shields.io/badge/GetX-4.7-9C27B0?style=flat-square)](https://pub.dev/packages/get)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

</div>

---

> 🇧🇷 [Português](#-português) · 🇺🇸 [English](#-english)

---

## 🇧🇷 Português

### Sobre o Projeto

O **PsicApp** é uma aplicação mobile desenvolvida em Flutter que conecta **pacientes** a **psicólogos**, facilitando o processo de triagem de saúde mental, busca por profissionais e agendamento de consultas.

A plataforma oferece fluxos distintos para cada perfil:
- **Pacientes** realizam uma triagem inicial de saúde mental, buscam psicólogos por especialidade e agendam sessões
- **Psicólogos** gerenciam seus horários disponíveis, acompanham sua agenda e visualizam os pacientes vinculados

---

### Funcionalidades

#### Para Pacientes
- Triagem de saúde mental com estado emocional, nível de ansiedade e descrição de dificuldades
- Busca e filtragem de psicólogos por especialidade
- Visualização de horários disponíveis e agendamento de consultas
- Acompanhamento de consultas agendadas

#### Para Psicólogos
- Gerenciamento de horários disponíveis (TimeSlots) por data
- Agenda/calendário de consultas
- Visualização de pacientes vinculados
- Controle de status das consultas

#### Geral
- Autenticação por número de telefone (SMS) e Google Sign-In
- Seleção de perfil no cadastro (Paciente ou Psicólogo)
- Upload de foto de perfil
- Geolocalização e mapas integrados
- Detecção de conectividade de rede
- Interface responsiva para Android, iOS e Web

---

### Stack Tecnológica

| Camada | Tecnologia |
|---|---|
| Framework | Flutter |
| Linguagem | Dart 3.7.2+ |
| Autenticação | Firebase Auth (Telefone + Google) |
| Banco de Dados | Cloud Firestore |
| Armazenamento | Firebase Storage |
| Gerenciamento de Estado | GetX |
| Geolocalização | Geolocator + Flutter Map |
| Internacionalização | intl (pt_BR) |
| Arquitetura | Clean Architecture |

---

### Arquitetura

O projeto segue os princípios de **Clean Architecture** com separação em três camadas:

```
lib/
└── app/
    ├── core/           # Utilitários, tema, constantes, extensões
    ├── data/           # Repositórios, datasources (Firestore), serviços
    ├── domain/         # Modelos de domínio (entidades de negócio)
    └── presentation/   # UI, controllers (GetX), rotas e bindings
```

**Padrões utilizados:**
- **Repository Pattern** — abstração de acesso a dados
- **Service Locator** via GetX — injeção de dependência por rota
- **GetPages + Bindings** — gerenciamento de dependências escopado por rota
- **Reactive State** — variáveis `Rx` do GetX para estado reativo

---

### Modelos de Domínio

| Modelo | Descrição |
|---|---|
| `AppUser` | Perfil base com papel (paciente/psicólogo) e etapa de onboarding |
| `Patient` | Dados específicos do paciente |
| `Psychologist` | Dados do psicólogo com especialidade |
| `Schedule` | Consulta com status (`solicitada`, `agendada`, `cancelada`) |
| `TimeSlot` | Horário disponível para agendamento |
| `Follower` | Vínculo entre paciente e psicólogo |

---

### Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (canal stable)
- [Dart SDK](https://dart.dev/get-dart) 3.7.2+
- [Android Studio](https://developer.android.com/studio) ou [VS Code](https://code.visualstudio.com/) com a extensão Flutter
- [Git](https://git-scm.com/)
- Conta e projeto configurado no [Firebase Console](https://console.firebase.google.com/)
- Para iOS: macOS com Xcode instalado

---

### Como Baixar e Rodar Localmente

#### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/psic_app.git
cd psic_app
```

#### 2. Instale as dependências

```bash
flutter pub get
```

#### 3. Configure o Firebase

Este projeto utiliza o Firebase como backend. É necessário configurar seu próprio projeto e adicionar os arquivos de configuração:

**Android:**
1. Acesse o [Firebase Console](https://console.firebase.google.com/) e crie um projeto
2. Adicione um app Android com o package name `com.example.psicApp`
3. Baixe o arquivo `google-services.json`
4. Coloque-o em `android/app/google-services.json`

**iOS:**
1. Adicione um app iOS no mesmo projeto Firebase
2. Baixe o arquivo `GoogleService-Info.plist`
3. Coloque-o em `ios/Runner/GoogleService-Info.plist`

**Serviços necessários no Firebase Console:**
- **Authentication** — habilite os provedores: Telefone e Google
- **Cloud Firestore** — crie o banco de dados (modo de teste para desenvolvimento)
- **Firebase Storage** — habilite o armazenamento

#### 4. Verifique o ambiente

```bash
flutter doctor
```

#### 5. Execute o projeto

```bash
# Modo debug (qualquer dispositivo conectado)
flutter run

# Plataforma específica
flutter run -d android
flutter run -d ios
flutter run -d chrome      # Web
```

---

### Build de Produção

```bash
# Android — APK
flutter build apk --release

# Android — App Bundle (recomendado para Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

---

### Estrutura de Pastas

```
psic_app/
├── lib/
│   ├── main.dart
│   └── app/
│       ├── core/
│       │   ├── constants/       # Enums e constantes da aplicação
│       │   ├── extensions/      # Extension methods
│       │   ├── theme/           # Paleta de cores (AppColors)
│       │   └── utils/           # Validadores, formatadores, utilitários
│       │
│       ├── data/
│       │   ├── datasources/     # Configuração e referências do Firestore
│       │   ├── repositories/    # Camada de acesso a dados
│       │   └── services/        # Geolocalização, upload de imagens, conectividade
│       │
│       ├── domain/
│       │   └── models/          # Entidades de negócio
│       │
│       └── presentation/
│           ├── modules/         # Módulos de feature (auth, home, patient, schedule...)
│           ├── routes/          # Definição de rotas e páginas
│           └── shared/          # Controllers, componentes e handlers compartilhados
│
├── test/                        # Testes unitários
├── android/
├── ios/
├── web/
├── assets/
│   └── images/
├── pubspec.yaml
└── README.md
```

---

### Testes

```bash
# Rodar todos os testes
flutter test

# Rodar um arquivo específico
flutter test test/schedule_owner_list_controller_test.dart --reporter=expanded
```

---

### Contribuindo

Contribuições são bem-vindas!

1. Faça um fork do repositório
2. Crie uma branch para sua feature (`git checkout -b feature/minha-feature`)
3. Commit suas alterações seguindo [Conventional Commits](https://www.conventionalcommits.org/pt-br/) (`git commit -m 'feat: adiciona minha feature'`)
4. Envie para a branch (`git push origin feature/minha-feature`)
5. Abra um Pull Request

---

### Licença

Este projeto está sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.

---

<br/>

---

## 🇺🇸 English

### About

**PsicApp** is a Flutter mobile application that connects **patients** with **psychologists**, streamlining the mental health triage process, professional discovery, and appointment scheduling.

The platform provides distinct flows for each user role:
- **Patients** complete an initial mental health assessment, search for psychologists by specialty, and book sessions
- **Psychologists** manage their available time slots, view their agenda, and track linked patients

---

### Features

#### For Patients
- Mental health triage with emotional state, anxiety level, and difficulty description
- Search and filter psychologists by specialty
- View available time slots and book appointments
- Track scheduled appointments

#### For Psychologists
- Available time slot management (TimeSlots) per date
- Appointments agenda/calendar view
- Linked patient tracking
- Appointment status control

#### General
- Phone number authentication (SMS) and Google Sign-In
- Role selection during registration (Patient or Psychologist)
- Profile photo upload
- Geolocation and map services
- Network connectivity detection
- Responsive interface for Android, iOS, and Web

---

### Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| Language | Dart 3.7.2+ |
| Authentication | Firebase Auth (Phone + Google) |
| Database | Cloud Firestore |
| Storage | Firebase Storage |
| State Management | GetX |
| Geolocation | Geolocator + Flutter Map |
| Internationalization | intl (pt_BR) |
| Architecture | Clean Architecture |

---

### Architecture

The project follows **Clean Architecture** principles with a clear three-layer separation:

```
lib/
└── app/
    ├── core/           # Utilities, theme, constants, extensions
    ├── data/           # Repositories, datasources (Firestore), services
    ├── domain/         # Domain models (business entities)
    └── presentation/   # UI, controllers (GetX), routes, and bindings
```

**Design patterns used:**
- **Repository Pattern** — data access abstraction
- **Service Locator** via GetX — route-scoped dependency injection
- **GetPages + Bindings** — route-scoped dependency management
- **Reactive State** — GetX `Rx` variables for reactive state

---

### Domain Models

| Model | Description |
|---|---|
| `AppUser` | Base user profile with role (patient/psychologist) and onboarding step |
| `Patient` | Patient-specific data |
| `Psychologist` | Psychologist data with specialty field |
| `Schedule` | Appointment with status (`requested`, `scheduled`, `cancelled`) |
| `TimeSlot` | Available appointment time slot |
| `Follower` | Patient-psychologist relationship tracking |

---

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- [Dart SDK](https://dart.dev/get-dart) 3.7.2+
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with the Flutter extension
- [Git](https://git-scm.com/)
- A project configured in the [Firebase Console](https://console.firebase.google.com/)
- For iOS: macOS with Xcode installed

---

### Getting Started (Local Setup)

#### 1. Clone the repository

```bash
git clone https://github.com/your-username/psic_app.git
cd psic_app
```

#### 2. Install dependencies

```bash
flutter pub get
```

#### 3. Configure Firebase

This project uses Firebase as its backend. You need to set up your own project and add the configuration files:

**Android:**
1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a project
2. Add an Android app with the package name `com.example.psicApp`
3. Download `google-services.json`
4. Place it at `android/app/google-services.json`

**iOS:**
1. Add an iOS app to the same Firebase project
2. Download `GoogleService-Info.plist`
3. Place it at `ios/Runner/GoogleService-Info.plist`

**Required Firebase services:**
- **Authentication** — enable providers: Phone and Google
- **Cloud Firestore** — create the database (test mode for development)
- **Firebase Storage** — enable storage

#### 4. Check your environment

```bash
flutter doctor
```

#### 5. Run the project

```bash
# Debug mode (any connected device)
flutter run

# Specific platform
flutter run -d android
flutter run -d ios
flutter run -d chrome      # Web
```

---

### Production Build

```bash
# Android — APK
flutter build apk --release

# Android — App Bundle (recommended for Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

---

### Folder Structure

```
psic_app/
├── lib/
│   ├── main.dart
│   └── app/
│       ├── core/
│       │   ├── constants/       # App enums and constants
│       │   ├── extensions/      # Extension methods
│       │   ├── theme/           # Color palette (AppColors)
│       │   └── utils/           # Validators, formatters, utilities
│       │
│       ├── data/
│       │   ├── datasources/     # Firestore setup and collection references
│       │   ├── repositories/    # Data access layer
│       │   └── services/        # Geolocation, image upload, connectivity
│       │
│       ├── domain/
│       │   └── models/          # Business entities
│       │
│       └── presentation/
│           ├── modules/         # Feature modules (auth, home, patient, schedule...)
│           ├── routes/          # Route definitions and pages
│           └── shared/          # Shared controllers, components, and handlers
│
├── test/                        # Unit tests
├── android/
├── ios/
├── web/
├── assets/
│   └── images/
├── pubspec.yaml
└── README.md
```

---

### Running Tests

```bash
# Run all tests
flutter test

# Run a specific file
flutter test test/schedule_owner_list_controller_test.dart --reporter=expanded
```

---

### Contributing

Contributions are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes following [Conventional Commits](https://www.conventionalcommits.org/) (`git commit -m 'feat: add my feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a Pull Request

---

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

<div align="center">
  Developed by <strong>Luiz Pozza</strong>
</div>
