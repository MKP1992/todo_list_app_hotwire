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
        format.turbo_stream { flash.now[:notice] = 'Task was successfully created.' }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('task_form', partial: 'tasks/form', locals: { task: @task }) }
      end
    end
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to tasks_path, notice: "Task was successfully updated" }
        format.turbo_stream { flash.now[:notice] = 'Task was successfully updated.' }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("task_#{@task.id}", partial: 'tasks/form', locals: { task: @task }) }
      end
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :archived)
  end
end
