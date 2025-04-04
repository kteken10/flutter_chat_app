# Flutter Chat App

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)

Une application de messagerie complète développée avec Flutter et Firebase.

## Fonctionnalités

### Authentification
- ✅ Connexion utilisateur
- ✅ Inscription utilisateur
- 🔒 Gestion sécurisée des sessions

### Messagerie
- 💬 Chat individuel (1-to-1)
- 👥 Chat de groupe
- 📎 Envoi de fichiers multimédias :
  - 🖼️ Images
  - 🎵 Audio
  - 📹 Vidéos
  - 📄 Documents
- 🔍 Recherche de conversations

### Stories
- 📸 Publication de stories visibles 24h
- 👀 Vue qui a vu votre story

### Appels
- 📞 Appel vocal aux contacts

### Personnalisation
- 🎨 Configuration du thème (clair/sombre)
- ✏️ Modification du profil utilisateur

## Technologies utilisées

- **Framework** : Flutter (Dart)
- **Backend** : 
  - Firebase Authentication
  - Cloud Firestore
  - Firebase Storage (pour les fichiers multimédias)
- **État** : Provider ou Riverpod (selon votre choix)
- **Autres packages** : 
  - intl pour la gestion des dates
  - image_picker pour la sélection de médias
  - firebase_core, cloud_firestore, etc.

## Configuration du projet

### Prérequis
- Flutter SDK (dernière version stable)
- Compte Firebase
- Android Studio/Xcode (pour l'émulation)

### Installation
1. Cloner le dépôt :
   ```bash
   git clone https://github.com/kteken10/flutter_chat_app.git