class HouseholdsController < ApplicationController

	before_action :authenticate_user!

	def index
	  if current_user.household == nil
	  	@households = Household.all
	  else redirect_to household_path(current_user.household)
	  end
	end

	def new
	  @household = current_user.build_household
	end

	def edit
	  @household = Household.find(params[:id])
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

    if @household.update(household_params)
      redirect_to @household
    else
      render 'edit'
    end
  end

  	def destroy
    	@household = Household.find(params[:id])
    	@household.destroy
    	current_user.update_attribute(:household_id, nil)

    	redirect_to households_path
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
	    params.require(:household).permit(:name)
	end


end
