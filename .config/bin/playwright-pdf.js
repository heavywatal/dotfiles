#!/usr/bin/env node
const { chromium } = require('playwright');
const args = process.argv.slice(2);
const url = args[0];
const outfile = args[1];

(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  await page.goto(url);
  await page.pdf({
    path: outfile,
    format: 'A4',
    margin: {
      top: 30,
      bottom: 30,
      left: 30,
      right: 30,
    },
    printBackground: true,
  });
  await browser.close();
})();
