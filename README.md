# ava-puppeteer
Simple ava-puppeteer test running in docker

To run test locally:

1. install packages: npm install
2. Run test: npm test

To run test on docker container:

1. docker build -t ava-puppeteer .
2. docker run ava-puppeteer npm test
