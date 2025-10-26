# Base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy src folder
COPY src/ ./src/

# Default command (example: run a script)
CMD ["python", "src/run/predict.py"]