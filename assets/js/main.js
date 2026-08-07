/* goodshoe MFG · B2B site interactions */

(() => {
  // --- Reveal on scroll ---
  const io = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.classList.add('in');
        io.unobserve(e.target);
      }
    });
  }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });
  document.querySelectorAll('.reveal').forEach(el => io.observe(el));

  // --- Smooth scroll for in-page links ---
  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', e => {
      const id = a.getAttribute('href');
      if (id.length < 2) return;
      const target = document.querySelector(id);
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  });

  // --- Header shadow on scroll ---
  const nav = document.querySelector('.nav-wrap');
  if (nav) {
    const onScroll = () => {
      if (window.scrollY > 4) nav.style.boxShadow = '0 4px 20px -10px rgba(0,0,0,.08)';
      else nav.style.boxShadow = '';
    };
    onScroll();
    window.addEventListener('scroll', onScroll, { passive: true });
  }

  // --- File upload UI ---
  const fileInput = document.getElementById('files');
  const fileLabel = fileInput?.closest('.form-file');
  if (fileInput && fileLabel) {
    fileInput.addEventListener('change', () => {
      const files = Array.from(fileInput.files);
      if (files.length === 0) return;
      const names = files.map(f => f.name).join(', ');
      const sizes = files.reduce((a, f) => a + f.size, 0);
      const sizeMB = (sizes / 1024 / 1024).toFixed(1);
      fileLabel.querySelector('strong').textContent = `${files.length} file${files.length > 1 ? 's' : ''} selected (${sizeMB} MB)`;
      fileLabel.querySelector('span').textContent = names.length > 60 ? names.slice(0, 60) + '…' : names;
      fileLabel.style.borderColor = 'var(--c-pine)';
      fileLabel.style.background = 'rgba(31,72,66,.04)';
    });

    // Drag & drop
    ['dragenter', 'dragover'].forEach(ev => {
      fileLabel.addEventListener(ev, e => { e.preventDefault(); fileLabel.style.borderColor = 'var(--c-pine)'; });
    });
    ['dragleave', 'drop'].forEach(ev => {
      fileLabel.addEventListener(ev, e => { e.preventDefault(); fileLabel.style.borderColor = 'var(--c-line)'; });
    });
    fileLabel.addEventListener('drop', e => {
      e.preventDefault();
      fileInput.files = e.dataTransfer.files;
      fileInput.dispatchEvent(new Event('change'));
    });
  }

  // --- Auto-select service/product from URL query string (e.g. ?service=oem&product=memory) ---
  const params = new URLSearchParams(window.location.search);
  const svc = params.get('service');
  const prod = params.get('product');
  if (svc) {
    const svcMap = { oem: 'OEM Manufacturing', odm: 'ODM & Design', white: 'White Label', gift: 'Gift Sets', retail: 'Retail / Bulk', promo: 'Promotional / Branded' };
    const svcSel = document.querySelector('select[name="service"]');
    if (svcSel && svcMap[svc]) svcSel.value = svcMap[svc];
  }
  if (prod) {
    const prodMap = { chenille: 'Hand-tufted chenille slipper', memory: 'Memory foam slipper', boot: 'Boot-style slipper', gift: 'Gift set / bundle' };
    const prodSel = document.querySelector('select[name="product"]');
    if (prodSel && prodMap[prod]) prodSel.value = prodMap[prod];
  }
})();
