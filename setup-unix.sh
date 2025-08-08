#!/bin/bash
# Azure Express App - Linux/Mac Setup Script

echo "🚀 Setting up Azure Express App..."

# Check if Node.js is installed
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo "✅ Node.js found: $NODE_VERSION"
else
    echo "❌ Node.js not found. Please install Node.js 22 LTS from https://nodejs.org/"
    echo "After installation, restart your terminal and run this script again."
    exit 1
fi

# Check if Git is installed
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version)
    echo "✅ Git found: $GIT_VERSION"
else
    echo "❌ Git not found. Please install Git from https://git-scm.com/"
    echo "After installation, restart your terminal and run this script again."
    exit 1
fi

# Clone repository if it doesn't exist
if [ ! -d "azure-express-app" ]; then
    echo "📥 Cloning repository..."
    git clone https://github.com/omkarpavtekar99/azure-express-app.git
    if [ $? -eq 0 ]; then
        echo "✅ Repository cloned successfully!"
    else
        echo "❌ Failed to clone repository"
        exit 1
    fi
else
    echo "✅ Repository directory already exists"
fi

# Navigate to project directory
cd azure-express-app

# Install dependencies
echo "📦 Installing dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully!"
else
    echo "❌ Failed to install dependencies"
    exit 1
fi

# Test the application
echo "🧪 Testing application..."
echo "Starting server on http://localhost:3000"
echo "Press Ctrl+C to stop the server"
echo ""

# Start the application
npm start
