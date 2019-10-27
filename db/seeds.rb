# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
  {
    "id": 1,
    "name": 'Health & Fitness'
  },
  {
    "id": 2,
    "name": 'Business'
  },
  {
    "id": 3,
    "name": 'Music'
  }
].each { |v| Vertical.create!(v) }

[
  {
    "id": 1,
    "name": 'Booty & Abs',
    "vertical_id": 1,
    "state": 'active'
  },
  {
    "id": 2,
    "name": 'Full Body',
    "vertical_id": 1,
    "state": 'active'
  },
  {
    "id": 3,
    "name": 'Advertising',
    "vertical_id": 2,
    "state": 'active'
  },
  {
    "id": 4,
    "name": 'Writing',
    "vertical_id": 2,
    "state": 'active'
  },
  {
    "id": 5,
    "name": 'Singing',
    "vertical_id": 3,
    "state": 'active'
  },
  {
    "id": 6,
    "name": 'Music Fundamentals',
    "vertical_id": 3,
    "state": 'active'
  }
].each { |category| Category.create!(category) }

[
  {
    "id": 1,
    "name": 'Loose the Gutt, keep the Butt',
    "author": 'Anowa',
    "category_id": 1,
    "state": 'active'
  },
  {
    "id": 2,
    "name": 'BrittneBabe Fitness Transformation',
    "author": 'Brittnebabe',
    "category_id": 1,
    "state": 'active'
  },
  {
    "id": 3,
    "name": 'BTX: Body Transformation Extreme',
    "author": 'Barstarzz',
    "category_id": 2,
    "state": 'active'
  },
  {
    "id": 4,
    "name": 'Facebook Funnel Marketing',
    "author": 'Russell Brunson',
    "category_id": 2,
    "state": 'active'
  },
  {
    "id": 5,
    "name": 'Build a Wild Audience',
    "author": 'Tim Nilson',
    "category_id": 3,
    "state": 'active'
  },
  {
    "id": 6,
    "name": 'Editorial Writing Secrets',
    "author": 'J. K. Rowling',
    "category_id": 4,
    "state": 'active'
  },
  {
    "id": 7,
    "name": 'Scientific Writing',
    "author": 'Stephen Hawking',
    "category_id": 4,
    "state": 'active'
  },
  {
    "id": 8,
    "name": 'Vocal Training 101',
    "author": 'Linkin Park',
    "category_id": 5,
    "state": 'active'
  },
  {
    "id": 9,
    "name": 'Music Performance for Beginners',
    "author": 'Lady Gaga',
    "category_id": 5,
    "state": 'active'
  },
  {
    "id": 10,
    "name": 'Learn the Piano',
    "author": 'Lang Lang',
    "category_id": 6,
    "state": 'active'
  },
  {
    "id": 11,
    "name": 'Become a guitar hero',
    "author": 'Jimmy Page',
    "category_id": 6,
    "state": 'active'
  }
].each { |course| Course.create!(course) }
