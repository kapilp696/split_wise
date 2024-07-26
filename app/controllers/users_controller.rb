class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def show
    @total_borrowed = @user.total_borrowed
    @total_lent = @user.total_lent
    @debts = @user.debts
    @credits = @user.credits
  end

  def send_invite
    recipient_email = params[:email]
    InviteNotificationMailer.invite_email(recipient_email, current_user).deliver_now
    redirect_to root_path, notice: 'Invitation to join splitwise sent successfully'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
