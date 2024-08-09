<a id="readme-top"></a>

[![LinkedIn][linkedin-shield]][linkedin-url]

<br />
<div align="center">
  <h3 align="center">SHIFTS SERVICE</h3>

  <p align="center">
    The following project includes both the backend and frontend, providing a tool for shift management.
    <br />
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
  </ol>
</details>

## About The Project

[![Product Name Screen Shot][image_1]](https://example.com)
[![Product Name Screen Shot][image_4]](https://example.com)

This project is built on a microservices architecture, utilizing RabbitMQ as the messaging broker. The frontend is developed using Vue.js, while the backend is constructed with Ruby on Rails. This architecture ensures a scalable and efficient system for managing various components and services, allowing seamless communication between different parts of the application through RabbitMQ.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

[![Ruby on Rails][Rails-shield]][Rails-url]
[![PostgreSQL][Postgres-shield]][Postgres-url]
[![RabbitMQ][RabbitMQ-shield]][RabbitMQ-url]
[![Vue][Vue.js]][Vue-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.


1. **[Node.js](https://nodejs.org/)**:
   - **Description**: Node.js is a JavaScript runtime used for building server-side and networking applications.
   - **Installation**: Download and install Node.js from the [official website](https://nodejs.org/).

2. **[Ruby](https://www.ruby-lang.org/en/)**:
   - **Description**: Ruby is a dynamic, object-oriented programming language used for building web applications.
   - **Installation**: Follow the instructions on the [Ruby official site](https://www.ruby-lang.org/en/documentation/installation/).

3. **[Rails](https://rubyonrails.org/)**:
   - **Description**: Rails is a web application framework written in Ruby that helps you build websites and applications.
   - **Installation**: Install Rails using the following command:
     ```sh
     gem install rails
     ```

4. **[Docker Compose](https://docs.docker.com/compose/)**:
   - **Description**: Docker Compose is a tool for defining and running multi-container Docker applications.
   - **Installation**: If you have Docker Desktop, Docker Compose is included. Otherwise, install it separately using the instructions [here](https://docs.docker.com/compose/install/).

5. **[Git](https://git-scm.com/)**:
   - **Description**: Git is a version control system used to manage source code history.
   - **Installation**: Download and install Git from the [official site](https://git-scm.com/downloads).

### Additional Notes

- **Code Editor**: Having a code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Sublime Text](https://www.sublimetext.com/) will help you work efficiently with the project files.

- **Basic Knowledge**: Familiarity with Docker, Docker Compose, and version control with Git will make the setup process smoother.

Make sure to follow the installation instructions provided for each tool to ensure everything is set up correctly.

### Installation

_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Clone the repo
   ```sh
   git clone https://github.com/ajalvarez89/recorrido.git
   ```

`Easy Setup`

2. Setup and init the services with `docker compose` 🎉
   ```sh
    cd recorrido
    docker compose build
    docker compose up
   ```

`Manual configuration`

3. Clone the repo
   ```sh
   git clone https://github.com/ajalvarez89/recorrido.git
   ```
4. Install NPM packages for `shift-service-werbapp`
   ```sh
    cd shift-service-werbapp
    yarn install
    yarn serve
   ```
5. Install packages for `shift-service`
   ```sh
    cd shift-service
    bundle install
    bin/setup
   ```
6. Run the workers for `shift-service`
   ```sh
    bundle exec rake sneakers:run
   ```

6. Run the tests for `shift-service`
   ```sh
    bundle exec rspec

    Randomized with seed 19800
    ...............................................................................................................

    Finished in 1.42 seconds (files took 1.27 seconds to load)
    111 examples, 0 failures

    Randomized with seed 19800

   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Usage

## Endpoints Availables

| Resouce    | API Version | Methods             |
| -----------| ------------| --------------------|
| engineers  | v1          | index, show, create |
| services   | v1          | index, show, create |
| contracts  | v1          | index, show, create |
| shifts     | v1          | index, show, update |


## Endpoints

On the collection folder we are the complete collection postman for the resouces, however i'm gonna share the most importants resources in this part.

### engineers

#### Update a shift

- Method: `PUT`

- URL: `/v1/shifts/<id>`

- Request Example: N/A

- Response Example:

  ```json
  {
    "engineer_shifts_attributes": [
      {
          "engineer_id": "2531a333-80d7-4e61-9524-e6aa5f95f690",
          "status": "scheduled",
          "_destroy": false
        }
    ]
  }
  ```
#### List the shifts

- Method: `GET`

- URL: `/v1/shifts`

- Response Example:

  ```json
  [
    {
      "id": "3243d7f3-f9df-4d32-a7e0-9da6692c8c8f",
      "contract_id": "01efc5f8-2b06-40d2-8b47-e8c27e02d312",
      "date": "2024-08-19",
      "day_of_week": "Monday",
      "start_hour": "10:00",
      "end_hour": "11:00",
      "engineer_shifts": []
    },
    {
      "id": "22e32226-d5b2-40d4-be5c-de2c62dbb59f",
      "contract_id": "7a4abbf7-7d16-40bc-b45d-abf03fe8611b",
      "date": "2024-08-19",
      "day_of_week": "Monday",
      "start_hour": "15:00",
      "end_hour": "16:00",
      "engineer_shifts": [
        {
          "id": "d87eabbf-0c93-4bf4-9f3c-c6b2fcd914a3",
          "engineer_id": "41e38673-38ef-4793-a0de-0557055bcffe",
          "status": "scheduled",
          "_destroy": false
        },
        {
          "id": "5a98493c-c415-45ac-9aaa-8c0b567f2367",
          "engineer_id": "7a376b6c-6b06-4c0b-96a2-8f7010d598a2",
          "status": "confirmed",
          "_destroy": false
        }
      ]
    }
  ]
  ```

### Contract

#### Create a Contract
- Method: `POST`

- URL: `/v1/contracts`

- Request Example:

  ```json
  {
    "start_date": "2024-08-26",
    "start_hour_weekday":15,
    "end_hour_weekday":20,
    "start_hour_weekend":10,
    "end_hour_weekend":12,
    "service_id": "2497eaef-95d0-4489-b888-1e6beea3e85c"
  }
  ```

- Response Example:

  ```json
  {
    "id": "2ea164d1-5bce-43ce-80e8-fe92b131ef7c",
    "start_date": "2024-08-26T00:00:00Z",
    "end_date": "2024-09-01T00:00:00Z",
    "start_hour_weekday": 15,
    "end_hour_weekday": 20,
    "start_hour_weekend": 10,
    "end_hour_weekend": 12,
    "service_id": "2497eaef-95d0-4489-b888-1e6beea3e85c"
  }
  ```

# Asynchronous Shift Creation Workflow

## Overview

In our system, shifts are created asynchronously by a worker that listens for contract creation events. This approach ensures that the shift creation process does not block the main application flow and handles large volumes of data efficiently.

## Workflow Diagram

Below is a high-level overview of how shifts are created asynchronously:

```plaintext
[Client Request] 
    ↓
[Create Contract Event]
    ↓
[Publish Event to RabbitMQ] 
    ↓
[Worker Listens to RabbitMQ]
    ↓
[Worker Receives Contract Creation Event]
    ↓
[Worker Creates Shifts Based on Contract]
    ↓
[Shifts Created Successfully]
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[linkedin-url]: https://linkedin.com/in/ajalvarez-dev
[image_1]: collection/images/image_1.png
[image_4]: collection/images/image_4.png

[Rails-shield]: https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby&logoColor=white
[Rails-url]: https://rubyonrails.org/

[Postgres-shield]: https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white
[Postgres-url]: https://www.postgresql.org/

[RabbitMQ-shield]: https://img.shields.io/badge/RabbitMQ-FF6600?style=for-the-badge&logo=rabbitmq&logoColor=white
[RabbitMQ-url]: https://www.rabbitmq.com/

[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
