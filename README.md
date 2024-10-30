# Django project deploying example

#### Main source:
* [How to use Django with Uvicorn](https://docs.djangoproject.com/en/5.1/howto/deployment/asgi/uvicorn/)
* [Working with Static and Media Files in Django](https://testdriven.io/blog/django-static-files/)
* [Use Volumes to Manage Persistent Data With Docker Compose](https://kinsta.com/blog/docker-compose-volumes/)
* [Uvicorn Deployment](https://www.uvicorn.org/deployment/)
* [Виртуальные хосты. Несколько доменных имен на одном сервере](https://youtu.be/ZyGfUllQ34I?si=DMHeiygLY4n2ubfa)
-----------------------
* [Set SSL in nginx](https://www.youtube.com/watch?v=wWHSpEPG8ec)
* [Creating a Self-Signed SSL Certificate](https://linuxize.com/post/creating-a-self-signed-ssl-certificate/)
```shell
mkdir /etc/nginx/ssl

openssl req -newkey rsa:4096 \
            -x509 \
            -sha256 \
            -days 3650 \
            -nodes \
            -out /etc/nginx/ssl/nginx.crt \
            -keyout /etc/nginx/ssl/nginx.key          
```
Let’s breakdown the command and understand what each option means:

- newkey rsa:4096 - Creates a new certificate request and 4096 bit RSA key. The default one is 2048 bits.
- x509 - Creates a X.509 Certificate.
- sha256 - Use 265-bit SHA (Secure Hash Algorithm).
- days 3650 - The number of days to certify the certificate for. 3650 is ten years. You can use any positive integer.
- nodes - Creates a key without a passphrase.
- out nginx.crt - Specifies the filename to write the newly created certificate to. You can specify any file name.
- keyout nginx.key - Specifies the filename to write the newly created private key to. You can specify any file name.

Copy keys from container
```shell
docker cp nginx_service_con:/etc/nginx/ssl ./ssl
```

* [Logging Nginx](https://www.youtube.com/watch?v=cLYq2CU0JTM&list=PLhgRAQ8BwWFa7ulOkX0qi5UfVizGD_-Rc&index=11)
```shell

```
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
