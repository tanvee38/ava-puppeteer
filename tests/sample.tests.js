const {test} = require('ava');

import puppeteer from 'puppeteer';

let browser;
let page;

test.serial('Simple test', async t => {
  browser = await puppeteer.launch({
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
    headless: true,
    executablePath: process.env.CHROMIUM_PATH
  });
    
  page = await browser.newPage();

  await page.goto('https://www.athabascau.ca/', {waitUntil: 'networkidle0'});

  const title = await page.evaluateHandle(`document.querySelector('#content-title')`);

  const titleText = await page.evaluate(title => title.textContent, title);

  t.is(titleText, "How AU Works Athabasca University");
});