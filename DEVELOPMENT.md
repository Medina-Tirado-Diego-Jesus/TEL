# Guía Rápida de Desarrollo - TEL

## 🚀 Inicio Rápido

### Windows
```bash
# Opción 1: Script automático
./setup.bat

# Opción 2: Manual
npm install
npm run dev
```

### macOS/Linux
```bash
# Opción 1: Script automático
chmod +x setup.sh
./setup.sh

# Opción 2: Manual
npm install
npm run dev
```

### GitHub Codespaces
1. Crear Codespace desde el repositorio
2. Esperar configuración automática
3. La aplicación se abrirá automáticamente

## 📁 Archivos importantes

- `src/views/DashboardView.vue` - Dashboard principal
- `src/components/MetricsSection.vue` - Componente de métricas
- `src/router/index.ts` - Rutas de la aplicación
- `package.json` - Dependencias y scripts

## 🛠 Comandos útiles

```bash
npm run dev      # Desarrollo
npm run build    # Producción
npm run preview  # Vista previa build
npm run lint     # Verificar código
npm run format   # Formatear código
```

## 🎵 Formatos de audio soportados

- MP3 (.mp3)
- WAV (.wav)
- M4A (.m4a)

## 🔧 Estructura de componentes

```
Dashboard
├── TEL Detection Card
├── Audio Analysis Card
│   ├── Upload Area
│   ├── Progress Bar
│   └── Analysis Button
└── Metrics Section
    └── 6 Metric Cards
```

## 💡 Tips de desarrollo

1. **Hot Reload**: Los cambios se reflejan automáticamente
2. **Vue DevTools**: Instalar para mejor debugging
3. **TypeScript**: Tipado fuerte habilitado
4. **ESLint**: Linting automático configurado
5. **Prettier**: Formateo automático al guardar

## 🐛 Debugging

- **Console**: `console.log()` en componentes Vue
- **Vue DevTools**: Inspeccionar componentes y estado
- **Network**: Verificar requests en DevTools del navegador
- **Hot Reload**: Cambios automáticos sin refresh