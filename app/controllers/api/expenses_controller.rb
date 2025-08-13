class Api::ExpensesController < ApplicationController
  def index
    expenses = filtered_expenses.order(date: :desc)
    total = expenses.sum(:amount)

    render json: { expenses: expenses, total: total }
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

  def filtered_expenses
    expenses = Expense.all
    month = params[:month]
    year = params[:year]

    if month.present? && year.present?
      if month == "all" && year == "all"
        # no filter
      elsif month == "all"
        expenses = expenses.where("EXTRACT(YEAR FROM date) = ?", year)
      elsif year == "all"
        expenses = expenses.where("EXTRACT(MONTH FROM date) = ?", month)
      else
        expenses = expenses.where("EXTRACT(MONTH FROM date) = ? AND EXTRACT(YEAR FROM date) = ?", month, year)
      end
    elsif month.present?
      expenses = expenses.where("EXTRACT(MONTH FROM date) = ?", month) unless month == "all"
    elsif year.present?
      expenses = expenses.where("EXTRACT(YEAR FROM date) = ?", year) unless year == "all"
    end

    expenses
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :date)
  end
end
