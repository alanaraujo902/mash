# Guia Rápido - Muscle App

## Instalação Rápida

### Pré-requisitos
- Flutter SDK instalado
- Android Studio ou Xcode (para emulador)
- Dart SDK (incluído no Flutter)

### Passos

1. **Navegue até o diretório do projeto**:
```bash
cd muscle_app
```

2. **Obtenha as dependências**:
```bash
flutter pub get
```

3. **Execute o aplicativo**:
```bash
flutter run
```

## Primeira Execução

Na primeira execução, o aplicativo:
1. Criará automaticamente 9 grupos musculares padrão
2. Inicializará o banco de dados local
3. Exibirá a tela de Sessões de Treino

## Começando

### Criar sua primeira sessão de treino:
1. Clique no botão **+** (FAB)
2. Digite "Sessão A"
3. Selecione os grupos musculares desejados
4. Clique em "Criar Sessão"

### Adicionar um exercício:
1. Clique na sessão criada
2. Clique em um grupo muscular
3. Clique no botão **+**
4. Preencha os dados do exercício
5. Clique em "Adicionar Exercício"

### Executar um treino:
1. Clique no exercício
2. Digite peso e repetições para cada série
3. Clique em "Série Concluída"
4. Aguarde o intervalo ou clique "Pular"

## Dicas

- Os dados são salvos automaticamente
- Você pode adicionar grupos musculares personalizados
- A página de Evolução mostra seus progressos
- Todos os dados estão no banco de dados local

## Troubleshooting

**Erro: "flutter: command not found"**
- Adicione Flutter ao PATH do seu sistema

**Erro ao compilar**
```bash
flutter clean
flutter pub get
flutter pub run build_runner build
flutter run
```

**Banco de dados corrompido**
- Desinstale e reinstale o aplicativo

## Próximos Passos

- Explore a página de Evolução para ver gráficos
- Customize seus grupos musculares
- Crie múltiplas sessões de treino
- Acompanhe seu progresso ao longo do tempo

---

Aproveite seu treino! 💪
