# 🏠 HostelCare

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart)](https://dart.dev)

**HostelCare** is a comprehensive hostel complaint management system built with Flutter and Firebase. It enables hostel residents to report issues instantly and allows hostel administrators to manage and resolve complaints efficiently.

---

## 📱 Features

### For Guests (Residents)
- ✅ **Easy Registration** - Quick sign-up with email and password
- 🏨 **Hostel Selection** - Browse and join available hostels
- 📝 **Report Issues** - Submit complaints with photos and detailed descriptions
- 📊 **Track Complaints** - Real-time status updates (Viewed, In Progress, Solved)
- 🔔 **Live Updates** - Get instant notifications on complaint status changes
- 👤 **Profile Management** - Update personal information and preferences

### For Admins (Hostel Management)
- 🔐 **Secure Admin Login** - Role-based authentication system
- 📈 **Dashboard Analytics** - View complaint statistics and metrics
- 📋 **Complaint Management** - View, update, and resolve complaints
- ⚡ **Real-time Monitoring** - Live complaint updates and notifications
- 🏢 **Hostel Management** - Manage hostel details, amenities, and information
- 👥 **Member Management** - View and manage hostel residents

---

## 🎨 Screenshots

<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 46 44 PM" src="https://github.com/user-attachments/assets/169c1d2f-8896-447b-b26b-22603bdc532c" />
<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 44 36 PM" src="https://github.com/user-attachments/assets/de27db9b-b9ed-4076-8846-dee60413fbe0" />
<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 44 27 PM" src="https://github.com/user-attachments/assets/7f0a7b01-809d-45d2-9021-357f9c1c76bf" />
<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 44 09 PM" src="https://github.com/user-attachments/assets/b497e30f-bbef-461a-a31e-e4fe4a993bf2" />
<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 43 49 PM" src="https://github.com/user-attachments/assets/112f64be-6ba9-4a0c-a990-5fda2f064526" />
<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 43 42 PM" src="https://github.com/user-attachments/assets/0e03743c-52af-4821-965d-00ca160ac98e" />
<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 43 24 PM" src="https://github.com/user-attachments/assets/56741de3-7591-4492-8699-9a39862ab80c" />
<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 43 17 PM" src="https://github.com/user-attachments/assets/e7f5b201-f8f6-41b7-9a8a-b2c9441111b3" />
<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 43 08 PM" src="https://github.com/user-attachments/assets/018f5d75-cba1-4fb9-9d9e-279bac98b9ed" />
<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 42 47 PM" src="https://github.com/user-attachments/assets/2c646e81-2422-49f2-b8d2-f2567a831ccd" />
<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 42 32 PM" src="https://github.com/user-attachments/assets/407fb8ea-0b88-4b0b-9601-9f3a3ce0830e" />
<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 42 23 PM" src="https://github.com/user-attachments/assets/aa44b115-3d25-44e9-b730-184d1f51a2b4" />
<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 42 13 PM" src="https://github.com/user-attachments/assets/f3411f0c-ad63-49d7-9abd-b23093634ea1" />
<img width="400" height="848" alt="Screenshot 2025-11-15 at 5 42 02 PM" src="https://github.com/user-attachments/assets/35a75dc5-5722-415e-9b65-f4741a841453" />


---

## 🛠️ Tech Stack

### Frontend
- **Framework:** Flutter 3.0+
- **Language:** Dart
- **State Management:** Provider
- **UI Components:** Material Design 3
- **Fonts:** Google Fonts (Inter)

### Backend
- **Authentication:** Firebase Authentication
- **Database:** Cloud Firestore
- **Storage:** Firebase Cloud Storage (for complaint photos)
- **Real-time Updates:** Firestore Streams

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Firebase
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  cloud_firestore: ^4.14.0
  
  # UI & Design
  google_fonts: ^6.1.0
  smooth_page_indicator: ^1.1.0
  
  # State Management
  provider: ^6.1.1
  
  # Utilities
  image_picker: ^1.0.7
  intl: ^0.18.1
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / Xcode
- Firebase Account
- Node.js (for Firebase CLI)

### Installation

1. **Clone the repository**
```bash
   git clone https://github.com/rushyendra28/hostelcare.git
   cd hostelcare
```

2. **Install dependencies**
```bash
   flutter pub get
```

3. **Firebase Setup**
   a. Install Firebase CLI
```bash
   npm install -g firebase-tools
   firebase login
```
   
   b. Install FlutterFire CLI
```bash
   dart pub global activate flutterfire_cli
```
   
   c. Configure Firebase
```bash
   flutterfire configure
```
   
   d. Select your Firebase project and platforms (iOS/Android)

4. **Download Configuration Files**
   - For Android: Place `google-services.json` in `android/app/`
   - For iOS: Place `GoogleService-Info.plist` in `ios/Runner/`

5. **Run the app**
```bash
   flutter run
```
---

## 📁 Project Structure
```
hostelcare/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_strings.dart
│   │   │   └── app_styles.dart
│   │   └── utils/
│   ├── models/
│   │   ├── hostel.dart
│   │   ├── complaint.dart
│   │   └── user.dart
│   ├── screens/
│   │   ├── welcome/
│   │   ├── onboarding/
│   │   ├── hostel/
│   │   ├── complaint/
│   │   ├── admin/
│   │   └── menu/
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── hostel_service.dart
│   │   └── complaint_service.dart
│   ├── widgets/
│   │   ├── custom_button.dart
│   │   ├── custom_text_field.dart
│   │   ├── hostel_card.dart
│   │   ├── complaint_card.dart
│   │   └── status_badge.dart
│   ├── firebase_options.dart
│   └── main.dart
├── android/
├── ios/
├── assets/
├── test/
├── pubspec.yaml
└── README.md
```

---

## 🔥 Firebase Configuration

### Firestore Collections

#### `users`
```javascript
{
  "userId": {
    "name": "string",
    "email": "string",
    "role": "guest" | "admin",
    "currentHostelId": "string | null",
    "createdAt": "timestamp"
  }
}
```

#### `hostels`
```javascript
{
  "hostelId": {
    "name": "string",
    "location": "string",
    "rating": "number",
    "reviews": "number",
    "about": "string",
    "amenities": ["array of strings"],
    "adminId": "string",
    "createdAt": "timestamp"
  }
}
```

#### `complaints`
```javascript
{
  "complaintId": {
    "hostelId": "string",
    "userId": "string",
    "guestName": "string",
    "roomNumber": "string",
    "title": "string",
    "description": "string",
    "status": "viewed" | "in_progress" | "solved",
    "photoUrl": "string | null",
    "submittedDate": "timestamp",
    "updatedDate": "timestamp"
  }
}
```

#### `hostel_members`
```javascript
{
  "hostelId": {
    "members": {
      "userId": {
        "name": "string",
        "joinedAt": "timestamp"
      }
    }
  }
}
```

---

## 🔒 Security Rules

### Firestore Security Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    function isSignedIn() {
      return request.auth != null;
    }
    
    function isOwner(userId) {
      return isSignedIn() && request.auth.uid == userId;
    }
    
    function isAdmin() {
      return isSignedIn() && 
             get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }
    
    match /users/{userId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn() && isOwner(userId);
      allow update, delete: if isOwner(userId);
    }
    
    match /hostels/{hostelId} {
      allow read: if isSignedIn();
      allow create, update, delete: if isAdmin();
    }
    
    match /complaints/{complaintId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn();
      allow update: if isOwner(resource.data.userId) || isAdmin();
      allow delete: if isOwner(resource.data.userId) || isAdmin();
    }
    
    match /hostel_members/{hostelId}/members/{userId} {
      allow read: if isSignedIn();
      allow write: if isOwner(userId) || isAdmin();
    }
  }
}
```

---

## 🎯 Key Features Implementation

### Authentication Flow
```dart
// Sign up as Guest
await authService.signUpGuest(
  email: email,
  password: password,
  name: name,
);

