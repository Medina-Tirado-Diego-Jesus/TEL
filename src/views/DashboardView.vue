<template>
  <div class="dashboard">
    <header class="dashboard-header">
      <h1>Dashboard</h1>
    </header>

    <section class="results-section">
      <h2>Resultados:</h2>

      <div class="results-grid">
        <!-- Estado de detección TEL -->
        <div class="tel-detection-card">
          <h3>Trastorno Específico del Lenguaje (TEL) Detectado</h3>
          <div
            class="detection-result"
            :class="{
              detected: telDetected === true,
              'no-detected': telDetected === false,
              'no-analysis': telDetected === null,
            }"
          >
            <span class="status-text">
              {{ telDetected === null ? '-' : telDetected ? 'Sí' : 'No' }}
            </span>
            <span class="status-description">{{ telStatusDescription }}</span>
          </div>
        </div>

        <!-- Panel de análisis de audio -->
        <div class="audio-analysis-card">
          <h3>Nuevo análisis de audio</h3>
          <div
            class="audio-upload-area"
            @dragover.prevent
            @drop.prevent="handleAudioDrop"
            @click="triggerFileInput"
            :class="{ uploading: isUploading }"
          >
            <!-- Estado inicial: Sin archivo -->
            <div v-if="!currentAudioFile && !isUploading" class="upload-placeholder">
              <div class="upload-icon">☁️</div>
              <p>Arrastra tu archivo de audio aquí</p>
              <p class="file-types">Formatos soportados: MP3, WAV, M4A</p>
              <button class="upload-btn">Seleccionar Archivo</button>
            </div>

            <!-- Estado: Cargando archivo -->
            <div v-else-if="isUploading && !hasAnalysis" class="upload-status-area">
              <div class="status-content">
                <div class="status-left">
                  <div class="status-label">Subiendo archivo</div>
                  <div class="progress-container">
                    <div class="progress-bar">
                      <div class="progress-fill" :style="{ width: uploadProgress + '%' }"></div>
                    </div>
                    <div class="status-percentage">{{ uploadProgress }}%</div>
                  </div>
                  <div class="status-filename">{{ currentAudioFile }}</div>
                </div>
              </div>
            </div>

            <!-- Estado: Archivo listo para analizar -->
            <div
              v-else-if="currentAudioFile && !isUploading && !hasAnalysis"
              class="upload-ready-area"
            >
              <div class="file-ready">
                <div class="file-icon">🎵</div>
                <div class="file-info">
                  <div class="file-name">{{ currentAudioFile }}</div>
                  <div class="file-status">Listo para analizar</div>
                </div>
                <button @click="processAudio" class="analyze-btn">Analizar Audio</button>
              </div>
            </div>

            <!-- Estado: Analizando -->
            <div v-else-if="isUploading && hasAnalysis" class="analyzing-area">
              <div class="status-content">
                <div class="status-left">
                  <div class="status-label">Estado de la carga</div>
                  <div class="progress-container">
                    <div class="progress-bar">
                      <div class="progress-fill" :style="{ width: uploadProgress + '%' }"></div>
                    </div>
                    <div class="status-percentage">{{ uploadProgress }}%</div>
                  </div>
                  <div class="status-filename">{{ currentAudioFile }}</div>
                </div>
              </div>
            </div>

            <!-- Estado: Análisis completado -->
            <div v-else-if="hasAnalysis && !isUploading" class="analysis-complete-area">
              <div class="analysis-result">
                <div class="result-icon">✅</div>
                <div class="result-info">
                  <div class="result-title">Análisis completado</div>
                  <div class="result-file">{{ currentAudioFile }}</div>
                </div>
                <button @click="resetAnalysis" class="new-analysis-btn">Nuevo Análisis</button>
              </div>
            </div>
          </div>
          <input
            ref="fileInput"
            type="file"
            accept=".mp3,.wav,.m4a,audio/mp3,audio/mpeg,audio/wav,audio/x-wav,audio/mp4,audio/m4a,audio/x-m4a"
            @change="handleFileSelect"
            style="display: none"
          />
        </div>
      </div>
    </section>

    <!-- Métricas clave -->
    <MetricsSection :metrics="currentMetrics" @update-metrics="updateMetrics" />
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import MetricsSection from '@/components/MetricsSection.vue'

// Estado de detección TEL
const telDetected = ref<boolean | null>(null)
const telStatusDescription = ref('Sin análisis previo')

