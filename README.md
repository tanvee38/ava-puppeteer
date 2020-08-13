# ava-puppeteer
Simple example on how to run UI tests built with ava & puppeteer on docker container.

## Clone this repository
```git clone https://github.com/tanvee38/ava-puppeteer.git```
```cd ava-puppeteer```

## To run test locally:

1. install packages: ```npm install```
2. Run test: ```npm test```

## To run test on docker container:

1. Build docker image:  ```docker build -t ava-puppeteer .```
2. Run test on docker container: ```docker run ava-puppeteer npm test```
