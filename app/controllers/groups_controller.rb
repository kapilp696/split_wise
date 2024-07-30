class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = current_user.groups
  end

  def show
  end

  def new
    @group = current_user.groups.build
    @users = User.all
    (@users.count).times do
      @group.group_memberships.build
    end
  end

  def create
    @group=Group.new(group_params)
    if @group.save!
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def edit
    @users = User.where.not(id: @group.users.pluck(:id))
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to root_path, notice: 'Group was successfully destroyed.'
  end

  def remove_member
    membership = @group.group_memberships.find_by(user_id: params[:user_id])
    membership.destroy if membership
    redirect_to manage_members_group_path(@group), notice: 'Member was successfully removed.'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    # params.require(:group).permit(:name, :user_ids)
    params.require(:group).permit(:name, group_memberships_attributes: [:user_id, :_destroy])
  end
end