// Estado del análisis de audio
const currentAudioFile = ref('')
const isUploading = ref(false)
const isAnalyzing = ref(false)
const uploadProgress = ref(0)
const uploadStatus = ref('')
const fileInput = ref<HTMLInputElement>()
const hasAnalysis = ref(false)

// Métricas actuales (vacías inicialmente)
const currentMetrics = reactive({
  complejidadOracion: { valor: 0, etiqueta: 'Promedio' },
  riquezaVocabulario: { valor: 0, etiqueta: 'Puntuación' },
  exactitudGramatical: { valor: 0, etiqueta: 'Precisión', unidad: '%' },
  coherenciaNarrativa: { valor: 0, total: 5, etiqueta: 'Calificación' },
  usoLenguajePragmatico: { valor: 0, total: 5, etiqueta: 'Calificación' },
  procesamientoFonologico: { valor: 0, etiqueta: 'Puntuación' },
})

// Funciones para manejo de archivos
const handleAudioDrop = (event: DragEvent) => {
  const files = event.dataTransfer?.files
  if (files && files.length > 0 && files[0]) {
    processFileUpload(files[0])
  }
}

const triggerFileInput = () => {
  fileInput.value?.click()
}

const handleFileSelect = (event: Event) => {
  const target = event.target as HTMLInputElement
  const file = target.files?.[0]
  if (file) {
    processFileUpload(file)
  }
}

const processFileUpload = (file: File) => {
  // Validar que sea un archivo de audio válido
  const validTypes = [
    'audio/mp3',
    'audio/mpeg',
    'audio/wav',
    'audio/x-wav',
    'audio/mp4',
    'audio/m4a',
    'audio/x-m4a',
  ]
  const isValidType =
    validTypes.some((type) => file.type === type) ||
    file.name.toLowerCase().endsWith('.mp3') ||
    file.name.toLowerCase().endsWith('.wav') ||
    file.name.toLowerCase().endsWith('.m4a')

  if (!isValidType) {
    alert('Por favor selecciona un archivo de audio válido (.mp3, .wav o .m4a)')
    return
  }

  currentAudioFile.value = file.name
  isUploading.value = true
  uploadProgress.value = 0
  uploadStatus.value = 'Subiendo archivo...'

  // Simular proceso de carga
  const interval = setInterval(() => {
    uploadProgress.value += 20
    if (uploadProgress.value >= 100) {
      clearInterval(interval)
      uploadProgress.value = 100
      isUploading.value = false
      uploadStatus.value = 'Archivo listo para analizar'
    }
  }, 200)
}

const processAudio = () => {
  if (!currentAudioFile.value) {
    alert('Por favor selecciona un archivo de audio primero')
    return
  }

  isAnalyzing.value = true
  isUploading.value = true
  uploadProgress.value = 0
  uploadStatus.value = 'Analizando audio...'

  // Simular análisis
  const interval = setInterval(() => {
    uploadProgress.value += 8
    if (uploadProgress.value >= 100) {
      clearInterval(interval)
      isUploading.value = false
      isAnalyzing.value = false
      hasAnalysis.value = true

      // Simular resultados del análisis
      telDetected.value = Math.random() > 0.5
      telStatusDescription.value = telDetected.value
        ? 'Posible trastorno detectado'
        : 'Dentro de límites normales'

      // Actualizar métricas con valores realistas
      updateMetricsWithRandomValues()

      uploadStatus.value = 'Análisis completado'
    }
  }, 150)
}

const updateMetricsWithRandomValues = () => {
  currentMetrics.complejidadOracion.valor = Number((Math.random() * 3 + 2).toFixed(1))
  currentMetrics.riquezaVocabulario.valor = Math.floor(Math.random() * 40 + 60)
  currentMetrics.exactitudGramatical.valor = Math.floor(Math.random() * 20 + 80)
  currentMetrics.coherenciaNarrativa.valor = Math.floor(Math.random() * 3 + 2)
  currentMetrics.usoLenguajePragmatico.valor = Math.floor(Math.random() * 3 + 2)
  currentMetrics.procesamientoFonologico.valor = Math.floor(Math.random() * 30 + 70)
}

const updateMetrics = (newMetrics: typeof currentMetrics) => {
  Object.assign(currentMetrics, newMetrics)
}

const resetAnalysis = () => {
  currentAudioFile.value = ''
  isUploading.value = false
  isAnalyzing.value = false
  uploadProgress.value = 0
  uploadStatus.value = ''
  hasAnalysis.value = false
  telDetected.value = null
  telStatusDescription.value = 'Sin análisis previo'

  // Resetear métricas
  currentMetrics.complejidadOracion.valor = 0
  currentMetrics.riquezaVocabulario.valor = 0
  currentMetrics.exactitudGramatical.valor = 0
  currentMetrics.coherenciaNarrativa.valor = 0
  currentMetrics.usoLenguajePragmatico.valor = 0
  currentMetrics.procesamientoFonologico.valor = 0
}
</script>

