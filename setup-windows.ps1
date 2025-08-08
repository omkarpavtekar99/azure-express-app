# Azure Express App - Windows Setup Script
# Run this on your other Windows laptop

Write-Host "🚀 Setting up Azure Express App..." -ForegroundColor Green

# Check if Node.js is installed
try {
    $nodeVersion = node --version
    Write-Host "✅ Node.js found: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js not found. Please install Node.js 22 LTS from https://nodejs.org/" -ForegroundColor Red
    Write-Host "After installation, restart PowerShell and run this script again." -ForegroundColor Yellow
    exit 1
}

# Check if Git is installed
try {
    $gitVersion = git --version
    Write-Host "✅ Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git not found. Please install Git from https://git-scm.com/" -ForegroundColor Red
    Write-Host "After installation, restart PowerShell and run this script again." -ForegroundColor Yellow
    exit 1
}

# Clone repository if it doesn't exist
if (-not (Test-Path "azure-express-app")) {
    Write-Host "📥 Cloning repository..." -ForegroundColor Yellow
    git clone https://github.com/omkarpavtekar99/azure-express-app.git
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Repository cloned successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to clone repository" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "✅ Repository directory already exists" -ForegroundColor Green
}

# Navigate to project directory
Set-Location "azure-express-app"

# Install dependencies
Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
npm install

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Dependencies installed successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to install dependencies" -ForegroundColor Red
    exit 1
}

# Test the application
Write-Host "🧪 Testing application..." -ForegroundColor Yellow
Write-Host "Starting server on http://localhost:3000" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Cyan
Write-Host ""

# Start the application
npm start
