class HomeController < ApplicationController
  def index
    @expenses = current_user.expenses.all
    @groups = Group.all
  end
end
