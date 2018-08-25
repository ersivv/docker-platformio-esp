FROM alpine
MAINTAINER ersivv

RUN apt-get update \
	&& apt-get install -y python python-pip \
	&& pip install --no-cache-dir platformio \
	
RUN pip install -U platformio

# ESP32 & ESP8266 Arduino Frameworks for Platformio

RUN pio platform install espressif8266 --with-package framework-arduinoespressif8266 \
	&& pio platform install espressif32 \
	&& cat /root/.platformio/platforms/espressif32/platform.py \
	&& chmod 777 /root/.platformio/platforms/espressif32/platform.py \
	&& sed -i 's/~2/>=1/g' /root/.platformio/platforms/espressif32/platform.py \
	&& cat /root/.platformio/platforms/espressif32/platform.py

RUN apt-get -y remove python-pip \
	&& apt-get -y autoremove \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
	
RUN pio --version	
