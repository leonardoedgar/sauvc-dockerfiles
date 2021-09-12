# sauvc-dockerfiles
A repository that contains the docker image for SAUVC

Owner: Leonardo Edgar (leonardo_edgar98@outlook.com)

## Table of Contents

   1. [Getting started](#1-getting-started)
   2. [Prerequisites](#2-prerequisites)
   3. [Installing](#3-installing)
   4. [Run](#4-run)
   5. [References](#5-references)

## 1. Getting started

Welcome to **NTU MECATron SAUVC (Singapore Autonomous Underwater Vehicle Challenge)** project! There are just a few steps to get you started with developing!

## 2. Prerequisites

1. Compute
    * Any computer (with amd64 architecture)
2. Arduino Mega 2560
3. Xsens MTi-300 (100 series)
4. Software packages
    * Git >= 2.17.2
    * [Docker](https://docs.docker.com/engine/install/ubuntu/) >= 20.10
    * [Docker Compose](https://docs.docker.com/compose/install/) >= 1.29.2

## 3. Installing

* To pull and update dependent repositories
```bash
./update-sourcecode.sh
```

* To build the development docker image
```bash
docker-compose -f docker-compose-dev.yaml build
```

* To build the deployment docker image
```bash
docker-compose build
```

* To build update the arduino liibrary
  1. Copy all libraries into ~/Arduino/libraries/
  2. Update the arduino using the development container
  ```bash 
  docker-compose -f docker-compose-dev.yaml run rosmaster cd Arduino/libraries && ./build_arduino.sh
  ```

## 4. Run

* To run the development container
```bash
docker-compose -f docker-compose-dev.yaml run rosmaster
```

* To run the deployment container
```bash
docker-compose up
```

* To run the IMU (Xsens MTi)
```bash
./run_imu_node.sh
```

## 5. References
* [Xsens MTi Driver](http://wiki.ros.org/xsens_mti_driver)
