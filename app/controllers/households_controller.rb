class HouseholdsController < ApplicationController

	before_action :authenticate_user!

	# Show all households for user without a household so they can choose one
	# Otherwise redirect straight to existing household 

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

	# If a user creates a household, automatically assign them as a member

	def create
	  @household = current_user.create_household(household_params)
	  @household.users << current_user
	  if @household.save!
	    redirect_to @household
	  else
	    render 'new'
	  end
	end

	# Household show view is the key view for the app.
	# More of the logic from the view seems like it could move here, maybe by storing calculations 
	# of complete and incomplete chores as attributes on the user model 

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

	# If a user deletes a household, set their foreign key to nil so they can see all households

  	def destroy
    	@household = Household.find(params[:id])
    	@household.destroy
    	current_user.update_attribute(:household_id, nil)

    	redirect_to households_path
	end

	# Enables link-based joining a household

	def join
	  @household = Household.find params[:id]
	  current_user.update_attribute(:household_id, @household.id)
	  redirect_to @household
	end

	# Enables link-based leaving a household

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
