# README

This is the backend API for the Expense Tracker application. It is built with Ruby on Rails and PostgreSQL and serves as the data layer for a separate Next.js frontend.

## Getting Started
1. **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/expense-tracker-api.git
    cd expense-tracker-api
    ```

2. **Install dependencies:**
    ```bash
    bundle install
    ```

3. **Set up the database:**
    ```bash
    rails db:create
    rails db:migrate
    ```

4. **Run the server:**

    The server will run on http://localhost:3000 by default.
      ```bash
      rails s
      ```

## API Endpoints

  | Method | Endpoint | Description |
  |:----- |:----- |:----- | 
  | GET | /api/expenses | Get a list of all expenses. |
  | POST | /api/expenses | Create a new expense. |


**Example `POST` Request:**

  To create a new expense, send a JSON object to the `api/expenses` endpoint.
  ```bash
  {
    "expense": 
    {
      "name": "Coffee",
      "amount": 100,
      "date": "08-11-2025"
    }
  }
  ```

**Testing**

  The project uses RSpec for testing. To run the tests and ensure the API is working as expected, use the following command:
  ```bash
  rspec
  ```