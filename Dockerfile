# Base image with OpenJDK and minimal tools
FROM openjdk:11-jre-slim
 
# Set environment variables
ENV SELENIUM_JAR_VERSION=3.141.59
ENV CHROME_DRIVER_VERSION=114.0.5735.90
 
# Install dependencies, Chrome, ChromeDriver, and Xvfb
RUN apt-get update && apt-get install -y \
    wget unzip curl gnupg xvfb x11vnc --no-install-recommends && \
    curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-linux-signing-key.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-key.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin/ && \
    rm /tmp/chromedriver.zip && \
    wget -O /opt/selenium-server-standalone.jar https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-$SELENIUM_JAR_VERSION.jar && \
    rm -rf /var/lib/apt/lists/*
 
# Set up a virtual framebuffer (Xvfb) for GUI applications
RUN apt-get install -y xvfb && \
    mkdir /var/run/xvfb && chmod 777 /var/run/xvfb
 
# Set working directory
WORKDIR /app
 
# Copy project files to the container
COPY . /app
 
# Expose Selenium port and VNC port
EXPOSE 4444 5900
 
# Start Selenium Server and Xvfb
ENTRYPOINT ["sh", "-c", "Xvfb :99 -screen 0 1920x1080x16 & java -Dwebdriver.chrome.driver=/usr/local/bin/chromedriver -jar /opt/selenium-server-standalone.jar"]
