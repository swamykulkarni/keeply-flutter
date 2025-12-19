# Keeply Flutter - Deployment Guide

This guide covers deploying the Keeply Flutter app to various platforms including Railway (web), Android APK, and app stores.

## 🌐 Web Deployment (Railway)

### Prerequisites
- Railway account
- Git repository

### Steps

1. **Prepare for Railway Deployment**
   ```bash
   # Ensure all files are committed
   git add .
   git commit -m "Flutter app ready for deployment"
   git push origin main
   ```

2. **Deploy to Railway**
   - Go to [Railway.app](https://railway.app)
   - Click "New Project" → "Deploy from GitHub repo"
   - Select your repository
   - Railway will automatically detect the Dockerfile and deploy

3. **Custom Domain (Optional)**
   - In Railway dashboard, go to Settings → Domains
   - Add your custom domain
   - Update DNS records as instructed

### Railway Configuration
The app includes:
- `Dockerfile` for containerized deployment
- `railway.json` for Railway-specific settings
- Web-optimized Flutter build

**Expected URL**: `https://your-app-name.up.railway.app`

## 📱 Android Deployment

### Build APK for Testing
```bash
# Debug APK (for testing)
flutter build apk --debug

# Release APK (for distribution)
flutter build apk --release
```

### Build App Bundle for Play Store
```bash
# Release App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### Generated Files
- **APK**: `build/app/outputs/flutter-apk/app-release.apk`
- **App Bundle**: `build/app/outputs/bundle/release/app-release.aab`

## 🍎 iOS Deployment

### Prerequisites
- macOS with Xcode
- Apple Developer Account
- iOS device or simulator

### Build for iOS
```bash
# Build iOS app
flutter build ios --release

# Open in Xcode for signing and deployment
open ios/Runner.xcworkspace
```

## 🚀 Quick Deployment Options

### Option 1: Railway Web App (Recommended for Demo)
```bash
# 1. Push to GitHub
git add .
git commit -m "Deploy Keeply Flutter"
git push origin main

# 2. Connect to Railway
# - Go to railway.app
# - Deploy from GitHub
# - Select repository
# - Automatic deployment starts
```

### Option 2: Android APK for Direct Install
```bash
# Build release APK
flutter build apk --release

# Share the APK file (located at build/app/outputs/flutter-apk/app-release.apk)
# Users can install directly on Android devices
```

### Option 3: Firebase Hosting (Alternative Web)
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Build web app
flutter build web --release

# Initialize Firebase
firebase init hosting

# Deploy
firebase deploy
```

## 🔧 Environment Configuration

### Development
```bash
flutter run
# Runs on localhost with hot reload
```

### Production Web
```bash
flutter build web --release
# Optimized web build in build/web/
```

### Production Mobile
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 📊 Performance Optimization

### Web Performance
- Enabled web renderer optimization
- Compressed assets and images
- Lazy loading for better performance

### Mobile Performance
- Optimized APK size with `--split-per-abi`
- Enabled R8 code shrinking
- Compressed images and assets

## 🔐 Security Considerations

### Web Deployment
- HTTPS enabled by default on Railway
- No sensitive data in client-side code
- Environment variables for configuration

### Mobile Deployment
- Code obfuscation enabled in release builds
- Secure storage for user preferences
- Network security configuration

## 📱 App Store Deployment

### Google Play Store
1. Build app bundle: `flutter build appbundle --release`
2. Create Play Console account
3. Upload app bundle
4. Complete store listing
5. Submit for review

### Apple App Store
1. Build iOS app: `flutter build ios --release`
2. Open in Xcode and archive
3. Upload to App Store Connect
4. Complete app information
5. Submit for review

## 🎯 Demo Deployment Checklist

### For Client Demo (Railway Web)
- ✅ Web-optimized Flutter build
- ✅ Responsive design for mobile/desktop
- ✅ Sample data pre-loaded
- ✅ All features functional
- ✅ Professional UI/UX

### For Mobile Demo (APK)
- ✅ Release APK built and tested
- ✅ All permissions configured
- ✅ Offline functionality working
- ✅ Native mobile experience
- ✅ Demo credentials included

## 🔄 Continuous Deployment

### GitHub Actions (Optional)
Create `.github/workflows/deploy.yml`:
```yaml
name: Deploy to Railway
on:
  push:
    branches: [ main ]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Deploy to Railway
      run: |
        # Railway deployment commands
```

## 📞 Support & Troubleshooting

### Common Issues

**Web Deployment Issues:**
- Check Dockerfile syntax
- Verify Flutter web build completes
- Check Railway logs for errors

**Mobile Build Issues:**
- Update Flutter SDK: `flutter upgrade`
- Clean build: `flutter clean && flutter pub get`
- Check Android SDK configuration

**Performance Issues:**
- Enable web renderer: `flutter build web --web-renderer canvaskit`
- Optimize images and assets
- Use release builds for production

## 🎉 Deployment Success

Once deployed, your Keeply Flutter app will be available:

### Web Version
- **Railway URL**: `https://keeply-flutter-production.up.railway.app`
- **Features**: Full responsive web app
- **Access**: Any device with web browser

### Mobile Version
- **Android APK**: Direct install on Android devices
- **Features**: Native mobile experience
- **Access**: Android 5.0+ devices

### Demo Ready
- **Sample Data**: Pre-loaded realistic appliances
- **User Flow**: Complete authentication to AMC tracking
- **Professional**: Production-quality UI/UX

---

**Deployment Guide by**: Kiro AI Assistant  
**Date**: December 19, 2024  
**Status**: ✅ Ready for Multi-Platform Deployment