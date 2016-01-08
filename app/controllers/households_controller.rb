class HouseholdsController < ApplicationController

def index
  if current_user.household == nil
  	@households = Household.all
  else redirect_to household_path(current_user.household)
  end
end

def new
  @household = current_user.build_household
end

def create
  @household = current_user.create_household(household_params)
  @household.users << current_user
  if @household.save!
    redirect_to @household
  else
    render 'new'
  end
end

def show
  @household = Household.find(params[:id])
  @users = @household.users
end

def update
    @household = Household.find(params[:id])
    # @household.users << current_user unless @household.users.include? current_user
 end

def join
  @household = Household.find params[:id]
  current_user.update_attribute(:household_id, @household.id)
  redirect_to @household
end

def leave
  @household = Household.find params[:id]
  current_user.update_attribute(:household_id, nil)
  redirect_to @household
end

private
  def household_params
    params.require(:household).permit(:name, :members)
  end


end
