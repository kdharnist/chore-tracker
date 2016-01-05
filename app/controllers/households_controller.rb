class HouseholdsController < ApplicationController

def index
  @household = current_user.household
end

def new
  @household = Household.new
end

def create
  @household = current_user.households.new household_params

  if @household.save!
    redirect_to @household
  else
    render 'new'
  end
end

def show
  @story = Story.find(params[:id])
end


private
  def household_params
    params.require(:household).permit(:name, :members)
  end


end
