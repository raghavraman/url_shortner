# URL Shortner
  An API app that creates shortern url and and redirects them to the orginal url using the shorterned key
### Technology and dependency
  * Ruby version - `Ruby 2.6.3`
  * Rails version - `Ruby 6.1.3`
  * System dependencies - `postgresql`
### Setting up the Application
  * Install gems - `bundle install`
  * Database creation - `rake db:create`
  * Database Migration - `rake db:migrate`
### Runnings tests
  * How to run the test suite - `bundle exec rspec`
### Starting the server
  * Starting the app - `bundle exec rails s`

### Assumptions
  - Currently the app does not support encoded url
  - App doesnt check for duplicate url in the system any time a user enter a url its creates a new key
  - Since we have 4 character keys we can support 64^4 = 16 Million keys

### Example with curl
- Add url to shortern
  `curl --location --request POST 'localhost:3000/shortern?redirect_url=https://google.com'`

- Redirection to orginal url
    `curl --location --request GET 'http://localhost:3000/Lvs='`