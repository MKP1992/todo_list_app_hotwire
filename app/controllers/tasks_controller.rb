# app/controllers/tasks_controller.rb

class TasksController < ApplicationController
  before_action :set_task, only: %i[update destroy]

  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      respond_to do |format|
        format.html { redirect_to tasks_path, notice: "Task was successfully created" }
        format.turbo_stream
      end
    else
      render :index
    end
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to tasks_path }
        format.turbo_stream
      end
    else
      render :index
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "Post was successfully deleted."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :archived)
  end
end
