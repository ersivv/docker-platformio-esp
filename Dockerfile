FROM alpine
MAINTAINER ersivv

RUN apk update \
	&& apk add --no-cache --update python \
	&& apk add --no-cache --update py-pip \
	&& pip install --no-cache-dir platformio
	
RUN pip install -U platformio

# ESP32 & ESP8266 Arduino Frameworks for Platformio
RUN pio platform install espressif8266 --with-package framework-arduinoespressif8266 \
	&& pio platform install espressif32 \
	&& cat /root/.platformio/platforms/espressif32/platform.py \
	&& chmod 777 /root/.platformio/platforms/espressif32/platform.py \
	&& sed -i 's/~2/>=1/g' /root/.platformio/platforms/espressif32/platform.py \
	&& cat /root/.platformio/platforms/espressif32/platform.py

RUN rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

RUN pio --version	
