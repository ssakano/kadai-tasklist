class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    # @tasks = Task.all.page(params[:page]).per(5)
    @tasks = current_user.tasks.page(params[:page]).per(5)
    # app/views/tasks/index.html.erb
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    # @task = current_user.tasks.build(task_params)
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    # @task.user = current_user
    # tasksテーブルにはuser_idというカラムがある
    if @task.save
      flash[:success] = 'Task が正常に作成されました'
      redirect_to tasks_url
    else
      flash.now[:danger] = 'Taskが作成されませんでした'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    if @task.update(task_params)
        flash[:success] = 'Task は正常に更新されました'
        redirect_to @task
    else
        flash.now[:danger] = 'Task は更新されませんでした'
        render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end

  private
  
  def set_task
    @task = Task.find(params[:id])
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
