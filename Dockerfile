FROM python:3.10.12


RUN apt-get update && apt-get install -y \
    postgresql \
    tk \
    wget \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /app


COPY . /app


COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install prometheus_client


WORKDIR /flyway
RUN apt-get update && \
    apt-get install -y wait-for-it && \
    wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/7.0.0/flyway-commandline-7.0.0-linux-x64.tar.gz | tar xvz && \
    ln -s /flyway/flyway-7.0.0/flyway /usr/local/bin/flyway && \
    apt-get remove -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


WORKDIR /app


CMD ["bash", "-c", "wait-for-it 192.168.1.70:5432 -- flyway repair -url=jdbc:postgresql://192.168.1.70:5432/postgres -user=postgres -password=qwerty && flyway migrate -url=jdbc:postgresql://192.168.1.70:5432/postgres -user=postgres -password=qwerty -locations=filesystem:db && python app/main.py"]