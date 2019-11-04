# README
This is a small application to share video by copy link from youtube then insert to database.


* Ruby version 2.5.1, rails 5.1.6

How to run app:
* clone app, run `bundle` to install missing gem

* init database first time by: `rake db:create && rake db:migrate`

* install missing npm package by: `yarn install`

* run webpack: `./bin/webpack-dev-server` or `./bin/webpack`

* run test: `rspec`, may you have to config and install selenium to run capybara automation test

* run rails server: `rails s`

all api: 

| Verb   | URI Pattern                      | Controller#Action          |
|--------|----------------------------------|----------------------------|
| GET    | /users(.:format)                 | users#index                |
| POST   | /users(.:format)                 | users#create               |
| GET    | /users/new(.:format)             | users#new                  |
| GET    | /users/:_username/edit(.:format) | users#edit                 |
| GET    | /users/:_username(.:format)      | users#show                 |
| PUT    | /users/:_username(.:format)      | users#update               |
| PATCH  | /users/:_username(.:format)      | users#update               |
| DELETE | /users/:_username(.:format)      | users#destroy              |
| POST   | /auth/login(.:format)            | authentication#login       |
| DELETE | /auth/logout(.:format)           | authentication#logout      |
| GET    | /auth/new(.:format)              | authentication#new_session |
| PUT    | /videos/:id/like(.:format)       | videos#like                |
| PUT    | /videos/:id/dislike(.:format)    | videos#dislike             |
| GET    | /videos(.:format)                | videos#index               |
| POST   | /videos(.:format)                | videos#create              |
| GET    | /videos/new(.:format)            | videos#new                 |
| GET    | /                                | videos#index               |
| GET    | /*a(.:format)                    | application#not_found      |
