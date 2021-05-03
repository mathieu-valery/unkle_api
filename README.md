# Instructions

## Set up
Git Clone the project 

`bundle install.` 

`rails db:create.` 

`rails db:migrate.` 

`rails db:seed. `

## Run the app
`rails s. `

## Test the API
Please install Postman on your desktop and then:

### Sign In : ###

have a look at `app/db/seeds.rb` and pick up a user for logging in (you need email and password). 

request Postman: POST http://localhost:3000/api/v1/sign_in. 

body : `{"email": "*your email*", "password": "*your password*"}. `

please keep **"authentication_token"** in the response, it is **your token** for you to be authentificated and make requests to the API. 

### GET Contracts Endpoint : ###

request Postman: GET http://localhost:3000/api/v1/contracts. 

headers: `{"X-User-Token": "*your token*", "X-User-Email": "*your email*"}. `
if user is admin, the API responds with the list of all contracts, if he's not admin the API response is the list of contracts the current user has subscripted to.

### POST Contract Endpoint : ###

request Postman: POST http://localhost:3000/api/v1/contracts. 

headers: `{"Content-Type": "application/json", "X-User-Token": "*your token*", "X-User-Email": "*your email*"}. `

body:  

       `{"contract": {"number": "...", "date_start": "...", "date_end": "...", "status": "..."},  
       
       "clients": {"emails": [List of users emails]},  
       
       "options": {"names": [List of options]}}`

body example :  

       `{"contract": {"number": "000020", "date_start": "2022-01-01", "date_end": "2022-01-01", "status": "pending"},  
       
       "clients": {"emails": ["johndoe@gmail.com", "georgesabitbol@gmail.com]},  
       
       "options": {"names": ["fire", "housebreaking"]}}`

**Only admins can create a contract**
