# MoonBattery API

## Overview

The MoonBattery API is a Rails application designed to manage and interact with MoonBattery devices. It allows users to register batteries, ping them to check their status, and configure their settings.

## Features

- **User Authentication**: Secure login for MoonBattery devices using JWT tokens.
- **Battery Management**: Register, ping, and configure MoonBattery devices.

## Getting Started

### Prerequisites

- ruby 3.2.3
- Rails 7.2.1
- mysql 8.0.39

### Installation

1. Clone the repository:

  ```
   git clone https://github.com/yourusername/moonbattery.git
   cd moonbattery
  ```

2. Install the necessary gems:
   
```
bundle install
```

3. Set up your database:
   
```
rails db:create
rails db:migrate
```

4. Configure your environment variables for JWT:

```
EDITOR="nano" rails credentials:edit
SECRET_KEY_BASE=your_secret_key
```

6. Start the server:

```
rails server
```

## API Endpoints

### Authentication:
```
POST /login
```
Login and receive a JWT token.

### Moon Battery Management:
```
POST /moon_batteries/register
```
Register a new MoonBattery.
```
POST /moon_batteries/ping
```
Ping a registered MoonBattery.
```
POST /moon_batteries/configure
```
Update configurations for a MoonBattery.

## Example Requests

### Register Battery

```
curl --location 'http://0.0.0.0:3000/moon_batteries/register' \
--header 'Content-Type: application/json' \
--data '{
    "moon_battery": {
       "mac_address": "00-B0-D0-63-C2-26"
    }
}'
```

### login 

```
curl --location 'http://0.0.0.0:3000/login' \
--header 'Content-Type: application/json' \
--data '{
    "mac_address": "00-B0-D0-63-C2-26"
}'
```

### ping Battery

```
curl --location 'http://0.0.0.0:3000/moon_batteries/ping' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer eyour_jwt_token \
--data '{
    "moon_battery": {
       "mac_address": "00-B0-D0-63-C2-26"
    }
}'
```

### configure Battery

```
curl --location 'http://0.0.0.0:3000/moon_batteries/configure' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer your_jwt_token \
--data '{
    "moon_battery": {
       "mac_address": "00-B0-D0-63-C2-26",
       "configurations":[
        {
            "temperature":"30"
        },
        {
            "mode":"eco"
        }
       ]
    }
}'
```
