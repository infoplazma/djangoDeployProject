# Django project deploying example

#### Main source:
* [How to use Django with Uvicorn](https://docs.djangoproject.com/en/5.1/howto/deployment/asgi/uvicorn/)
* [Working with Static and Media Files in Django](https://testdriven.io/blog/django-static-files/)
* [Use Volumes to Manage Persistent Data With Docker Compose](https://kinsta.com/blog/docker-compose-volumes/)
* [Uvicorn Deployment](https://www.uvicorn.org/deployment/)
-----------------------

## Development mode
### Run django project in Development Mode
```shell
py manage.py runserver

uvicorn djangoDeployProject.asgi:application
```
--------------------
## Production mode

Don't forget in settings.py changing:
```python
# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

ALLOWED_HOSTS = ["127.0.0.1", "http://django_service", "django_service"]  #, "*"
```

In terminal:
```shell
python.exe manage.py collectstatic --noinput 
```


Create docker container:
```shell
docker build -t django-deploy .

docker run -it --name django-deploy -p 8000:8000 --rm  django-deploy
```
Create docker containers with docker compose:
```shell
docker-compose up
```

Mount Volumes To Containers:
```yaml
version: '3.8'
services:
  web:
    image: nginx
    volumes:
      - web_data:/var/www/html
  web-test:
    image: nginx
    volumes:
      - web_data:/var/www/html # Web and web test share the web_data volume
  db:
    image: mysql
    volumes:
      - db_data:/var/lib/mysql
volumes:
  web_data:
  db_data:
    driver: local # Define the driver and options under the volume name
    driver_opts:
      type: none
      device: /data/db_data
      o: bind
```
---------------------------------
### Other helpful

#### Port checking:
Check ports:
```shell
netstat -aon | find /i "listening"
netstat -ano | findstr :8000
```

The final number on both lines is the process ID (PID) of the process using port 8080. Using this PID, we can end the process with taskkill:
```shell
taskkill /PID 2660 /F
```

IP address:
```shell
ipconfig/all
```

#### Git:

```shell
git init
git add .
get status
git commit -m "initial commit"
git branch -M main
git remote add origin https://github.com/infoplazma/djangoDeployProject.git
git push -u origin main

```

Clone from github
```shell
git clone https://github.com/infoplazma/djangoDeployProject.git
```

There are two major commands that you can use to undo “git add” or remove added files in Git. In other words, 
you can use two major commands to remove staged files from the staging area:
```shell
git reset
git rm --cached
```
