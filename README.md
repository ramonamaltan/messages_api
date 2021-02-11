# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
### Table of contents
* [General info](#general-info)
* [Setup](#Run the project locally)

### General Info

### Run the project locally

The setup steps expect following tools installed on the system.

- Github
- Ruby
- Rails

#### Clone the repository

```shell
git clone git@github.com:ramonamaltan/hoodgym.git
cd hoodgym
```

#### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.5.1`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.5.1
```

#### Install dependencies

Using [Bundler](https://github.com/bundler/bundler)

```shell
bundle && yarn
```

#### Initialize the database

```shell
rails db:create db:migrate db:seed
```

#### Start Rails server

```shell
rails s
```

And now you can visit the site with the URL http://localhost:3000