<style scoped>
.dashboard {
  width: 100vw;
  max-width: none;
  margin: 0;
  padding: 40px;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background-color: #f5f5f5;
  min-height: 100vh;
  color: #333;
  box-sizing: border-box;
}

.dashboard-header {
  margin-bottom: 30px;
}

.dashboard-header h1 {
  font-size: 2.5rem;
  font-weight: 300;
  color: #333;
  margin: 0;
}

.results-section h2 {
  font-size: 1.5rem;
  color: #333;
  margin-bottom: 20px;
}

.results-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 40px;
  margin-bottom: 30px;
  width: 100%;
  max-width: 1200px;
}

.tel-detection-card,
.audio-analysis-card {
  background: white !important;
  border-radius: 12px;
  padding: 32px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  border: 1px solid #e9ecef;
  color: #333 !important;
  width: 100%;
}

.tel-detection-card h3,
.audio-analysis-card h3 {
  font-size: 1.1rem;
  color: #333;
  margin-bottom: 16px;
  font-weight: 500;
}

.detection-result {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.status-text {
  font-size: 2rem;
  font-weight: bold;
}

.no-detected .status-text {
  color: #28a745;
}

.detected .status-text {
  color: #dc3545;
}

.no-analysis .status-text {
  color: #6c757d;
  font-size: 1.5rem;
}

.status-description {
  color: #6c757d;
  font-size: 0.9rem;
}

.audio-upload-area {
  border: 2px dashed #dee2e6;
  border-radius: 8px;
  padding: 24px;
  text-align: center;
  cursor: pointer;
  transition: all 0.3s ease;
  min-height: 120px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
}

.audio-upload-area:hover {
  border-color: #007bff;
  background-color: #f8f9fa;
}

.audio-upload-area.uploading {
  border-color: #007bff;
  background-color: #e3f2fd;
}

.upload-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
}

.upload-icon {
  font-size: 3rem;
  margin-bottom: 8px;
}

.upload-btn,
.process-btn {
  background: #007bff;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.9rem;
  transition: background-color 0.3s ease;
}

.upload-btn:hover,
.process-btn:hover,
.analyze-btn:hover,
.new-analysis-btn:hover {
  background: #0056b3;
}

.file-types {
  font-size: 0.8rem;
  color: #666;
  margin: 8px 0;
}

.upload-ready-area,
.analyzing-area,
.analysis-complete-area {
  padding: 16px;
  text-align: center;
}

.file-ready,
.analysis-result {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px;
  background: #f8f9fa;
  border-radius: 8px;
}

.file-icon,
.result-icon {
  font-size: 2rem;
}

.file-info,
.result-info {
  flex: 1;
  text-align: left;
}

.file-name,
.result-title {
  font-weight: 600;
  color: #333;
  margin-bottom: 4px;
}

.file-status,
.result-file {
  font-size: 0.9rem;
  color: #666;
}

.analyze-btn,
.new-analysis-btn {
  background: #28a745;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 0.9rem;
  transition: background-color 0.3s ease;
}

.analyze-btn:hover {
  background: #218838;
}

.new-analysis-btn {
  background: #007bff;
}

.new-analysis-btn:hover {
  background: #0056b3;
}

.upload-status-area {
  width: 100%;
  padding: 8px;
}

.status-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  width: 100%;
}

.status-left {
  flex: 1;
}

.status-label {
  font-size: 0.85rem;
  color: #666;
  margin-bottom: 8px;
  font-weight: 400;
}

.progress-container {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 8px;
}

.progress-bar {
  flex: 1;
  height: 8px;
  background: #e9ecef;
  border-radius: 4px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: #007bff;
  transition: width 0.3s ease;
  border-radius: 4px;
}

.status-percentage {
  font-size: 0.8rem;
  color: #333;
  font-weight: 500;
  min-width: 35px;
}

.status-filename {
  font-size: 0.8rem;
  color: #666;
}

@media (max-width: 768px) {
  .results-grid {
    grid-template-columns: 1fr;
    gap: 20px;
  }

  .dashboard {
    padding: 20px;
  }

  .tel-detection-card,
  .audio-analysis-card {
    padding: 20px;
  }
}

@media (min-width: 769px) {
  .dashboard {
    padding: 60px;
  }
}
</style>
