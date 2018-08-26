FROM python:2.7
MAINTAINER ersivv

RUN pip install --upgrade pip \
	&& pip install --no-cache-dir platformio

# ESP32 & ESP8266 Arduino Frameworks for Platformio
RUN pio platform install espressif8266 --with-package framework-arduinoespressif8266 \
	&& pio platform install espressif32 \
	&& cat /root/.platformio/platforms/espressif32/platform.py \
	&& chmod 777 /root/.platformio/platforms/espressif32/platform.py \
	&& sed -i 's/~2/>=1/g' /root/.platformio/platforms/espressif32/platform.py \
	&& cat /root/.platformio/platforms/espressif32/platform.py

RUN rm -rf /var/cache/apt/* /tmp/* /var/tmp/*

RUN pio --version

# Define default command.
CMD ["sh"]	
