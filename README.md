# Muscle App - Aplicativo de Musculação

Um aplicativo completo de musculação desenvolvido em **Flutter/Dart** com gerenciamento avançado de treinos, exercícios e evolução de desempenho.

## Características Principais

### 1. **Gerenciamento de Grupos Musculares**
- 9 grupos musculares pré-configurados:
  - Bíceps, Tríceps, Ombro, Peito, Dorso
  - Anterior de Coxa, Posterior de Coxa, Panturrilha, Antebraço
- Possibilidade de adicionar grupos musculares personalizados
- Cores personalizáveis para cada grupo

### 2. **Sessões de Treino Personalizáveis**
- Criar sessões de treino com padrões ABC, ABCD, ABCDE, etc.
- Cada sessão pode conter múltiplos grupos musculares
- Organização flexível e intuitiva

### 3. **Controle de Exercícios**
- Adicionar exercícios para cada grupo muscular
- Definir:
  - Número de séries planejadas
  - Número de repetições
  - Intervalo entre séries (em segundos)
- Rastreamento detalhado de cada série

### 4. **Execução de Treino com Timer**
- **Iniciar Treino**: Comece a treinar um exercício específico
- **Série Concluída**: Registre peso (kg) e repetições reais
- **Timer de Intervalo**: Cronômetro automático entre séries
- **Pular Intervalo**: Opção para pular o intervalo se desejar
- **Ajuste de Séries**: Possibilidade de ajustar séries reais antes de finalizar

### 5. **Página de Evolução**
- **Gráfico de Evolução de Peso**: Visualize sua progressão de carga
- **Gráfico de Séries por Exercício**: Acompanhe o volume de treino
- **Estatísticas Gerais**:
  - Total de treinos realizados
  - Séries completas
  - Peso máximo levantado
- Dados visuais e interativos com fl_chart

### 6. **Persistência de Dados**
- **Banco de Dados Local**: Drift (SQLite)
- Todos os dados salvos localmente no dispositivo
- Arquitetura preparada para futuras integrações com Supabase

## Estrutura do Projeto

```
lib/
├── database/
│   ├── database.dart          # Definição do banco de dados Drift
│   └── database.g.dart        # Código gerado pelo Drift
├── providers/
│   ├── muscle_group_provider.dart      # Gerenciamento de grupos musculares
│   ├── training_session_provider.dart  # Gerenciamento de sessões
│   ├── exercise_provider.dart          # Gerenciamento de exercícios
│   └── workout_provider.dart           # Gerenciamento de treinos ativos
├── screens/
│   ├── home_screen.dart                    # Tela inicial com navegação
│   ├── training_sessions_screen.dart       # Lista de sessões
│   ├── create_training_session_screen.dart # Criar nova sessão
│   ├── training_detail_screen.dart         # Detalhes da sessão
│   ├── exercise_list_screen.dart           # Lista de exercícios
│   ├── add_exercise_screen.dart            # Adicionar exercício
│   ├── workout_screen.dart                 # Tela de execução do treino
│   └── evolution_screen.dart               # Página de evolução
└── main.dart                   # Configuração da aplicação
```

## Dependências Principais

```yaml
dependencies:
  flutter:
    sdk: flutter
  drift: ^2.30.0                    # ORM para banco de dados
  drift_flutter: ^0.2.8             # Suporte Flutter para Drift
  sqlite3_flutter_libs: ^0.5.41     # SQLite nativo
  provider: ^6.1.5+1                # Gerenciamento de estado
  fl_chart: ^1.1.1                  # Gráficos e visualizações
  intl: ^0.20.2                     # Internacionalização
  uuid: ^4.5.2                      # Geração de IDs únicos
```

## Como Usar

### Instalação

1. **Clone ou extraia o projeto**:
```bash
cd muscle_app
```

2. **Instale as dependências**:
```bash
flutter pub get
```

3. **Execute o aplicativo**:
```bash
flutter run
```

### Fluxo de Uso

#### 1. Criar uma Sessão de Treino
- Clique no botão **+** na tela de Sessões de Treino
- Defina um nome (ex: "Sessão A")
- Selecione os grupos musculares que deseja treinar
- Clique em "Criar Sessão"

#### 2. Adicionar Exercícios
- Clique em uma sessão para ver seus grupos musculares
- Clique em um grupo muscular
- Clique no botão **+** para adicionar um exercício
- Preencha:
  - Nome do exercício
  - Séries planejadas
  - Repetições planejadas
  - Intervalo entre séries (segundos)
- Clique em "Adicionar Exercício"

#### 3. Executar um Treino
- Clique em um exercício para iniciar o treino
- Para cada série:
  - Digite o peso utilizado (kg)
  - Digite as repetições realizadas
  - Clique em "Série Concluída"
  - O intervalo será iniciado automaticamente
  - Após o intervalo, prossiga para a próxima série

#### 4. Acompanhar Evolução
- Acesse a aba "Evolução"
- Visualize gráficos de progresso
- Acompanhe estatísticas gerais

## Banco de Dados

O aplicativo utiliza **Drift** com **SQLite** para persistência local. As principais tabelas são:

- **MuscleGroups**: Grupos musculares
- **TrainingSessions**: Sessões de treino (A, B, C, etc.)
- **SessionMuscleGroups**: Relação entre sessões e grupos
- **Exercises**: Exercícios definidos
- **ExerciseSeriesList**: Séries de cada exercício
- **WorkoutSessions**: Sessões de treino em execução
- **WorkoutHistories**: Histórico de treinos concluídos

## Arquitetura e Padrões

### Provider Pattern
O aplicativo utiliza **Provider** para gerenciamento de estado:
- `MuscleGroupProvider`: Gerencia grupos musculares
- `TrainingSessionProvider`: Gerencia sessões de treino
- `ExerciseProvider`: Gerencia exercícios
- `WorkoutProvider`: Gerencia treinos em execução

### Banco de Dados
- **Drift ORM** para abstração de dados
- Métodos auxiliares para operações comuns
- Suporte a queries reativas com `.watch()`

## Funcionalidades Futuras

### Integração com Supabase
O projeto está arquitetado para futuras integrações com Supabase:
- Sincronização de dados em nuvem
- Backup automático
- Acesso multi-dispositivo
- Compartilhamento de planos de treino

### Melhorias Planejadas
- Autenticação de usuário
- Sincronização em tempo real
- Gráficos mais avançados
- Recomendações de treino
- Integração com wearables
- Notificações de treino

## UI/UX

O aplicativo apresenta:
- **Design Moderno**: Material Design 3
- **Cores Atraentes**: Paleta de cores vibrante
- **Responsividade**: Adaptado para diferentes tamanhos de tela
- **Navegação Intuitiva**: Bottom navigation com abas principais
- **Gráficos Interativos**: Visualizações de dados com fl_chart

## Resolução de Problemas

### Erro ao compilar
Se encontrar erros de compilação:
```bash
flutter clean
flutter pub get
flutter pub run build_runner build
```

### Banco de dados corrompido
Para resetar o banco de dados, simplesmente desinstale e reinstale o aplicativo.

## Contribuindo

Para contribuir com melhorias:
1. Faça um fork do projeto
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

## Licença

Este projeto é fornecido como está para fins educacionais e pessoais.

## Suporte

Para dúvidas ou problemas, consulte a documentação do Flutter:
- [Flutter Docs](https://flutter.dev/docs)
- [Drift Documentation](https://drift.simonbinder.eu/)
- [Provider Package](https://pub.dev/packages/provider)

---

**Desenvolvido com ❤️ em Flutter**
