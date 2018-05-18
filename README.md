# carpoolic-api
----
  <_This api connects to the group project [carpoolic](https://github.com/BenCharbonneau/carpoolic). The project uses React and makes fetch HTTP requests to this api. Below is a list of success messages you should expect to receive when connecting to the api._>

## UserController

* ### URL:

  <_users/:id_>

* ### Method:
  
  <_`GET`_>

   ### Required:
 
   `id=[integer]`

* ### Success Response:
  
  <_What the status code should be on success. User data is returned._>

    #### Content:

    `{ 	success: true,
    	message: "Successfully got Mace.", 
    	user:  
    		email: "mace@test.com",
    		id: 11,
    		password_digest: "",
    		username: "Mace"
    }`

* ### URL:

  <_users/register_>

* ### Method:
  
  <_`POST`_>

* ### Success Response:
  
  <_What the status code should be on success. User's ride data is returned._>

    #### Content:

    `{ 	success: true,
    	message: "Successfully registered as Mace.", 
    	username: "Mace",
    	user_id: 12
    }`

* ### URL:

  <_users/:id/rides_>

* ### Method:
  
  <_`GET`_>
  
*  ### URL Params

   <_If URL params exist, specify them in accordance with name mentioned in URL section. Separate into optional and required. Document data constraints._> 

   ### Required:
 
   `id=[integer]`

* ### Success Response:
  
  <_What the status code should be on success. User's ride data is returned._>

    #### Content:

    `{ 	success: true,
    	message: "Successfully found rides for Mace.", 
    	rides:  
    		0: {id: 14, name: "test ride", pickup: "downtown", destination: "soldier field", pickup_date: "2018-05-18", pickup_time: "1:00"},
    		1: {id: 18, name: "test 2nd ride", pickup: "downtown", destination: "wrigley field", pickup_date: "2018-05-20", pickup_time: "12:00"},
    }`


* ### URL:

  <_users/login_>

* ### Method:
  
  <_`POST`_>

* ### Success Response:
  
  <_What the status code should be on success. User's ride data is returned._>

    #### Content:

    `{ 	success: true,
    	message: "Successfully logged in as Mace.", 
    	username: "Mace",
    	user_id: 12
    }`

* ### URL:

  <_users/:id_>

* ### Method:
  
  <_`PUT`_>

   ### Required:
 
   `id=[integer]`

* ###Success Response:
  
  <_What the status code should be on success. User's ride data is returned._>

    #### Content:

    `{ 	success: true,
    	message: "You updated user Mace's information.", 
    	updated_user: 
    		email: "mace@test.com",
    		id: 11,
    		password_digest: "",
    		username: "Mace"
    }`

* ### URL:

  <_users/:id_>

* ### Method:
  
  <_`DELETE`_>

   ### Required:
 
   `id=[integer]`

* ### Success Response:
  
  <_What the status code should be on success. User's ride data is returned._>

    ####Content:####

    `{ 	success: true,
    	message: "You destroyed the user Mace.", 
    }`

## RideController
* ### URL:

  <_rides/:id_>

* ### Method:
  
  <_`GET`_>

   ### Required:
 
   `id=[integer]`

* ### Success Response:
  
  <_What the status code should be on success. User data is returned._>

    #### Content:

    `{ 	success: true,
    	message: "Found ride id 4.", 
    	found_ride: {id: 14, name: "test ride", pickup: "downtown", destination: "soldier field", pickup_date: "2018-05-18", pickup_time: "1:00"} 
    	passenger_ids:
    }`

* ### URL:

  <_rides/_>

* ### Method:
  
  <_`POST`_>


* ### Success Response:
  
  <_What the status code should be on success. User data is returned._>

    #### Content:

    `{ 	success: true,
    	message: "You added ride 5.", 
    	added_ride: {id: 5, name: "test ride", pickup: "downtown", destination: "soldier field", pickup_date: "2018-05-18", pickup_time: "1:00"}
    }`

* ### URL:

  <_rides/:id/user_id_>

* ### Method:
  
  <_`PUT`_>

   ### Required:
 
   `id=[integer]`

   `user_id=[integer]`

* ### Success Response:
  
  <_What the status code should be on success. User data is returned._>

    #### Content:

    `{ 	success: true,
    	message: "You have claimed a slot in ride 5.", 
    	remaining_passenger_slots: 2, 
    	ride_details: {id: 5, name: "test ride", pickup: "downtown", destination: "soldier field", pickup_date: "2018-05-18", pickup_time: "1:00"}
    }`

* ### URL:

  <_rides/:id_>

* ### Method:
  
  <_`DELETE`_>

   ### Required:
 
   `id=[integer]`

* ### Success Response:
  
  <_What the status code should be on success. User data is returned._>

    #### Content:

    `{ 	success: true,
    	message: "You deleted ride id 5.", 
    	deleted_ride: {id: 5, name: "test ride", pickup: "downtown", destination: "soldier field", pickup_date: "2018-05-18", pickup_time: "1:00"}
    }`   

* ### URL:

  <_rides/:id/removeuser/:user_id_>

* ### Method:
  
  <_`DELETE`_>

   ### Required:
 
   `id=[integer]`

   `user_id=[integer]`

* ### Success Response:
  
  <_What the status code should be on success. User data is returned._>

    #### Content:

    `{ 	success: true,
    	message: "You deleted user Mace from ride id 5.",
    	current_ride: {id: 14, name: "test ride", pickup: "downtown", destination: "soldier field", pickup_date: "2018-05-18", pickup_time: "1:00"} 
    	deleted_user:  
    		{ 	
    			email: "mace@test.com",
    			id: 11,
    			password_digest: "",
    			username: "Mace"
    		},
    	remaining_passengers_in_ride: [{id: 10, username: "Alyssa", password_digest: "", email: "alyssa@test.com"}, {id: 4, username: "Ben", password_digest: "", email: "ben@test.com"}],  
    	remaining_passengers_slots: 2
    }`

* ### URL:

  <_rides/:id_>

* ### Method:
  
  <_`PUT`_>

   ### Required:
 
   `id=[integer]`

* ### Success Response:
  
  <_What the status code should be on success. User data is returned._>

    #### Content:

    `{ 	success: true,
    	message: "You updated ride id 5.", 
    	updated_ride: {id: 5, name: "test ride", pickup: "downtown", destination: "soldier field", pickup_date: "2018-05-18", pickup_time: "3:00"}
    }`


