class QuestionsController < ApplicationController
  before_action :set_question, only: %i[destroy edit update hidden]
  before_action :authenticate_user!, only: %i[edit update destroy hidden]

  def create
    @user = User.find(params[:question][:user_id])
    @question = @user.questions.build(params.require(:question).permit(:body, :user_id))
    @question.author = current_user if current_user.present?
    if @question.save 
      flash[:notice] = 'Created'
      redirect_to @question
    else
      flash[:alert] = "Something went wrong"
      render @new
    end
  end

  def new
    @user = User.find(params[:user_id])
    @question = @user.questions.build
  end

  def edit
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.all
  end
  
  def update
    update_params = params.require(:question).permit(:body, :answer)
      if @question.update(update_params)
        flash[:notice] = "Object was successfully updated"
        redirect_to @question
      else
        flash[:alert] = "Something went wrong"
        render 'edit'
      end
  end

  def hidden
    @question.toggle(:hidden).save
    redirect_to @question.user
  end
  
  def destroy
    user = @question.user
    if @question.destroy
      flash[:success] = 'Object was successfully deleted.'
      redirect_to root_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to user
    end
  end

  private

  def set_question
    @question = current_user.questions.find(params[:id])
  end
end
