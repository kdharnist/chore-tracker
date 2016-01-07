class HouseholdsController < ApplicationController

def index
  @households = Household.all
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
    @household.users << current_user unless @household.users.include? current_user
 end


private
  def household_params
    params.require(:household).permit(:name, :members)
  end


end
