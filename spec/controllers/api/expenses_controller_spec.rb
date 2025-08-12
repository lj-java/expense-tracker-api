require 'rails_helper'

RSpec.describe Api::ExpensesController, type: :controller do
  describe "POST /api/expenses" do
    let(:valid_params) { { expense: attributes_for(:expense) } }

    it "creates a new expense with valid params" do
      post :create, params: valid_params
      expect(response).to have_http_status(:created)
    end

    it "returns error with invalid params" do
      post :create, params: { expense: { name: "Coffee", amount: -100, date: Date.today } }
      expect(response).to have_http_status(:unprocessable_content)
    end

    it "returns error with missing name" do
      post :create, params: { expense: { amount: 100, date: Date.today } }
      body = JSON.parse(response.body)
      expect(body["name"]).to include("can't be blank")
    end

    it "returns error with name more than 50 characters" do
      post :create, params: { expense: { name: "a" * 51, amount: 100, date: Date.today } }
      body = JSON.parse(response.body)
      expect(body["name"]).to include("maximum of 50 characters only")
    end

    it "returns error with missing amount" do
      post :create, params: { expense: { name: "Coffee", date: Date.today } }
      body = JSON.parse(response.body)
      expect(body["amount"]).to include("can't be blank")
    end

    it "returns error with amount less than or equal to 0" do
      post :create, params: { expense: { name: "Coffee", amount: 0, date: Date.today } }
      body = JSON.parse(response.body)
      expect(body["amount"]).to include("must be greater than 0")
    end

    it "returns error with invalid amount" do
      post :create, params: { expense: { name: "Coffee", amount: "invalid", date: Date.today } }
      body = JSON.parse(response.body)
      expect(body["amount"]).to include("must be greater than 0")
    end

    it "returns error with missing date" do
      post :create, params: { expense: { name: "Coffee", amount: 100 } }
      body = JSON.parse(response.body)
      expect(body["date"]).to include("can't be blank")
    end

    it "returns error with date in the future" do
      post :create, params: { expense: { name: "Coffee", amount: 100, date: Date.today + 2.days } }
      body = JSON.parse(response.body)
      expect(body["date"]).to include("can't be in the future")
    end

    it "returns error if not a valid date" do
      post :create, params: { expense: { name: "Coffee", amount: 100, date: "01/35/2025" } }
      body = JSON.parse(response.body)
      expect(body["date"]).to include("not a valid date")
    end
  end

  describe "DELETE /api/expenses/:id" do
    it "destroys the expense" do
      expense = create(:expense)
      delete :destroy, params: { id: expense.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
