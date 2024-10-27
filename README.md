# Cash Register App (Backend)
This project is the backend for the Cash Register App, a shopping cart application that allows users to add products, calculate prices, and apply flexible discount rules.

## Description
The backend is built with Ruby on Rails and uses SQLite for the database. It includes features for managing cart items, calculating total prices, and applying specific discount rules. The session is stored in a cookie, allowing the cart to persist between browser sessions without requiring user authentication.

## Installation

1. Clone the repository to your local machine

   ```
    git clone https://github.com/ClaudiaAmprimo/cash_register_backend.git
    cd cash_register_backend
   ```

2. Check that Ruby and Rails are installed:

   ```
    ruby -v
    rails -v
   ```

  If Ruby or Rails are not installed, follow these instructions:

  Install Ruby: Visit Ruby's installation guide: https://www.ruby-lang.org/en/documentation/installation/ and choose the method for your operating system.

  Install Rails: Once Ruby is installed, install Rails with:

   ```
   gem install rails
   ```


3. Verify Node.js and npm:

   ```
   node -v
   npm -v
   ```

   If Node.js or npm are not installed, you can install them from the official website:
   https://nodejs.org/en

4. Install dependencies:

   ```
   bundle install
   ```

5. Set up the database using SQLite. The database configuration is in config/database.yml:

   ```
   rails db:create
   rails db:migrate
   rails db:seed
   ```

## Usage
To start the backend server:

  ```
  rails server
  ```
The server will run on http://localhost:3000.

## Testing
Run all tests with:

  ```
  rails test
  ```

## API Endpoints

GET /products: Retrieves a list of available products.

GET /carts: Shows the current cart and the total price with applied discounts.

POST /carts/add_product: Adds a product to the cart by product code.

DELETE /carts/remove_product: Removes a specific product from the cart.

## Important Notes

Discount Rules: The following special conditions are applied during checkout:

Green Tea (GR1): "Buy one, get one free."

Strawberries (SR1): Bulk discount to 4.50€ when buying 3 or more.

Coffee (CF1): Price reduced to 2/3 of the original when buying 3 or more.

Session Management: The cart is stored in a cookie, allowing it to persist even if the browser tab is closed and reopened.
