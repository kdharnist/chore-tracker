class ChoresController < ApplicationController

	before_action :authenticate_user!

	def index
	  @chores = current_user.chores
	end

	def new
	  @chore = current_user.chores.build
	  @household = current_user.household
	end

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

	def complete
		@chore = Chore.find params[:id]
  		@chore.update_attribute(:status, 'Complete')
  		redirect_to households_path
	end

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
