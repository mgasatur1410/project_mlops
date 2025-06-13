FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY scripts/ ./scripts/
COPY model/ ./model/
COPY input/ ./input/
COPY output/ ./output/
CMD ["python", "scripts/predict.py"] 