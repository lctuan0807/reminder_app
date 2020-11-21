# Reminder Send SMS

This project will notify message to user after registration and setup reminder to send 2nd SMS to user after 7 days from registration date.

## Prerequisite

You should have an [Twilio](https://www.twilio.com) account (API to send SMS in this project). We need `account_sid`, `auth_token`, `phone_number` to setup.

## Setup

`bundle install`

`bin/rails db:setup`

### Start Redis server 

`redis-server`

### Start Sidekiq

`bundle exec sidekiq`

### Setup Twilio API by use rails credentials 

`EDITOR=vim rails credentials:edit`

Then config like this

```
twilio:
  account_sid: your_account_sid
  auth_token: your_auth_token
  phone_number: your_phone_number
```

## Testing

`bundle exec rspec spec`


