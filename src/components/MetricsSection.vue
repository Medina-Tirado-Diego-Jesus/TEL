<template>
  <section class="metrics-section">
    <h2>Resumen de métricas clave</h2>

    <div class="metrics-grid">
      <div class="metric-card">
        <div class="metric-label">Complejidad de la oración</div>
        <div class="metric-main-value">
          <strong
            >{{ metrics.complejidadOracion.etiqueta }}:
            {{ metrics.complejidadOracion.valor || '-' }}</strong
          >
        </div>
      </div>

      <div class="metric-card">
        <div class="metric-label">Riqueza del vocabulario</div>
        <div class="metric-main-value">
          <strong
            >{{ metrics.riquezaVocabulario.etiqueta }}:
            {{ metrics.riquezaVocabulario.valor || '-' }}</strong
          >
        </div>
      </div>

      <div class="metric-card">
        <div class="metric-label">Exactitud gramatical</div>
        <div class="metric-main-value">
          <strong
            >{{ metrics.exactitudGramatical.etiqueta }}:
            {{ metrics.exactitudGramatical.valor || '-'
            }}{{
              metrics.exactitudGramatical.valor ? metrics.exactitudGramatical.unidad || '' : ''
            }}</strong
          >
        </div>
      </div>

      <div class="metric-card">
        <div class="metric-label">Coherencia narrativa</div>
        <div class="metric-main-value">
          <strong
            >{{ metrics.coherenciaNarrativa.etiqueta }}:
            {{ metrics.coherenciaNarrativa.valor || '-'
            }}{{
              metrics.coherenciaNarrativa.valor ? `/${metrics.coherenciaNarrativa.total}` : ''
            }}</strong
          >
        </div>
      </div>

      <div class="metric-card">
        <div class="metric-label">Uso de lenguaje pragmático</div>
        <div class="metric-main-value">
          <strong
            >{{ metrics.usoLenguajePragmatico.etiqueta }}:
            {{ metrics.usoLenguajePragmatico.valor || '-'
            }}{{
              metrics.usoLenguajePragmatico.valor ? `/${metrics.usoLenguajePragmatico.total}` : ''
            }}</strong
          >
        </div>
      </div>

      <div class="metric-card">
        <div class="metric-label">Procesamiento fonológico</div>
        <div class="metric-main-value">
          <strong
            >{{ metrics.procesamientoFonologico.etiqueta }}:
            {{ metrics.procesamientoFonologico.valor || '-' }}</strong
          >
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
interface MetricValue {
  valor: number
  etiqueta: string
  total?: number
  unidad?: string
}

interface Metrics {
  complejidadOracion: MetricValue
  riquezaVocabulario: MetricValue
  exactitudGramatical: MetricValue
  coherenciaNarrativa: MetricValue
  usoLenguajePragmatico: MetricValue
  procesamientoFonologico: MetricValue
}

defineProps<{
  metrics: Metrics
}>()

defineEmits<{
  updateMetrics: [metrics: Metrics]
}>()
</script>

<style scoped>
.metrics-section {
  margin-top: 20px;
  width: 100%;
}

.metrics-section h2 {
  font-size: 1.1rem;
  color: #333;
  margin-bottom: 16px;
  font-weight: 600;
}

.metrics-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
  width: 100%;
  max-width: 1200px;
}

.metric-card {
  background: white !important;
  border-radius: 4px;
  padding: 20px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  border: 1px solid #e0e0e0;
  text-align: left;
  color: #333 !important;
  width: 100%;
}

.metric-label {
  font-size: 0.75rem;
  color: #666 !important;
  margin-bottom: 4px;
  font-weight: 400;
  line-height: 1.2;
}

.metric-main-value {
  font-size: 0.9rem;
  color: #333 !important;
  line-height: 1.3;
}

.metric-main-value strong {
  font-weight: 700;
  color: #333 !important;
}

/* Colores específicos para diferentes tipos de métricas */
.metric-card:nth-child(1) .metric-main-value {
  color: #333;
}
.metric-card:nth-child(2) .metric-main-value {
  color: #333;
}
.metric-card:nth-child(3) .metric-main-value {
  color: #333;
}
.metric-card:nth-child(4) .metric-main-value {
  color: #333;
}
.metric-card:nth-child(5) .metric-main-value {
  color: #333;
}
.metric-card:nth-child(6) .metric-main-value {
  color: #333;
}

@media (max-width: 768px) {
  .metrics-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 480px) {
  .metrics-grid {
    grid-template-columns: 1fr;
  }
}
</style>
