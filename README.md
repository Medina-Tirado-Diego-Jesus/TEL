# TEL - Análisis de Trastornos Específicos del Lenguaje

Una aplicación web moderna para el análisis y detección de Trastornos Específicos del Lenguaje (TEL) mediante análisis de audio. Construida con Vue.js 3, TypeScript y Vite.

## 🎯 Características

- **Análisis de audio**: Soporta archivos MP3, WAV y M4A
- **Dashboard interactivo**: Visualización de métricas clave del lenguaje
- **Detección TEL**: Análisis automático para detectar trastornos del lenguaje
- **Interfaz moderna**: Diseño responsivo y fácil de usar
- **Drag & Drop**: Carga intuitiva de archivos de audio

## 🚀 Cómo ejecutar el proyecto

### Opción 1: Visual Studio Code (Entorno local)

#### Prerrequisitos
- **Node.js** v20.17.0 o superior ([Descargar aquí](https://nodejs.org/))
- **Visual Studio Code** ([Descargar aquí](https://code.visualstudio.com/))
- **Git** ([Descargar aquí](https://git-scm.com/))

#### Pasos de instalación

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/Medina-Tirado-Diego-Jesus/TEL.git
   cd TEL
   ```

2. **Abrir en Visual Studio Code**
   ```bash
   code .
   ```

3. **Instalar extensiones recomendadas** (VS Code las sugerirá automáticamente):
   - Vue - Official (Vue.volar)
   - TypeScript Vue Plugin (Vue.vscode-typescript-vue-plugin)
   - ESLint
   - Prettier

4. **Instalar dependencias**
   ```bash
   npm install
   ```

5. **Ejecutar en modo desarrollo**
   ```bash
   npm run dev
   ```

6. **Abrir en el navegador**
   - La aplicación estará disponible en: `http://localhost:5173`
   - VS Code puede abrir automáticamente el Simple Browser

### Opción 2: GitHub Codespaces

#### Pasos para usar Codespaces

1. **Crear un Codespace**
   - Ve al repositorio en GitHub: `https://github.com/Medina-Tirado-Diego-Jesus/TEL`
   - Haz clic en el botón verde **"<> Code"**
   - Selecciona la pestaña **"Codespaces"**
   - Haz clic en **"Create codespace on main"**

2. **Esperar la configuración automática**
   - GitHub Codespaces configurará automáticamente el entorno
   - Se instalarán las dependencias automáticamente

3. **Ejecutar la aplicación**
   ```bash
   npm run dev
   ```

4. **Acceder a la aplicación**
   - Codespaces mostrará una notificación con el puerto 5173
   - Haz clic en **"Open in Browser"** o **"Preview in Editor"**
   - También puedes usar la pestaña **"Ports"** en la parte inferior

## 📁 Estructura del proyecto

```
TEL/
├── src/
│   ├── components/
│   │   └── MetricsSection.vue    # Componente de métricas
│   ├── views/
│   │   └── DashboardView.vue     # Vista principal del dashboard
│   ├── router/
│   │   └── index.ts              # Configuración de rutas
│   ├── stores/                   # Estado global (Pinia)
│   ├── assets/                   # Recursos estáticos
│   └── App.vue                   # Componente raíz
├── public/                       # Archivos públicos
├── package.json                  # Dependencias y scripts
└── vite.config.ts               # Configuración de Vite
```

## 🎵 Uso de la aplicación

1. **Cargar archivo de audio**
   - Arrastra un archivo de audio (MP3, WAV, M4A) al área designada
   - O haz clic en "Seleccionar Archivo" para elegir desde tu computadora

2. **Analizar audio**
   - Una vez cargado el archivo, haz clic en "Analizar Audio"
   - Espera a que complete el procesamiento

3. **Ver resultados**
   - Revisa el estado de detección TEL
   - Examina las métricas detalladas del análisis

## 🛠 Scripts disponibles

```bash
# Desarrollo
npm run dev          # Servidor de desarrollo con hot-reload

# Construcción
npm run build        # Compilar para producción
npm run preview      # Vista previa de la build de producción

# Calidad de código
npm run lint         # Ejecutar ESLint
npm run format       # Formatear código con Prettier

# Testing
npm run test:unit    # Ejecutar pruebas unitarias
```

## 🔧 Tecnologías utilizadas

- **Vue.js 3** - Framework JavaScript progresivo
- **TypeScript** - Superset tipado de JavaScript
- **Vite** - Herramienta de build ultrarrápida
- **Vue Router** - Enrutamiento para aplicaciones Vue
- **Pinia** - Gestión de estado moderna para Vue
- **ESLint** - Linting de código
- **Prettier** - Formateo de código
- **Vitest** - Framework de testing

## 🐛 Solución de problemas

### Error de versión de Node.js
Si obtienes un error sobre la versión de Node.js, puedes:
- Actualizar Node.js a la versión más reciente
- O ignorar la advertencia (la aplicación funcionará)

### Puerto ocupado
Si el puerto 5173 está ocupado:
```bash
npm run dev -- --port 3000
```

### Problemas con dependencias
```bash
# Limpiar caché e instalar de nuevo
rm -rf node_modules package-lock.json
npm install
```

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🤝 Contribuir

Las contribuciones son bienvenidas. Para cambios importantes:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request
