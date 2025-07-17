FROM python:3.10-slim-bookworm

# Install system dependencies and clean up cache
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        git \
        curl \
        wget \
        ffmpeg \
        bash \
        software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .

# Upgrade pip and install Python dependencies
RUN pip install --no-cache-dir --upgrade pip wheel && \
    pip install --no-cache-dir --upgrade -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the default port (adjust if your app uses a different one)
EXPOSE 8000

# Start the application
CMD ["flask", "run", "-h", "0.0.0.0", "-p", "8000"]
