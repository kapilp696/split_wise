class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = current_user.groups
  end

  def show
    @debts = @group.calculate_debts
  end

  def new
    @group = current_user.groups.build
  end

  def create
    if current_user.groups.create(group_params)
      redirect_to groups_path, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
