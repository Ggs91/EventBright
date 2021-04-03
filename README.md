![](/app/assets/images/EventBright.png)

An EventBrite clone application built from scratch with RubyOnRails!

Visit the app here [eventbright-prod-app.herokuapp.com](https://eventbright-prod-app.herokuapp.com/)

Login as a user or admin (admin has access to admin dashboard from profile dropdown button):

+ username: user or admin

+ password: password 

## Table of Contents  
- [I - Informations](#i---informations)
  * [1. Backend](#1-backend)
    + [1.1 Models & database structure](#11-models-and-database-structure)
    + [1.2 Authentication (Devise)](#12-authentication-devise)
    + [1.3 Authorization (CanCanCan)](#13-authorization-cancancan)
    + [1.4 Admin dashboard (Administrate)](#14-admin-dashboard-administrate)
    + [1.5 Payment system (Stripe)](#15-payment-system)
    + [1.5 Mailer (Action Mailer)](#16-mailer-action-mailer)
    + [1.6 Image upload (Active Storage & Cloudinary)](#16-active-storang-and-cloudinary)
  * [2. Frontend](#2-frontend)
  * [3. Dependencies](#3-dependencies)
- [II - Installation](#ii---installation)

## I - Informations

###  1. Backend
#### 1.1 Models and database structure
Currently there's 4 models: 
 - `User`: set for both regluar users of the app and administrators (with an `:admin` attribute set to `true`)
    - has one attached `avatar`
    - has many `administrated_events` (`Event` type)
    - has many `participations`
    - has many `attended_events` (`Event` type) through `participation`
 - `Event`: main subject resource
    - has many attached `images`
    - belongs to `administrator` (`User` type) 
    - has many `participations` 
    - has many `participants` (`User` type) through `participations`
    - has many `comments` as `commentable`
 - `Participation`: a user's participation to an event 
    - belongs to `user`
    - belongs to `event`
 - `Comment`: on events or other users comments
    - belongs to `commenter` (`User` type)
    - belongs to `commentable` (polymorphic)
    - has many `comments` as `commentable`


#### 1.2 Authentication (Devise)
I twisted the Devise configuration a little bit to allow users to use either email or username to sign in. Following the [Devise wiki](https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address) here's the few steps I've done: 
- Change the default authentication key to use `:login` instead of `:email`:
```ruby
# config/initializers/devise.rb

  config.authentication_keys = [:login]
```
- I made it mandatory to choose a username along with email & password during registration. So I had to permit it in strong parameters. Note: email also need to be explicitly permitted as well, it's no longer automatically permitted as it's not the default authentication key anymore.  
```ruby
# app/controllers/application_controller.rb

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:email, :username]) 
    devise_parameter_sanitizer.permit(:account_update,
      keys: [:first_name, :last_name, :description, :email])
  end
```
- In the `User` model I've set a virtual attribute that will be used in the sign in form to hold the value of the crendential entered by the user (either email or username). I overwrote the `find_for_database_authentication` Devise class method to extend the default query to search for both credentials in the DB.

```ruby
# app/models/user.rb

  class User < ApplicationRecord
   attr_accessor :login

   ...

   def self.find_for_database_authentication warden_condition
     conditions = warden_condition.dup
     login = conditions.delete(:login)
     where(conditions).where(
       ["lower(username) = :value OR lower(email) = :value",
       { value: login.strip.downcase }]).first
   end
 end
``` 

#### 1.3 Authorization ([CanCanCan](https://github.com/CanCanCommunity/cancancan))
Permissions are centralized in `app/models/ability.rb`. It enabled me to drastically DRY up the controllers by getting ride of many `before_action`s, and conveniently load a resource with the right permissions.

Here's some examples of permissions implemented: 

- Unauthenticated users can only access `event`'s `index` & `show` pages, but can't join it.
- Only `event`'s administrator can access the `event`'s profile (`show`) page if it's not validated by the (app) administrator yet. This is so an event's owner has still permission to updated or delete his event before it's published.
- Only validated `event`'s are displayed on the `index` page.
- Only `event`'s administrator can access `participant`s list.

#### 1.4 Admin dashboard ([Administrate](https://github.com/thoughtbot/administrate))
The admin dashboard is accessible under the "/admin" namespace. You can login as an admin with these credentials: `username: admin, password: password`.

When an event is newly created, it has its `validated` attribute set to `false`. It's not displayed on the index pages, and only its creator has permission to access the event `show` page in order to update or delete it. To be validated, an admin has to do it manually through the admin dashboard.

#### 1.4 Payment system ([Stripe](https://stripe.com/docs/development))

Event can either be free or paying. To checkout for paying events, enter testing card infos in the checkout form: 

- Card n° `4242 4242 4242 4242`
- Expiry date: any date in the future e.g. `12/25`
- CVV: any 3 digits e.g. `123`

#### 1.4 Mailer (Action Mailer)

Emails are sent after specific actions. When a user create an account (welcome email), or when a participation is created to summarize it with its `star_date`, `administrator` and number of `participants`. 

## II - Installation

1. Clone the project: open a terminal and type in
```
$ git clone https://github.com/Ggs91/EventBright.git
```
2. Change directory to `EventBright`:
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
