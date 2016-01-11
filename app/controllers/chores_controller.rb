class ChoresController < ApplicationController

	before_action :authenticate_user!

	# Only retrieve chores for current user

	def index
	  @chores = current_user.chores
	end

	def new
	  @chore = current_user.chores.build
	  @household = current_user.household
	end

	# Use associations to assign all chores created by a user to that user
	# Automatically assign all new chores an incomplete status

	def create
	  @chore = current_user.chores.create(chore_params)
	  @chore.status = 'Incomplete'
	  if @chore.save!
	    redirect_to @chore
	  else
	    render 'new'
	  end
	end

	def show
	  @chore = Chore.find(params[:id])
	end

	def edit
	  @chore = Chore.find(params[:id])
	  @household = current_user.household
	end

	def update
	  @chore = Chore.find(params[:id])
	  if @chore.update(chore_params)
	      redirect_to @chore
	  else
	      render 'edit'
	  end
	end

	# Enable a chore to be marked complete by a link
	# Only used on household show page
	# Redirect keeps user on household page after updating in order to allow quick editing of multiple chores

	def complete
		@chore = Chore.find params[:id]
  		@chore.update_attribute(:status, 'Complete')
  		redirect_to households_path
	end

	# Enable a chore to be marked incomplete by a link
	# Only used on household show page
	# Redirect keeps user on household page after updating in order to allow quick editing of multiple chores

	def incomplete
		@chore = Chore.find params[:id]
  		@chore.update_attribute(:status, 'Incomplete')
  		redirect_to households_path
	end

	def destroy
    	@chore = Chore.find(params[:id])
    	@chore.destroy

    	if current_user.household_id != nil
    		redirect_to household_path(current_user.household)
    	else
    		redirect_to chores_path
		end
	end

	private
	def chore_params
	    params.require(:chore).permit(:name, :points, :status)
	end

end
