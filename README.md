# Nook's eCranny

## Overview
This application is meant to demonstrate an eCommerce website using the Ruby on Rails framework.
It uses information from the [Animal Crossing New Horizons API]("http://acnhapi.com/doc").

## Demo
A [demo of this app]("https://nooks-ecranny.herokuapp.com/") is up and running minus the sign-up functionality.

## Configuration
To get this project running, after cloning this repository enter the following commands:
```
cd nooks-ecranny
bundle install
yarn install
rails db:migrate
rails db:seed
```
The above commands install the ruby and javascript dependencies, as well as set up a SQLite database with the required data using the seed script.
