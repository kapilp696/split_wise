class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def show
    @total_borrowed = @user.total_borrowed
    @total_lent = @user.total_lent
    @debts = @user.debts
    @credits = @user.credits
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
