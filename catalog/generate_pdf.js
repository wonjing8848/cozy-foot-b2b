const puppeteer = require('puppeteer');
const path = require('path');

(async () => {
  const htmlPath = path.resolve(__dirname, 'catalog.html');
  const outPath = path.resolve(__dirname, 'goodshoe-catalog.pdf');

  console.log('🚀 Launching browser...');
  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage']
  });

  const page = await browser.newPage();

  // Set viewport to A4
  await page.setViewport({ width: 1000, height: 1414, deviceScaleFactor: 2 });

  console.log('📄 Loading HTML...');
  await page.goto(`file:///${htmlPath}`, { waitUntil: 'networkidle0', timeout: 30000 });

  // Wait for images to load
  await page.evaluate(async () => {
    const images = Array.from(document.querySelectorAll('img'));
    await Promise.all(images.map(img => {
      if (img.complete) return Promise.resolve();
      return new Promise((resolve, reject) => {
        img.onload = resolve;
        img.onerror = resolve;
        setTimeout(resolve, 2000);
      });
    }));
  });

  await new Promise(r => setTimeout(r, 1000));

  console.log('📦 Generating PDF...');
  await page.pdf({
    path: outPath,
    width: '1000px',
    height: '1414px',
    printBackground: true,
    margin: { top: '0', right: '0', bottom: '0', left: '0' }
  });

  await browser.close();
  console.log(`✅ Done: ${outPath}`);
})();
