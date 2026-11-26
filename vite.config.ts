import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import React from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    React(),
  ],

  server: {
    cors: {
      origin: [
        'http://localhost:3000',
        'http://127.0.0.1:3000'
      ]
    }
  }
})
