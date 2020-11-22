# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ShortMessageTemplate.destroy_all
ShortMessageTemplate.create(name: 'Welcome SMS template', content: 'Welcome to our services, thanks so much!')
ShortMessageTemplate.create(name: 'SMS after 7 days registration', content: 'You have used our service for 7 days. Thanks!')

Reminder.destroy_all
Reminder.create(title: 'Notify SMS after 7 days registration', period: 7, period_type: 'day', sms_template_id: 2)