# README

# How to Run the Test Job
* Clone the repository to your local machine.

## Stack

- Ruby 2.7.0
- Sqlite3
- Rails 6.1.7

* Install Dependencies:
  - bundle install

* Database Setup:
  - Setup databsase.yml file if database requires password to access.
  - Create the database: bundle exec rails db:create
  - Migrate the database: bundle exec rails db:migrate
  - Seed the database: bundle exec rails db:seed

* Run the Application:
 - Start the server: rails server

* Run Tests:
 - Run the test suite with bundle exec rspec

* Postman Collection:
 - https://api.postman.com/collections/30457725-cd8d2ed8-1fba-4323-be12-8435108d5f89?access_key=PMAT-01HCHPDR6FX8Z1F2KYFA6K0X0Q
