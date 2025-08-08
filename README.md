# Azure Express App

A basic Express.js web application built with Node.js 22 LTS, designed for deployment on Microsoft Azure.

**Last updated**: 2025-08-08 - Deployed to Azure

## Features

- **Express.js** web framework
- **EJS** templating engine
- **Responsive design** with modern UI
- **Health check** and info endpoints
- **Error handling** with custom error pages
- **Azure deployment ready** with web.config
- **Development tools** including nodemon

## Prerequisites

Before running this application, you need to install Node.js 22 LTS:

1. Download Node.js 22 LTS from [nodejs.org](https://nodejs.org/)
2. Run the installer and follow the installation wizard
3. Verify installation by running: `node --version`

## Project Structure

```
azure-express-app/
├── app.js              # Main application file
├── package.json        # Dependencies and scripts
├── web.config          # Azure App Service configuration
├── .gitignore          # Git ignore rules
├── README.md           # This file
├── views/              # EJS templates
│   ├── index.ejs       # Home page
│   └── error.ejs       # Error page
└── public/             # Static files
    └── favicon.ico     # App icon
```

## Installation

1. **Install dependencies:**
   ```bash
   npm install
   ```

## Running Locally

1. **Development mode** (with auto-restart):
   ```bash
   npm run dev
   ```

2. **Production mode:**
   ```bash
   npm start
   ```

3. Open your browser to `http://localhost:3000`

## API Endpoints

- **GET /** - Home page with application info
- **GET /api/health** - Health check endpoint (returns JSON)
- **GET /api/info** - Application information endpoint (returns JSON)

## Azure Deployment Options

### Option 1: Azure App Service (Recommended)

1. **Install Azure CLI:**
   ```bash
   # Windows (using chocolatey)
   choco install azure-cli
   
   # Or download from: https://aka.ms/installazurecliwindows
   ```

2. **Login to Azure:**
   ```bash
   az login
   ```

3. **Create resource group:**
   ```bash
   az group create --name myResourceGroup --location "East US"
   ```

4. **Create App Service plan:**
   ```bash
   az appservice plan create --name myAppServicePlan --resource-group myResourceGroup --sku FREE
   ```

5. **Create Web App:**
   ```bash
   az webapp create --resource-group myResourceGroup --plan myAppServicePlan --name your-unique-app-name --runtime "NODE:22-lts"
   ```

6. **Deploy from local Git:**
   ```bash
   # Initialize git repository
   git init
   git add .
   git commit -m "Initial commit"
   
   # Configure deployment
   az webapp deployment source config-local-git --name your-unique-app-name --resource-group myResourceGroup
   
   # Add Azure as remote and push
   git remote add azure <deployment_url_from_previous_command>
   git push azure main
   ```

### Option 2: Azure Container Instances

1. **Create Dockerfile:**
   ```dockerfile
   FROM node:22-alpine
   WORKDIR /app
   COPY package*.json ./
   RUN npm ci --only=production
   COPY . .
   EXPOSE 3000
   CMD ["npm", "start"]
   ```

2. **Build and deploy container:**
   ```bash
   # Build container
   docker build -t azure-express-app .
   
   # Create Azure Container Registry
   az acr create --resource-group myResourceGroup --name myContainerRegistry --sku Basic
   
   # Push to registry and deploy
   az acr build --registry myContainerRegistry --image azure-express-app .
   az container create --resource-group myResourceGroup --name azure-express-app --image myContainerRegistry.azurecr.io/azure-express-app:latest
   ```

### Option 3: VS Code Azure Extension

1. **Install Azure App Service extension** for VS Code
2. **Right-click** on your project folder
3. **Select "Deploy to Web App..."**
4. **Follow the prompts** to create and deploy

## Environment Variables

The application uses these environment variables:

- `PORT` - Server port (default: 3000)
- `NODE_ENV` - Environment mode (development/production)

## Development

### Adding new routes

Add routes in `app.js`:

```javascript
app.get('/new-route', (req, res) => {
    res.render('new-template', { data: 'value' });
});
```

### Adding new views

Create EJS templates in the `views/` directory:

```html
<!-- views/new-template.ejs -->
<!DOCTYPE html>
<html>
<head><title><%= title %></title></head>
<body><h1><%= data %></h1></body>
</html>
```

### Static files

Add CSS, JavaScript, images to the `public/` directory.

## Troubleshooting

### Common Issues

1. **Node.js not found:**
   - Ensure Node.js 22 LTS is installed
   - Restart your terminal after installation

2. **Port already in use:**
   - Change the PORT environment variable
   - Or kill the process using the port

3. **Azure deployment fails:**
   - Check web.config configuration
   - Verify Node.js version in package.json engines
   - Check Azure logs: `az webapp log tail --name your-app-name --resource-group myResourceGroup`

### Logs

- **Local development:** Check console output
- **Azure:** Use `az webapp log tail` or check Application Insights

## License

MIT License - see LICENSE file for details.

## Next Steps

- Add authentication (Azure AD, OAuth)
- Implement database connectivity (Azure SQL, CosmosDB)
- Add monitoring and logging (Application Insights)
- Set up CI/CD pipeline (Azure DevOps, GitHub Actions)
- Add unit tests and integration tests
