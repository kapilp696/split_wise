class GroupMembershipsController < ApplicationController
  before_action :set_group,only: :destroy
  def destroy
    membership = @group.group_memberships.find_by(user_id: params[:id])
    membership.destroy if membership
    redirect_to edit_group_path(@group), notice: 'Member was successfully removed.'
  end

  private
  def set_group
    @group=Group.find(params[:group_id])
  end
end
