class DebtsController < ApplicationController
  before_action :set_debt, only: [:settle]

  def settle
    @debt.update(settled: true, amount: 0.0)
    redirect_back fallback_location: user_path(current_user), notice: 'Debt was successfully settled.'
  end

  private

  def set_debt
    @debt = Debt.find(params[:id])
  end
end
