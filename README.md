## Messages API

### Table of contents
* [General info](#general-info)
* [Important note](#important-note)
* [Run the project locally](#run-the-project-locally)
* [Tests](#tests)
* [API in Production](#api-in-production)
* [Call Endpoints](#call-endpoints)
* [Next Steps](#next-steps)

### General Info
This is a REST API built on Ruby on Rails with a PostgreSQL Database.
The Goal of the API is to maintain messages.
To structure the JSON response I customized the JSON output using [JSON:API](https://jsonapi.org/format/#document-structure) serializers 

The following statements are true about a message:
- it has a non-guessable identifier (UUID v4),
- it can contain characters coming from different languages,
- it does not support the usage of html tags,
- it has a maximum number of chars (255 characters),
- e-mail(s) and http link(s) can be part of the message,
- it has an internal counter of how many times the message was retrieved (unsigned number)

### Important note
For the point 'e-mail(s) and http link(s) can be part of the message' I assumed that a message has_many emails and a message has_many links.
Thus I added 2 additional tables next to messages.
To display the associated Links and Emails to a Message I included the Link and Email Data as relationships using the JSON:API.
That's why the output looks like the following: The message with id "892c1a5b-77b3-464f-9f6b-4b915788c485" has one link with id 25 and one email with id 16. The "included" attribute contains the data of this link and email.
```shell
{
    "data": {
        "id": "892c1a5b-77b3-464f-9f6b-4b915788c485",
        "type": "message",
        "attributes": {
            "content": "Hmm. In the end, cowards are those who follow the dark side."
        },
        "relationships": {
            "links": {
                "data": [
                    {
                        "id": "24",
                        "type": "link"
                    }
                ]
            },
            "emails": {
                "data": [
                    {
                        "id": "16",
                        "type": "email"
                    }
                ]
            }
        }
    },
    "included": [
        {
            "id": "24",
            "type": "link",
            "attributes": {
                "url": "http://herman.info/solomon.gutkowski"
            },
            "relationships": {
                "message": {
                    "data": {
                        "id": "892c1a5b-77b3-464f-9f6b-4b915788c485",
                        "type": "message"
                    }
                }
            }
        },
        {
            "id": "16",
            "type": "email",
            "attributes": {
                "email_address": "sachiko.cummerata@auer-bechtelar.info"
            },
            "relationships": {
                "message": {
                    "data": {
                        "id": "892c1a5b-77b3-464f-9f6b-4b915788c485",
                        "type": "message"
                    }
                }
            }
        }
    ]
}
```

### Run the project locally

The setup steps expect following tools installed on the system.

- Github
- Ruby
- Rails

#### Clone the repository

```shell
git clone git@github.com:ramonamaltan/messages_api.git
cd messages_api
```

#### Check your Ruby version

```shell
ruby -v
```

I use `ruby 2.6.6`

Install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.6.6
```

#### Install dependencies

Using [Bundler](https://github.com/bundler/bundler)

```shell
bundle
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

### Tests
The project includes Unit Tests (tests/models/message_test.rb) and Functional Tests (tests/controllers/api/v1). To write my tests I uses Minitests.

Run all tests with:
```shell
rails test
```
### API in Production
https://message-api-challenge.herokuapp.com/api/v1/messages

### Call Endpoints
Note: Use https://message-api-challenge.herokuapp.com instead of http://localhost:3000/ to call production API

##### List all messages
`GET /messages`
````
$ curl http://localhost:3000/api/v1/messages

Status 200 OK
````
##### Retrieve a single message via its identifier
`GET /messages/:uuid`
````
$ curl http://localhost:3000/api/v1/messages/{uuid}

Status: 200 OK
````
##### Create a message
`POST /messages`
````
$ curl -X POST \
-H 'Content-Type: application/json' \
-d '{ "message": { "content": "example content" } }' \
http://localhost:3000/api/v1/messages

Status: 201 Created
````
##### Update a message
`PATCH /messages/:uuid`
````
$ curl -i -X PATCH \
-H 'Content-Type: application/json' \
-d '{ "message": { "content": "updating the content" } }' \
http://localhost:3000/api/v1/messages/{uuid}

Status: 200 OK
````
##### Delete a message
`DELETE /messages/:uuid`
````
$ curl -i -X DELETE http://localhost:3000/api/v1/messages/{uuid}

Status: 204 No Content
````

### Next Steps
- Create endpoints for links and emails
- Create user interface for root page of my heroku app including the documentation
- Set up Authorization with Tokens to restrict e.g. Updating and Deleting of messages to only the user who created the message 
- Include user model for reasons stated in point above
- Implement Possibility to filter and sort all Messages (params)
- add bullet gem to check for possible N+1 Queries
