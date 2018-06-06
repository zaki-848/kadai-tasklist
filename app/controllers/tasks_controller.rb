class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:update, :destroy]

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def show
  end
  def edit
  end

  def update

    if @task.update
      flash[:success] = 'Task は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render 'toppages/index'
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def task_params
    params.require(:task).permit(:content, :status)
  end
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  # before_action :set_task, only: [:show, :edit, :update, :destroy]
  # def index
  #   @tasks = Task.all
  # end

  # def show
  # end

  # def new
  #   @task = Task.new
  # end

  # def create
  #   @task = Task.new(task_params)

  #   if @task.save
  #     flash[:success] = 'Task が正常に投稿されました'
  #     redirect_to @task
  #   else
  #     flash.now[:danger] = 'Task が投稿されませんでした'
  #     render :new
  #   end
  # end

  # def edit
  # end

  # def update

  #   if @task.update(task_params)
  #     flash[:success] = 'Task は正常に更新されました'
  #     redirect_to @task
  #   else
  #     flash.now[:danger] = 'Task は更新されませんでした'
  #     render :edit
  #   end
  # end

  # def destroy
  #   @task.destroy

  #   flash[:success] = 'Task は正常に削除されました'
  #   redirect_to tasks_url
  # end

  # private
  # def set_task
  #   @task = Task.find(params[:id])
  # end
  # # Strong Parameter
  # def task_params
  #   params.require(:task).permit(:content, :status)
  # end
end
