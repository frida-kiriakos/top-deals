- I am a Ruby on Rails developer and I am mostly comfortable with programming in ruby specially for time-sensitive situations, that's why I have chosen to perform the task in Ruby

- I have chosen Sinatra framework to build my application since it is much lighter than Rails and it is appropriate for the task at hand. I wasn't very familiar with the framework, I have tried it out once in a simple application a while ago, It is a very simple framework and it was easy to pick up.

### Thought Process:
- Based on the task description, I have imagined a web application with a form that allows the user to specify certain parameters to look for hotel deals. So I have created a form that accepts those parameters, which are sent to the server. The server performs the API call based on the provided parameters and parses the results then displays them to the user.

- In my application, since I am displaying the top hotel deals, my thinking was to filter the results of the API call by displaying the deals with a particular offer based on the percentSavings parameter in the returned deals, which is why I rejected any deal with percentSavings equal to 0.

- I have also sorted the results based on the totalPriceValue attribute to display the cheaper deals, I could also make the sorting more dynamic by providing the user with the option to select which paramter to use to sort the results.

- I wanted to sort the results by relevance, however, I noticed that the relevance score is always 0 for all results.

- I also thought it would be nice to show the user the number of rooms left for a particular offer, but that value was always returned 0 even though the status was available.


### Assumptions and observations about the API:
- There are some required parameters for the API to work for example the user ID (uid), the API is accessible by guests, therefore, passing any dummy value would work.

- The API also accepts different types of products, so we can send `productType=Flight` or `productType=Package` to retrieve deals for those products.
