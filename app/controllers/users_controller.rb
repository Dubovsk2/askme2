class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def show
    @question = Question.new(user_id: @user.id)
    @questions = @user.questions.order('created_at DESC')
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
end
