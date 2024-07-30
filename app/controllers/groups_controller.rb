class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :manage_members, :add_members, :remove_member]

  def index
    @groups = current_user.groups
  end

  def show
  end

  def new
    @group = current_user.groups.build
    @group.group_memberships.build
    @users = User.all
  end

  def create
    if current_user.groups.create(group_params)
      redirect_to groups_path, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def edit
    # @group.group_memberships.build
    # @users = User.where.not(id: @group.users.pluck(:id))
    existing_user_ids = @group.users.pluck(:id)
    @available_users = User.where.not(id: existing_user_ids)
    @group.group_memberships.build
  end

  def update
    if @group.update(group_params)
      # user_ids = params[:user_ids] || []
      # user_ids.each do |user_id|
      # @group.group_memberships.create(user_id: user_id)
      # end
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  def manage_members
    @users = User.all
    @group
  end

  def add_members
    user_ids = params[:user_ids] || []
    user_ids.each do |user_id|
      @group.group_memberships.create(user_id: user_id)
    end
    redirect_to manage_members_group_path(@group), notice: 'Members were successfully added.'
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
    params.require(:group).permit(:name, group_memberships_attributes: [:id, :user_id, :_destroy])

  end
end
