const express = require('express');
const path = require('path');

const app = express();

// Get port from environment variable or use default
const port = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

// Set view engine
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Routes
app.get('/', (req, res) => {
    res.render('index', { 
        title: 'Azure Express App',
        message: 'Welcome to your Express.js application deployed on Azure!',
        timestamp: new Date().toISOString()
    });
});

app.get('/api/health', (req, res) => {
    res.json({
        status: 'healthy',
        timestamp: new Date().toISOString(),
        environment: process.env.NODE_ENV || 'development'
    });
});

app.get('/api/info', (req, res) => {
    res.json({
        name: 'Azure Express App',
        version: '1.0.0',
        node_version: process.version,
        platform: process.platform,
        uptime: process.uptime()
    });
});

// 404 handler
app.use((req, res) => {
    res.status(404).render('error', {
        title: 'Page Not Found',
        error: {
            status: 404,
            message: 'The page you are looking for does not exist.'
        }
    });
});

// Error handler
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).render('error', {
        title: 'Server Error',
        error: {
            status: 500,
            message: process.env.NODE_ENV === 'production' 
                ? 'Something went wrong!' 
                : err.message
        }
    });
});

// Start server
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
    console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
    console.log(`Deployment timestamp: ${new Date().toISOString()}`);
});

module.exports = app;
