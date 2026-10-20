/* ==========================================================================
   PrintZap Landing Page - Interactive Logic, i18n & Calculators
   ========================================================================== */

document.addEventListener('DOMContentLoaded', () => {
  // Current Language State (Default: 'it')
  let currentLang = localStorage.getItem('printzap_lang') || 'it';

  // Helper to safely get translations dictionary
  const getTranslations = () => {
    if (typeof window !== 'undefined' && window.TRANSLATIONS) return window.TRANSLATIONS;
    if (typeof TRANSLATIONS !== 'undefined') return TRANSLATIONS;
    return null;
  };

  // 1. Language Switcher Engine
  const setLanguage = (lang) => {
    const dict = getTranslations();
    if (!dict || !dict[lang]) return;
    currentLang = lang;
    localStorage.setItem('printzap_lang', lang);

    // Update active button state
    document.querySelectorAll('.lang-btn').forEach(btn => {
      btn.classList.toggle('active', btn.getAttribute('data-lang') === lang);
    });

    // Update all translatable elements
    const elements = document.querySelectorAll('[data-i18n]');
    elements.forEach(el => {
      const key = el.getAttribute('data-i18n');
      const translation = dict[lang] ? dict[lang][key] : undefined;
      if (translation !== undefined) {
        // Se contiene tag HTML (es. <span> o <strong>), usiamo innerHTML
        if (translation.includes('<') && translation.includes('>')) {
          el.innerHTML = translation;
        } else {
          el.textContent = translation;
        }
      }
    });

    // Re-run calculator to update localized labels (hours/min/stress)
    if (typeof updateCalculator === 'function') {
      updateCalculator();
    }
  };

  // Bind Language Switcher Buttons
  const langButtons = document.querySelectorAll('.lang-btn');
  langButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const lang = btn.getAttribute('data-lang');
      if (lang && lang !== currentLang) {
        setLanguage(lang);
      }
    });
  });

  // 2. Interactive Time Savings Calculator
  const filesSlider = document.getElementById('filesSlider');
  const filesCountDisplay = document.getElementById('filesCountDisplay');
  const timeSavedDay = document.getElementById('timeSavedDay');
  const timeSavedMonth = document.getElementById('timeSavedMonth');
  const stressSaved = document.getElementById('stressSaved');

  const updateCalculator = () => {
    if (!filesSlider) return;
    const files = parseInt(filesSlider.value, 10);
    if (filesCountDisplay) filesCountDisplay.textContent = files;

    // ~2.2 minuti a file risparmiati rispetto alla gestione manuale
    const minutesSavedPerDay = Math.round(files * 2.2);
    const hoursSavedPerDay = (minutesSavedPerDay / 60).toFixed(1);
    
    // Calcolo mensile (25 giorni lavorativi di cartoleria)
    const hoursSavedPerMonth = Math.round(hoursSavedPerDay * 25);

    const isEn = currentLang === 'en';
    const hoursUnit = isEn ? 'hours' : 'ore';
    const minUnit = isEn ? 'mins' : 'min';

    if (timeSavedDay) {
      if (minutesSavedPerDay >= 60) {
        timeSavedDay.textContent = `${hoursSavedPerDay} ${hoursUnit}`;
      } else {
        timeSavedDay.textContent = `${minutesSavedPerDay} ${minUnit}`;
      }
    }

    if (timeSavedMonth) {
      timeSavedMonth.textContent = `${hoursSavedPerMonth} ${hoursUnit}`;
    }

    if (stressSaved) {
      if (files < 30) {
        stressSaved.textContent = isEn ? "Low" : "Basso";
      } else if (files < 70) {
        stressSaved.textContent = isEn ? "Very High" : "Elevatissimo";
      } else {
        stressSaved.textContent = isEn ? "Total (Zero Chaos)" : "Totale (Zero Caos)";
      }
    }
  };

  if (filesSlider) {
    filesSlider.addEventListener('input', updateCalculator);
  }

  // 3. FAQ Accordion Logic
  const faqItems = document.querySelectorAll('.faq-item');
  faqItems.forEach(item => {
    const question = item.querySelector('.faq-question');
    if (question) {
      question.addEventListener('click', () => {
        const isActive = item.classList.contains('active');
        faqItems.forEach(i => i.classList.remove('active'));
        if (!isActive) {
          item.classList.add('active');
        }
      });
    }
  });

  // 4. WhatsApp Direct Contact Handler (Reggio Calabria +39 0965 370621)
  const waContactBtns = document.querySelectorAll('.js-wa-contact');
  waContactBtns.forEach(btn => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
      const phone = btn.getAttribute('data-phone') || '390965370621';
      const msgKey = currentLang === 'en' ? 'wa_msg' : 'wa_msg';
      const dict = getTranslations();
      const defaultText = dict && dict[currentLang] 
        ? dict[currentLang][msgKey] 
        : "Ciao! Vorrei maggiori informazioni su PrintZap per la mia cartoleria.";
      const text = encodeURIComponent(defaultText);
      const url = `https://wa.me/${phone}?text=${text}`;
      window.open(url, '_blank');
    });
  });

  // 5. Legal & Privacy GDPR Modal Logic
  const openLegalModalBtn = document.getElementById('openLegalModal');
  const closeLegalModalBtn = document.getElementById('closeLegalModal');
  const legalModal = document.getElementById('legalModal');

  if (openLegalModalBtn && legalModal) {
    openLegalModalBtn.addEventListener('click', (e) => {
      e.preventDefault();
      legalModal.classList.add('active');
    });
  }

  if (closeLegalModalBtn && legalModal) {
    closeLegalModalBtn.addEventListener('click', () => {
      legalModal.classList.remove('active');
    });
  }

  if (legalModal) {
    legalModal.addEventListener('click', (e) => {
      if (e.target === legalModal) {
        legalModal.classList.remove('active');
      }
    });
  }

  // Initialize Language on Page Load
  setLanguage(currentLang);
});
