# Skolera-Rails-Task

Simple implementation for a school system involving Teachers, Students and Courses.
Things you may want to cover:

## Environment

* Ruby version: 2.5.3p105

* Rails version: 5.2.2

* Database: mysql for development, pg for deployment.

## Issued faced

* The Devise gem provided in the task actually didn't work with a Rails API Project, i guess it was intended for regular projects, so i used [devise-token-auth](https://github.com/lynndylanhurley/devise_token_auth) instead.


## Background Workers

```
Export users to csv file using sidekiq.
Exported file is stored in 'app/exports/users.csv' using a BG job and replying with a successfully added to queue message.
```

## Endpoints
* Authentication:
```
GET    /auth/sign_in(.:format)                                                                  devise_token_auth/sessions#new
POST   /auth/sign_in(.:format)                                                                  devise_token_auth/sessions#create
DELETE /auth/sign_out(.:format)                                                                 devise_token_auth/sessions#destroy
GET    /auth/password/new(.:format)                                                             devise_token_auth/passwords#new
GET    /auth/password/edit(.:format)                                                            devise_token_auth/passwords#edit
PATCH  /auth/password(.:format)                                                                 devise_token_auth/passwords#update
PUT    /auth/password(.:format)                                                                 devise_token_auth/passwords#update
POST   /auth/password(.:format)                                                                 devise_token_auth/passwords#create
GET    /auth/cancel(.:format)                                                                   devise_token_auth/registrations#cancel
GET    /auth/sign_up(.:format)                                                                  devise_token_auth/registrations#new
GET    /auth/edit(.:format)                                                                     devise_token_auth/registrations#edit
PATCH  /auth(.:format)                                                                          devise_token_auth/registrations#update
PUT    /auth(.:format)                                                                          devise_token_auth/registrations#update
DELETE /auth(.:format)                                                                          devise_token_auth/registrations#destroy
POST   /auth(.:format)                                                                          devise_token_auth/registrations#create
GET    /auth/validate_token(.:format)                                                           devise_token_auth/token_validations#validate_token
```
* Teacher:
```
GET    /api/v1/teachers(.:format)                                                               api/v1/teachers#index
POST   /api/v1/teachers(.:format)                                                               api/v1/teachers#create
GET    /api/v1/teachers/:id(.:format)                                                           api/v1/teachers#show
PATCH  /api/v1/teachers/:id(.:format)                                                           api/v1/teachers#update
PUT    /api/v1/teachers/:id(.:format)                                                           api/v1/teachers#update
DELETE /api/v1/teachers/:id(.:format)                                                           api/v1/teachers#destroy
```

* Student:
```
GET    /api/v1/students(.:format)                                                               api/v1/students#index
POST   /api/v1/students(.:format)                                                               api/v1/students#create
GET    /api/v1/students/:id(.:format)                                                           api/v1/students#show
PATCH  /api/v1/students/:id(.:format)                                                           api/v1/students#update
PUT    /api/v1/students/:id(.:format)                                                           api/v1/students#update
DELETE /api/v1/students/:id(.:format)                                                           api/v1/students#destroy
```
* Course:
```
POST   /api/v1/courses/:id/add_student(.:format)                                                api/v1/courses#add_student
DELETE /api/v1/courses/:id/remove_student(.:format)                                             api/v1/courses#remove_student
POST   /api/v1/courses/:id/assign_teacher(.:format)                                             api/v1/courses#assign_teacher
DELETE /api/v1/courses/:id/remove_teacher(.:format)                                             api/v1/courses#remove_teacher
GET    /api/v1/courses(.:format)                                                                api/v1/courses#index
POST   /api/v1/courses(.:format)                                                                api/v1/courses#create
GET    /api/v1/courses/:id(.:format)                                                            api/v1/courses#show
PATCH  /api/v1/courses/:id(.:format)                                                            api/v1/courses#update
PUT    /api/v1/courses/:id(.:format)                                                            api/v1/courses#update
DELETE /api/v1/courses/:id(.:format)                                                            api/v1/courses#destroy
```
* User:

```
GET    /api/v1/users(.:format)                                                                  api/v1/users#index
```
