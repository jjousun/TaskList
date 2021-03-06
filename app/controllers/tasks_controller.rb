class TasksController < ApplicationController
  def index
    # @tasks = [
    #   { task: "sleep", priority: "high" },
    #   { task: "code", priority: "high" },
    #   { task: "eat", priority: "medium" },
    #   { task: "buy groceries", priority: "medium" }
    # ]

    @tasks = Task.all
  end

  def show
    # tasks = [
    #   { id: 1, task: "sleep", priority: "high" },
    #   { id: 2, task: "code", priority: "high" },
    #   { id: 3, task: "eat", priority: "medium" },
    #   { id: 4, task: "buy groceries", priority: "medium" }
    # ]
    #
    # @result_task = nil
    # tasks.each do |task|
    #   if params[:id].to_i == task[:id]
    #     @result_task = task
    #   end
    # end

    @result_task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    # task = Task.new
    # task.title = params[:title]
    # task.priority = params[:priority]
    # task.completion = params[:completion]
    # task.description = params[:description]
    # if task.save
    #   redirect_to tasks_path
    # end

    task = Task.create task_params

    unless task.id == nil
      redirect_to tasks_path
    end

  end

  def update
    task = Task.find(params[:id])

    task.title = params[:task][:title]
    task.completion = params[:task][:completion]
    task.description = params[:task][:description]

    if task.save
      redirect_to task_path(task.id)
    end
  end

  def destroy
    Task.destroy(params[:id])

    redirect_to tasks_path
  end

  def completed
    task = Task.find(params[:id])

    task.completion = Time.now

    if task.save
      redirect_to task_path(task.id)
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :completion)
  end

end
