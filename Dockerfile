FROM python:3.10.12

# Install PostgreSQL and other required dependencies
RUN apt-get update && apt-get install -y \
    postgresql \
    tk \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy all files from the current directory to the working directory in the container
COPY . /app

# Install Python dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install prometheus_client

# Download and install Flyway
WORKDIR /flyway
RUN apt-get update && \
    apt-get install -y wait-for-it && \
    wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/7.0.0/flyway-commandline-7.0.0-linux-x64.tar.gz | tar xvz && \
    ln -s /flyway/flyway-7.0.0/flyway /usr/local/bin/flyway && \
    apt-get remove -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Возвращаемся в /app
WORKDIR /app

# Define the default command to run when the container starts
CMD ["bash", "-c", "wait-for-it 192.168.1.3:5432 -- flyway repair -url=jdbc:postgresql://192.168.1.3:5432/postgres -user=postgres -password=qwerty && flyway migrate -url=jdbc:postgresql://192.168.1.3:5432/postgres -user=postgres -password=qwerty -locations=filesystem:db && python app/main.py"]