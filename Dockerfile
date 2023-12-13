FROM python:3.10.12

RUN apt-get update && apt-get install -y \
    postgresql \ 
    tk \
    && rm -rf /var/lib/apt/lists/*
    
WORKDIR /app

COPY . /

RUN python -m venv myenv
RUN /bin/bash -c "source myenv/bin/activate"

COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5432

CMD ["python", "main.py"]