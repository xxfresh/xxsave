FROM python:3.10.4-slim-buster

# Install system dependencies and clean up
RUN apt update && apt upgrade -y && \
    apt-get install -y git curl wget python3-pip bash ffmpeg software-properties-common && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip3 install --no-cache-dir -U pip wheel && \
    pip3 install --no-cache-dir -U -r requirements.txt

# Set work directory
WORKDIR /app

# Copy application code
COPY . .

# Expose port
EXPOSE 8000

# Start the application
CMD flask run -h 0.0.0.0 -p 8000 && python3 -m devgagan
