<script>
export default {
  name: "AboutView",
  data() {
    return {
      stats: [
        {
          label: 'Megmentett állat',
          value: 230,
          icon: '🐾',
          percentage: 100
        },
        {
          label: 'Csapattagok',
          value: 15,
          icon: '👥',
          percentage: 85
        },
        {
          label: 'Év tapasztalat',
          value: 8,
          icon: '📅',
          percentage: 65
        }
      ]
    }
  }
}
</script>

<template>
  <section class="about-section">
    <!-- Hero Section -->
    <div class="hero-section">
      <div class="hero-content">
        <h1 class="hero-title">Mancs Állatmenhely</h1>
        <p class="hero-subtitle">Akiknek minden mancs számít</p>
      </div>
    </div>

    <!-- Introduction -->
    <div class="container-fluid py-5">
      <div class="row align-items-center mb-5">
        <div class="col-lg-6">
          <div class="intro-card">
            <h2 class="section-title">Történetünk</h2>
            <p class="intro-text">
              A Mancs Állatmenhely története 2016-ban kezdődött Budapest szívében, a III. kerületben. Alapítóként és tulajdonosként hárman vágtunk bele ebbe a küldetésbe egy egyszerű, de annál erősebb elhatározástól vezérelve: nem tudunk elmenni egyetlen bajba jutott, sérült vagy magára hagyott állat mellett sem.
            </p>
            <p class="intro-text">
              Ami akkoriban néhány megmentett kiskutyával indult, mára egy professzionális, mégis családias hangulatú menhellyé nőtte ki magát.
            </p>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="stats-grid">
            <div class="stat-card" v-for="(stat, index) in stats" :key="index">
              <div class="stat-icon">{{ stat.icon }}</div>
              <div class="stat-circle">
                <svg viewBox="0 0 100 100" class="progress-circle">
                  <circle class="circle-bg" cx="50" cy="50" r="45"></circle>
                  <circle class="circle-progress" cx="50" cy="50" r="45" :style="{strokeDashoffset: 283 - (283 * stat.percentage) / 100}"></circle>
                </svg>
                <div class="stat-value">{{ stat.value }}{{ stat.label === 'Év tapasztalat' ? ' év' : '+' }}</div>
              </div>
              <div class="stat-label">{{ stat.label }}</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Mission Section -->
    <div class="mission-section">
      <div class="container-fluid">
        <h2 class="section-title text-white text-center mb-5">Küldetésünk</h2>
        <p class="mission-quote text-center">Az otthon melege a rácsok mögött is</p>

        <div class="row mt-5">
          <div class="col-md-4 mb-4">
            <div class="mission-card">
              <div class="mission-icon">🍽️</div>
              <h3>Minőségi táplálás</h3>
              <p>Nem kötünk kompromisszumot, minden állatunk prémium eledelt kap.</p>
            </div>
          </div>
          <div class="col-md-4 mb-4">
            <div class="mission-card">
              <div class="mission-icon">🚶</div>
              <h3>Aktív életmód</h3>
              <p>Külön dedikált munkatársunk van, akinek kizárólagos feladata a kutyák napi sétáltatása és mentális lefárasztása.</p>
            </div>
          </div>
          <div class="col-md-4 mb-4">
            <div class="mission-card">
              <div class="mission-icon">❤️</div>
              <h3>Szakértelem és szeretet</h3>
              <p>15 fős csapatunk nap mint nap azon dolgozik, hogy rehabilitáljuk a sérült testű és lelkű állatokat.</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Activities Section -->
    <div class="container-fluid py-5">
      <h2 class="section-title text-center mb-5">Több, mint egy menhely</h2>

      <div class="highlight-banner mb-5">
        <h3 class="highlight-text">230+ állatnak segítettünk új esélyt adni az életre</h3>
      </div>

      <div class="row mb-5">
        <div class="col-md-6">
          <div class="activity-card">
            <div class="activity-number">01</div>
            <h3>Ivartalanítási program</h3>
            <p>Aktívan küzdünk a kóborállat-állomány növekedése ellen, ezzel előbbre haladva a felelős állattartás felé.</p>
          </div>
        </div>
        <div class="col-md-6">
          <div class="activity-card">
            <div class="activity-number">02</div>
            <h3>Edukáció és tanítás</h3>
            <p>Fontosnak tartjuk a gazdiképzést és a kutyák tanítását, hogy az örökbefogadás utáni beilleszkedés zökkenőmentes legyen.</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Quote Section -->
    <div class="quote-section">
      <div class="quote-container">
        <p class="quote-text">"Nem az állatoknak van szükségük ránk, hanem nekünk van szerencsénk, hogy az életük részei lehetünk."</p>
      </div>
    </div>

    <!-- CTA Section -->
    <div class="container-fluid py-5 cta-section">
      <h2 class="section-title text-center mb-4">Szeretne részese lenni a történetünknek?</h2>
      <p class="cta-text text-center">Nézzen körül nálunk, látogasson el eseményeinkre, vagy foglaljon időpontot egy személyes találkozóra!</p>
    </div>
  </section>
</template>

<style scoped>
.about-section {
  background: #F8F9FA;
  min-height: 100vh;
}

