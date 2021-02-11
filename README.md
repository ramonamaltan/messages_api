## Messages API

### Table of contents
* [General info](#general-info)
* [Important note](#important-note)
* [Run the project locally](#run-the-project-locally)
* [Tests](#tests)

### General Info
This is a REST API built on Ruby on Rails with a PostgreSQL Database.
The Goal of the API is to maintain messages.
To structure the JSON response I customized the [JSON](https://jsonapi.org/format/#document-structure) output using JSON:API serializers 

The following statements are true about a message:
- it has a non-guessable identifier (UUID v4),
- it can contain characters coming from different languages,
- it does not support the usage of html tags,
- it has a maximum number of chars (255 characters),
- e-mail(s) and http link(s) can be part of the message,
- it has an internal counter of how many times the message was retrieved (unsigned number)

#### Important note
For the point 'e-mail(s) and http link(s) can be part of the message' I assumed that a message has_many emails and a message has_many links.
Thus I added 2 additional tables next to messages.
To display the associated Links and Emails to a Message I included the Link and Email Data as relationships using the JSON:API.
That's why the output looks like the following:
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
                        "id": "25",
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

### Tests
The project includes Unit Tests (tests/models/message_test.rb) and Functional Tests (tests/controllers/api/v1). To write my tests I uses Minitests.

Run all tests with:
```shell
rails test
```

### Endpoints

● List all messages
● Retrieve a single message via its identifier
● Create a message
● Update a message
● Delete a message

### Next Steps
- Set up Authorization with Tokens to restrict e.g. Updating and Deleting of messages to only the user who created the message 
- Include user model for reasons stated in point above
- Implement Possibility to filter and sort all Messages (params)
- add bullet gem to check for possible N+1 Queries
