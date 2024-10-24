FROM python:3.10

WORKDIR /app

COPY requirements.txt .

RUN pip install -r /app/requirements.txt

COPY djangoDeployProject djangoDeployProject/
COPY main main/

EXPOSE 8000

CMD ["uvicorn", "djangoDeployProject.asgi:application", "--host", "0.0.0.0", "--port", "8000", "--reload"]
#CMD gunicorn djangoDeployProject.asgi:application --workers 4 --worker-class uvicorn.workers.UvicornWorker --bind=0.0.0.0:8001