# README

This is Capture Image Database for Pretty Series (Japanese Animation for every)

Everyone can upload and watch the Capture Image (Capture Image: Picture of Anime)

This database can link the image to the many information, character, line, animation, description, episode and more...

"Min-na Tomodachi, Min-na Idol"

## Environment
- Ruby 2.5.1
- Rails 5.2.2

- DB: postgresql
- NoSQL: redis (for asynchronous processing, example: tweet regulary by sidekiq)
- Development: Docker
- Production: heroku

## Setup for Development
clone this repository and change delectory
```shell
# build Docker Image
$ docker-compose build

# setup database
$ docker-compose run app rake db:create ridgepole:apply db:seed

# remove pids files and start server
$ rm -rf tmp/pids && docker-compose up
```

Access `localhost:3000/` your brouwser

Stop Server: press `Ctr-l c` or `docker-compose down`

Enter Rails console
```shell
$ docker-compose run app rails c
```

## How to Deploy
deployment for heroku
```shell
# push and deploy master branch to heroku
$ git push heroku master

# db migration
$ heroku run rake ridgepole:apply_heroku
```

production environment needs...
- S3
- postgresql
- redis
- parameters
