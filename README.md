# Jimothy
Placeholder user data from The Office.
Gem available at https://rubygems.org/gems/jimothy

![The office characters](https://github.com/mark-mcdermott/jimothy/blob/main/lib/jimothy/images/flonkerton.jpg)

## What This Does

Quickly seed placeholder user data for your Rails toy app or prototype app. Generate the names, emails and profile pictures of eighteen characters from The Office.

## Why

This is a (much) less robust version of something like Faker (https://github.com/faker-ruby/faker). But I built it to be more reliable than Faker, with more solid data. Faker is great for what it does, but if you generate users from TV data for example, sometimes users get weird names like "Skinny Pete", where "Pete" isn't really a last name and it can mess up your data. Yeah it's just placeholder data, but we want it to look right.

## Usage (Quick, Using Custom Generator)
- (If you don't have an app already) Run `rails new testapp`
- Add `gem "jimothy"` to your `Gemfile`
- Run `bundle install`
- Run `rails g jimothy:install`
- This will scaffold user model/views, import images, seed users and add an image tag to the user view's `_user.html.erb` partial.
- Run `rails server` and open `http://127.0.0.1:3000/users` - you should see the users from The Office.

![Jimothy screenshot](https://github.com/mark-mcdermott/jimothy/blob/main/lib/jimothy/images/screenshot.jpg)

## Usage (Slow, Doing Everything By Hand)
- (If you don't have an app already) Run `rails new testapp`
- Add `gem "jimothy"` to your `Gemfile`
- Run `bundle install`
- You'll need a `User` model with `name`, `email` and `image` fields (all `string`s). Fastest way to do this is:
```
rails generate scaffold User name:string email:string image:string
rails db:migrate
```
- Add the following to your `db/seeds.rb` file:
```
require "jimothy"
Jimothy::seed_users
```
- Run `rails db:seed`
- In `app/views/users/_user.html.erb`, change `<%= user.image %>` to `<%= image_tag user.image %>`
- Run `rails server` and go to `http://127.0.0.1:3000/users` - you should see the users from The Office.

## Details
- Main methods (`seed_users`, etc) are in `lib/jimothy.rb`
- Initial user data is in a json file in `lib/jimothy/the-office-characters.json`
- Inital user images are in `lib/jimothy/images`
- I believe images in Rails engines are supposed to be directly available from the gem for use in a Rail app's asset pipeline, but I could not get this working and couldn't find sufficient documentation for this. So I just copy the images from the gem to the rails app (to `app/assets/images`) in the `import_images` method, which is called by the `seed_users` method.

