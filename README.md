# Django project deploying example

### Run django project
```shell
py manage.py runserver

uvicorn djangoDeployProject.asgi:application
```

### Create container
```shell
docker build -t django-deploy .

docker run -it --name django-deploy -p 8000:8000 --rm  django-deploy
```

### Git

```shell
git init
git add .
get status
git commit -m "initial commit"
git branch -M main
git remote add origin https://github.com/infoplazma/djangoDeployProject.git
git push -u origin main

```