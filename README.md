# Ecommerce-API
This is an API backend of an e-commerce system which allows users to search, add items to their shopping cart, create orders, and checkout successfully.

# Technologies
- `Rails`: Rails is a web-application framework that includes everything needed to create database-backed web applications according to the Model-View-Controller (MVC) pattern.
- `JBuilder`: JBuilder is a template engine for rendering a JSON response.

# External Dependencies
This web application is written with Ruby using the Ruby on Rails framework and a PostgreSQL database. You need Ruby version 2.4.1 for the application to work
- To install rvm , visit [RVM](https://rvm.io/rvm/install)
- To install this ruby version, you can run the command below but you can use other channels to install it as well e.g. rvm install "ruby version". 
- To install MySQL, run 
```bash
brew install mysql
```

# Project Architecture
- This project was built using the Rails MVC architecture
* `Model`: Maintains the relationship between Object and Database and handles validation, association, transactions
* `View`: Maintains the relationship between Object and Database and handles validation, association, transactions
* `Controller`: The facility within the application that directs traffic, on the one hand querying the models for specific data, and on the other hand organizing that data (searching, sorting) into a form that fits the needs of a given view.

# Applicaton Features
* Users can view all items when entering the website.
* Items are displayed properly based on the selected department and category.
* Users can search items through search box.
* Support paging if we have too many items.
* Users can see item details by selecting a specific item.
* Users can add items to their shopping carts.
* Users can register/login using website custom forms
* Users can update personal profiles with shipping addresses and other info.
* Users can checkout with Stripe.
* Users will get confirmations over emails about their orders.
* Clear unused shopping cart frequently.

- Click [here](https://t-ecommerce.herokuapp.com/) to access the hosted application or follow the `instruction below` to run the application locally 

# Installation
Please make sure you have **Ruby(v 2.5.3) and MySQL** installed. Take the following steps to setup the application on your local machine:

* Run `git clone https://github.com/chibuezeayogu/Ecommerce-API.git` to clone this repository
* Run the command `cd Ecommerce-API` to checkout into `Ecommerce-API`.
* Run `bundle install` to install all required gems
* create a file `master.key` inside `config` folder and past your secret key
* create a .env file in the root directory and add your `STRIPE_API_KEY` as shown in `.env.sample`

# Configuring the database
* To create application database, run:
    ```bash
    rails db:create
    ```
* Next run the code below to migrate database schemas

    ```bash
    rails db:schema:load
    ```

# Tests
* Run test with `rspec`

# Limitations
* File-Transfer-App is still in development.
