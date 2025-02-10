/chat_app
│-- /android                   # Code spécifique à Android
│-- /ios                       # Code spécifique à iOS
│-- /lib                       # Code principal de l'application
│   │-- /config                # Configuration et clés API
│   │   ├── firebase_options.dart  # Configuration Firebase
│   │-- /core                  # Fichiers essentiels et services globaux
│   │   ├── app_constants.dart  # Constantes globales de l'application
│   │   ├── theme.dart          # Thème de l'application
│   │   ├── utils.dart          # Fonctions utilitaires
│   │-- /data                  # Gestion des modèles et des sources de données
│   │   ├── /models            # Modèles de données
│   │   │   ├── user_model.dart  # Modèle utilisateur
│   │   │   ├── message_model.dart  # Modèle de message
│   │   │   ├── group_model.dart  # Modèle de groupe
│   │   ├── /repositories      # Gestion des interactions avec Firestore
│   │   │   ├── auth_repository.dart  # Gestion de l'authentification
│   │   │   ├── chat_repository.dart  # Gestion des discussions
│   │   │   ├── group_repository.dart  # Gestion des groupes
│   │-- /services              # Services Firebase et API
│   │   ├── auth_service.dart  # Service d'authentification Firebase
│   │   ├── chat_service.dart  # Service de chat en temps réel
│   │   ├── storage_service.dart  # Gestion des fichiers (images, vidéos)
│   │-- /presentation          # Interface utilisateur (UI)
│   │   ├── /screens           # Écrans principaux
│   │   │   ├── login_screen.dart  # Écran de connexion
│   │   │   ├── signup_screen.dart  # Écran d'inscription
│   │   │   ├── home_screen.dart  # Écran d'accueil
│   │   │   ├── chat_screen.dart  # Interface de chat
│   │   │   ├── group_screen.dart  # Interface des groupes
│   │   │   ├── settings_screen.dart  # Écran des paramètres
│   │   ├── /widgets           # Composants réutilisables
│   │   │   ├── custom_button.dart  # Bouton personnalisé
│   │   │   ├── message_bubble.dart  # Affichage des messages
│   │   │   ├── input_field.dart  # Champ de saisie
│   │-- /providers             # Gestion des états avec Riverpod/Provider
│   │   ├── auth_provider.dart  # Gestion de l'authentification
│   │   ├── chat_provider.dart  # Gestion du chat
│   │   ├── group_provider.dart  # Gestion des groupes
│   │-- main.dart               # Point d'entrée de l'application
│-- pubspec.yaml                # Dépendances et configuration du projet
│-- README.md                   # Documentation du projet
