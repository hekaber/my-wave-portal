import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
const path = require('path');
require('dotenv').config({path:path.resolve(__dirname, '../../config/env/.env')});

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',
    port: 8080
    // port: process.env.WEBAPP_PORT
  }
})
