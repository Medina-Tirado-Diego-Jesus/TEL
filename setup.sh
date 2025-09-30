#!/bin/bash

# Script de configuración rápida para TEL
# Ejecutar con: ./setup.sh

echo "🚀 Configurando proyecto TEL..."

# Verificar Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js no está instalado. Por favor instálalo desde https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js encontrado: $(node --version)"

# Verificar npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm no está disponible"
    exit 1
fi

echo "✅ npm encontrado: $(npm --version)"

# Instalar dependencias
echo "📦 Instalando dependencias..."
npm install

if [ $? -eq 0 ]; then
    echo "✅ Dependencias instaladas correctamente"
else
    echo "❌ Error al instalar dependencias"
    exit 1
fi

# Ejecutar en modo desarrollo
echo "🎯 Iniciando servidor de desarrollo..."
echo "💡 La aplicación estará disponible en: http://localhost:5173"
echo "💡 Presiona Ctrl+C para detener el servidor"

npm run dev