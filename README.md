![](/app/assets/images/EventBright.png)

An EventBrite clone application built from scratch with RubyOnRails!

Visit the app here [eventbright-prod-app.herokuapp.com](https://eventbright-prod-app.herokuapp.com/)

Login as a user or admin (admin has access to admin dashboard from profile dropdown button):

+ username: user or admin

+ password: password 

## Table of Contents  
- [I - Informations](#i---informations)
  * [1. Backend](#1-backend)
    + [1.1 Authentication (Device)](#11-authentication-device)
    + [1.2 Authorization (CanCanCan)](#12-authorization-cancancan)
- [II - Installation](#ii---installation)

## I - Informations

###  1. Backend
#### 1.1 Authentication (Device)

#### 1.2 Authorization (CanCanCan)
## II - Installation

1. Clone the project: open a terminal and type in
```
$ git clone https://github.com/Ggs91/EventBright.git
```
2. Enter the repository:
```
$ cd EventBright
```
3. Download dependencies:

```
$ bundle install
```

4. Setup database:
```
$ rails db:create
$ rails db:migrate
$ rails db:seed
```

5. Start the server:
```
$ rails s 
```

6. Go to `http://localhost:3000`

## Author
**Georges Atalla**

Email - georges_atalla@hotmail.fr

Portfolio - [www.georgesatalla.com](https://www.georgesatalla.com/)

Github - https://github.com/Ggs91/
