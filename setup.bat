@echo off
REM Script de configuración rápida para TEL - Windows
REM Ejecutar haciendo doble clic o desde cmd: setup.bat

echo 🚀 Configurando proyecto TEL...

REM Verificar Node.js
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js no está instalado. Por favor instálalo desde https://nodejs.org/
    pause
    exit /b 1
)

echo ✅ Node.js encontrado:
node --version

REM Verificar npm
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ npm no está disponible
    pause
    exit /b 1
)

echo ✅ npm encontrado:
npm --version

REM Instalar dependencias
echo 📦 Instalando dependencias...
npm install

if %errorlevel% neq 0 (
    echo ❌ Error al instalar dependencias
    pause
    exit /b 1
)

echo ✅ Dependencias instaladas correctamente

REM Ejecutar en modo desarrollo
echo 🎯 Iniciando servidor de desarrollo...
echo 💡 La aplicación estará disponible en: http://localhost:5173
echo 💡 Presiona Ctrl+C para detener el servidor

npm run dev

pause