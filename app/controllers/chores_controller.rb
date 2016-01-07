class ChoresController < ApplicationController

def index
  @chores = current_user.chores
end

def new
  @chore = current_user.chores.build
end

def create
  @chore = current_user.chores.create(chore_params)
  if @chore.save!
    redirect_to @chore
  else
    render 'new'
  end
end

def show
  @chore = Chore.find(params[:id])
end


private
  def chore_params
    params.require(:chore).permit(:name, :points, :status)
  end

end
