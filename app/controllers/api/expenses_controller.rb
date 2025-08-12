class Api::ExpensesController < ApplicationController
  def index
    @expenses = Expense.all
    render json: @expenses
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      render json: @expense, status: :created
    else
      render json: @expense.errors, status: :unprocessable_content
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    render json: @expense
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, :date)
  end
end
