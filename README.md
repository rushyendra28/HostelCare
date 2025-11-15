🌟 HostelCare – Smart Hostel Issue Management App

A Flutter + Firebase Project

HostelCare is a modern, production-ready mobile application built with Flutter and Firebase.
It enables hostel residents to report problems, track issue status, and allows admins to manage and resolve complaints in real-time.

This project delivers a beautifully designed UI, scalable backend, and a smooth user experience across all screens.

🚀 Features
👤 Guest / Student

Quick onboarding (no email required)

Search & join your hostel

Submit complaints with:

Title

Description

Photo upload

Track complaint status:

Pending

Viewed

In Progress

Resolved

View all past complaints

Exit hostel with confirmation

Clean onboarding flow with illustrations

🛠️ Admin

Secure admin login (email/password)

Dashboard showing:

Total complaints

Viewed

In Progress

Solved

View all hostel complaints

Update complaint status instantly

View attached images

Real-time updates powered by Firebase

🧱 Tech Stack
Frontend

Flutter 3.x (Dart)

Provider / Riverpod (state management)

Custom reusable widgets

Gradient UI + soft shadows

Smooth navigation & animations

Backend

Firebase Authentication

Firebase Firestore

Firebase Storage

Firebase Cloud Functions (optional)

📲 Screens Included (18+)

Welcome screen

Onboarding (3 screens)

Search hostel

List of hostels

Hostel details

Join/exit hostel

Report a problem

Upload photo

Drawer menu

My complaints

Admin login

Admin dashboard

Complaint list

Complaint details

Update complaint status

🗄 Database Structure (Firestore)
/users
id
name
role ("guest" or "admin")
hostelId
roomNumber
createdAt

/hostels
id
name
about
amenities[]
features[]
rating

/complaints
id
userId
hostelId
title
description
imageUrl
status
submittedAt
updatedAt

🏗 Project Structure
lib/
 ├─ screens/
 ├─ widgets/
 ├─ models/
 ├─ providers/
 ├─ services/
 ├─ theme/
 └─ utils/

📦 Build Instructions
Run the app:
flutter run

Build APK:
flutter build apk --release

Build AAB (Play Store):
flutter build appbundle --release


APK & AAB get generated inside:

/build/app/outputs/

🔐 App Signing (Required for Release)

Generate keystore

Create key.properties

Add signingConfigs to build.gradle

Build APK/AAB

(Your repository should include a /docs folder with the full signing guide.)

🧪 Checklist Before Releasing

 Join/exit hostel works

 Complaint creation works

 Image uploads correctly

 Admin status updates reflect instantly

 My complaints screen shows latest changes

 Slow network tested

 App restarts preserve state

🎯 Roadmap

Push notifications

Web admin dashboard

Analytics for issues

Multi-hostel admin access

Dark mode

👨‍💻 Author

Rushyendra Gusidi
Flutter Developer / Full Stack Engineer
GitHub: https://github.com/rushyendra28
LinkedIn: https://www.linkedin.com/in/rushyendra28/
