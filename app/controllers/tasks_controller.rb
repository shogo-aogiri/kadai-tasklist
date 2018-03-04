class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user_logged_in
  
  def index
    if logged_in?
      @user = current_user
      @tasks =current_user.tasks.order("created_at DESC").page(params[:page])
    end
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task =Task.new
  end

  def create
    @task =current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "タスクが正常に作成されました"
      redirect_to @task
    else
      @tasks =current_user.tasks.order("created_at DESC").page(params[:page])
      flash.now[:error] = "タスク追加に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
      if @task.update(task_params)
        flash[:success] = "タスクが正常に更新されました"
        redirect_to @task
      else
        flash.now[:error] = "タスク更新に失敗しました"
        render :edit
      end
  end

  def destroy
    @task.destroy
    
    flash[:success] = "タスクは削除されました"
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task =Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
