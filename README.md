
# Flutter Chat App

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)

Une application de messagerie complète développée avec Flutter et Firebase.

---

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

---

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

---

## 📸 Aperçu de l'application

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/0048d632-77cd-4032-a4ee-eb46b29f25d8" alt="Chat 1" width="100%"/></td>
    <td><img src="https://github.com/user-attachments/assets/07e71b34-7d5d-4926-b36e-0c700df76554" alt="Chat 2" width="100%"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/0f0f16b8-dfa9-4689-9eb2-75967c0e1a71" alt="Chat 3" width="100%"/></td>
    <td><img src="https://github.com/user-attachments/assets/2dbacdc7-b213-43fc-9f9b-c90438b15f32" alt="Chat 4" width="100%"/></td>
  </tr>
</table>

---

## ⚙️ Configuration du projet

### Prérequis
- Flutter SDK (dernière version stable)
- Compte Firebase
- Android Studio/Xcode (pour l'émulation)

### Installation
1. Cloner le dépôt :
   ```bash
   git clone https://github.com/kteken10/flutter_chat_app.git
   ```

2. Installer les dépendances :
   ```bash
   flutter pub get
   ```

3. Configurer Firebase :
   - Ajouter `google-services.json` (Android) ou `GoogleService-Info.plist` (iOS)
   - Activer les services nécessaires (Auth, Firestore, Storage)

4. Lancer l’application :
   ```bash
   flutter run
   ```

---

## 📬 Contact

Pour toute question ou collaboration, n’hésitez pas à me contacter :  
📧 [dissangfrancis@yahoo.com](mailto:dissangfrancis@yahoo.com)  
🔗 [LinkedIn](https://www.linkedin.com/in/dissangkevin)
