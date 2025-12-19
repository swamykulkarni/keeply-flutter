#!/bin/bash

echo "🚀 Keeply Flutter - GitHub Push Script"
echo "======================================"

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Error: Not in Flutter project directory"
    echo "Please run this script from the keeply_flutter folder"
    exit 1
fi

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "❌ Error: Git not initialized"
    echo "Please run 'git init' first"
    exit 1
fi

echo "✅ Flutter project detected"
echo "✅ Git repository detected"
echo ""

# Get GitHub username
read -p "Enter your GitHub username: " github_username

if [ -z "$github_username" ]; then
    echo "❌ Error: GitHub username cannot be empty"
    exit 1
fi

echo ""
echo "📝 Repository URL: https://github.com/$github_username/keeply-flutter"
echo ""

# Remove existing origin if it exists
git remote remove origin 2>/dev/null || true

# Add GitHub remote
echo "🔗 Adding GitHub remote..."
git remote add origin https://github.com/$github_username/keeply-flutter.git

# Verify remote
echo "✅ Remote added:"
git remote -v

echo ""
echo "📤 Pushing to GitHub..."

# Push to GitHub
git branch -M main
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 SUCCESS! Your code has been pushed to GitHub!"
    echo ""
    echo "📋 Next steps:"
    echo "1. Visit: https://github.com/$github_username/keeply-flutter"
    echo "2. Verify all files are uploaded"
    echo "3. Ready for Railway deployment!"
    echo ""
    echo "🔗 Repository URL: https://github.com/$github_username/keeply-flutter"
else
    echo ""
    echo "❌ Push failed. Common solutions:"
    echo "1. Make sure you created the repository on GitHub first"
    echo "2. Check your GitHub username is correct"
    echo "3. Ensure you're logged into GitHub"
    echo "4. Try using a personal access token if prompted for password"
fi