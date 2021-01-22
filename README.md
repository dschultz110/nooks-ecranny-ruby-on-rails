# Nook's eCranny

## Overview
This application is meant to demonstrate an eCommerce website using the Ruby on Rails framework.
It uses information from the [Animal Crossing New Horizons API](http://acnhapi.com/doc).

## Demo
A [demo of this app](https://nooks-ecranny.herokuapp.com/) is up and running but I removed the sign-up functionality.

## Screenshots
### Home
![Home Page](https://res.cloudinary.com/dschultz/image/upload/v1611325749/nooks-ecranny/Screen_Shot_2021-01-22_at_8.23.54_AM_t4wpfq.png)
### Items
![Items Page](https://res.cloudinary.com/dschultz/image/upload/v1611325760/nooks-ecranny/Screen_Shot_2021-01-22_at_8.25.07_AM_a3q2gp.png)
![Specific Item Page](https://res.cloudinary.com/dschultz/image/upload/v1611325744/nooks-ecranny/Screen_Shot_2021-01-22_at_8.26.13_AM_mau3iw.png)
### Cart
![Cart Page](https://res.cloudinary.com/dschultz/image/upload/v1611325739/nooks-ecranny/Screen_Shot_2021-01-22_at_8.27.43_AM_iln7ad.png)

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
