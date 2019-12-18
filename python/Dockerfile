FROM shinofara/docker-boto3
WORKDIR /app
COPY requirements.txt /app/
RUN pip install -r requirements.txt
COPY test.py /app/
CMD ["python", "test.py"]
