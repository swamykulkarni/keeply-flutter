#!/bin/bash

# Keeply Flutter Build Script
echo "🚀 Keeply Flutter Build Script"
echo "================================"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n 1)"

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
flutter pub get

echo ""
echo "Select build type:"
echo "1) Web (for Railway deployment)"
echo "2) Android APK (for direct install)"
echo "3) Android App Bundle (for Play Store)"
echo "4) All platforms"
echo ""
read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        echo "🌐 Building for Web..."
        flutter build web --release
        echo "✅ Web build complete! Files in build/web/"
        echo "📁 Deploy the build/web/ folder to your web server"
        ;;
    2)
        echo "📱 Building Android APK..."
        flutter build apk --release
        echo "✅ APK build complete!"
        echo "📁 APK location: build/app/outputs/flutter-apk/app-release.apk"
        ;;
    3)
        echo "📦 Building Android App Bundle..."
        flutter build appbundle --release
        echo "✅ App Bundle build complete!"
        echo "📁 Bundle location: build/app/outputs/bundle/release/app-release.aab"
        ;;
    4)
        echo "🔄 Building all platforms..."
        
        echo "🌐 Building Web..."
        flutter build web --release
        
        echo "📱 Building Android APK..."
        flutter build apk --release
        
        echo "📦 Building Android App Bundle..."
        flutter build appbundle --release
        
        echo "✅ All builds complete!"
        echo ""
        echo "📁 Build locations:"
        echo "   Web: build/web/"
        echo "   APK: build/app/outputs/flutter-apk/app-release.apk"
        echo "   Bundle: build/app/outputs/bundle/release/app-release.aab"
        ;;
    *)
        echo "❌ Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "🎉 Build process completed successfully!"
echo ""
echo "📋 Next steps:"
echo "   • For web: Deploy build/web/ folder to Railway or any web server"
echo "   • For Android: Share the APK file for direct installation"
echo "   • For Play Store: Upload the App Bundle to Google Play Console"
echo ""
echo "🔗 Deployment guide: See DEPLOYMENT.md for detailed instructions"