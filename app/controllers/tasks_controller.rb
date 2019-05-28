class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:show, :edit, :update, :destroy]
  
  def index
    # @tasks = Task.where(user_id: current_user.id)
    @tasks = Task.where(user: current_user)
    # @tasks = current_user.tasks
  end

  def show
    # set_task
    # @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @task.user_id = current_user.id
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    # @task.user = current_user

    # @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit
#    set_task
#    @task = Task.find(params[:id])
  end

  def update
#    set_task
#    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
#    set_task
#    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find_by(id: params[:id])
    redirect_to root_url unless @task
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def check_user
    # カリキュラムだと同じような実装がcorrect_userというメソッドでされている
    if @task.user != current_user
      redirect_to root_url
    end
  end
end