// Sign in
await authService.signIn(
  email: email,
  password: password,
);

// Admin login with role verification
await authService.signInAsAdmin(
  email: email,
  password: password,
);
```

### Hostel Management
```dart
// Get all hostels (real-time)
Stream<List> hostelsStream = hostelService.getHostels();

// Join hostel
await hostelService.joinHostel(
  userId: userId,
  hostelId: hostelId,
  userName: userName,
);

// Exit hostel
await hostelService.exitHostel(
  userId: userId,
  hostelId: hostelId,
);
```

### Complaint Management
```dart
// Submit complaint
String complaintId = await complaintService.submitComplaint(
  hostelId: hostelId,
  userId: userId,
  guestName: name,
  roomNumber: room,
  title: title,
  description: description,
);

// Update status (Admin)
await complaintService.updateComplaintStatus(
  complaintId: complaintId,
  status: 'solved',
);

// Get user complaints (real-time)
Stream<List> complaintsStream = 
  complaintService.getUserComplaints(userId);
```

---

## 📱 Build & Deploy

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

---

## 🧪 Testing

Run tests:
```bash
flutter test
```

Run with code coverage:
```bash
flutter test --coverage
```

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 👥 Authors

- **Rushyendra** - *Initial work* - Rushyendra(https://github.com/rushyendra28)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Google Fonts for typography
- Material Design for UI guidelines
- All contributors and supporters

---

## 🗺️ Roadmap

### Version 1.0 (Current)
- ✅ User authentication
- ✅ Hostel browsing and joining
- ✅ Complaint submission
- ✅ Real-time status updates
- ✅ Admin dashboard

### Version 2.0 (Planned)
- 📱 Push notifications
- 💬 In-app messaging
- 📊 Advanced analytics
- 🌐 Multi-language support
- 🎨 Customizable themes
- 📸 Multiple photo uploads
- 🔍 Advanced search filters
- ⭐ Rating system for hostels

---

## 🐛 Known Issues

- None reported yet

---

## 📊 Stats

![GitHub repo size](https://img.shields.io/github/repo-size/rushyendra28/hostelcare)
![GitHub contributors](https://img.shields.io/github/contributors/rushyendra28/hostelcare)
![GitHub stars](https://img.shields.io/github/stars/rushyendra28/hostelcare?style=social)
![GitHub forks](https://img.shields.io/github/forks/rushyendra28/hostelcare?style=social)