/* Hero Section */
.hero-section {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 80px 20px;
  text-align: center;
  margin-bottom: 40px;
}

.hero-title {
  font-size: 3.5rem;
  font-weight: 700;
  margin-bottom: 10px;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
}

.hero-subtitle {
  font-size: 1.5rem;
  font-weight: 300;
  opacity: 0.9;
}

/* Intro Section */
.intro-card {
  background: white;
  padding: 40px;
  border-radius: 15px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.intro-text {
  font-size: 1.1rem;
  line-height: 1.8;
  color: #555;
  margin-bottom: 20px;
}

.intro-text:last-child {
  margin-bottom: 0;
}

/* Stats Grid */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
  gap: 30px;
  padding: 20px;
}

.stat-card {
  background: white;
  padding: 30px;
  border-radius: 15px;
  text-align: center;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.stat-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
}

.stat-icon {
  font-size: 2.5rem;
  margin-bottom: 15px;
}

.stat-circle {
  position: relative;
  width: 120px;
  height: 120px;
  margin: 0 auto 15px;
}

.progress-circle {
  width: 100%;
  height: 100%;
  transform: rotate(-90deg);
}

.circle-bg {
  fill: none;
  stroke: #e0e0e0;
  stroke-width: 6;
}

.circle-progress {
  fill: none;
  stroke: url(#gradient);
  stroke-width: 6;
  stroke-linecap: round;
  stroke-dasharray: 283;
  stroke-dashoffset: 283;
  transition: stroke-dashoffset 1s ease;
}

.stat-value {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  font-size: 1.5rem;
  font-weight: 700;
  color: #667eea;
}

.stat-label {
  font-size: 0.9rem;
  color: #888;
  font-weight: 500;
}

/* Mission Section */
.mission-section {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 60px 20px;
  margin: 40px 0;
}

.mission-quote {
  font-size: 1.5rem;
  font-weight: 300;
  font-style: italic;
  margin-bottom: 40px;
  opacity: 0.9;
}

.mission-card {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  padding: 40px;
  border-radius: 15px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  transition: all 0.3s ease;
  height: 100%;
}

.mission-card:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: translateY(-5px);
}

.mission-icon {
  font-size: 3rem;
  margin-bottom: 20px;
  display: block;
}

.mission-card h3 {
  font-size: 1.3rem;
  margin-bottom: 15px;
  font-weight: 600;
}

.mission-card p {
  font-size: 0.95rem;
  line-height: 1.6;
  opacity: 0.9;
}

/* Section Title */
.section-title {
  font-size: 2.5rem;
  font-weight: 700;
  color: #667eea;
  margin-bottom: 30px;
  position: relative;
  padding-bottom: 20px;
}

.section-title::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 60px;
  height: 4px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 2px;
}

.mission-section .section-title::after {
  background: rgba(255, 255, 255, 0.3);
}

/* Highlight Banner */
.highlight-banner {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 40px;
  border-radius: 15px;
  text-align: center;
  box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
}

.highlight-text {
  font-size: 1.8rem;
  font-weight: 600;
  margin: 0;
}

/* Activity Cards */
.activity-card {
  background: white;
  padding: 40px;
  border-radius: 15px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  position: relative;
  border-left: 5px solid #667eea;
  transition: all 0.3s ease;
}

.activity-card:hover {
  transform: translateX(10px);
  box-shadow: 0 15px 40px rgba(102, 126, 234, 0.2);
}

.activity-number {
  position: absolute;
  top: -15px;
  right: 30px;
  font-size: 3rem;
  font-weight: 700;
  color: #667eea;
  opacity: 0.1;
}

.activity-card h3 {
  font-size: 1.5rem;
  color: #667eea;
  margin-bottom: 15px;
  font-weight: 600;
}

.activity-card p {
  font-size: 1rem;
  color: #666;
  line-height: 1.6;
  margin: 0;
}

/* Quote Section */
.quote-section {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 60px 20px;
  margin: 40px 0;
  text-align: center;
}

.quote-container {
  max-width: 800px;
  margin: 0 auto;
}

.quote-text {
  font-size: 1.8rem;
  color: white;
  font-style: italic;
  font-weight: 300;
  line-height: 1.8;
  margin: 0;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
}

/* CTA Section */
.cta-section {
  background: white;
  border-top: 2px solid #e0e0e0;
}

.cta-text {
  font-size: 1.2rem;
  color: #666;
  margin: 0;
}

/* Responsive */
@media (max-width: 768px) {
  .hero-title {
    font-size: 2.5rem;
  }

  .hero-subtitle {
    font-size: 1.2rem;
  }

  .stats-grid {
    grid-template-columns: 1fr;
    gap: 20px;
  }

  .section-title {
    font-size: 1.8rem;
  }

  .highlight-text {
    font-size: 1.3rem;
  }

  .quote-text {
    font-size: 1.3rem;
  }

  .intro-card {
    padding: 20px;
  }
}

@media (max-width: 480px) {
  .hero-section {
    padding: 40px 15px;
  }

  .hero-title {
    font-size: 2rem;
  }

  .hero-subtitle {
    font-size: 1rem;
  }

  .mission-card {
    padding: 20px;
  }

  .activity-card {
    padding: 20px;
  }
}
</style>