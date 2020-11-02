class TodosController < ApplicationController
  def index
    todos = Todo.order("created_at DESC")
    render json: todos
  end

  def create
    todo = Todo.new(todo_param)
    if todo.save
      render json: todo, status: 201
    else
      message = {'message': 'somerhing went wrong'}
      render json: message, status: 400
    end
  end

  def update
    todo = Todo.find(params[:id])
    todo.update_attributes(todo_param)
    render json: todo
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy
    head :no_content, status: :ok
  end

  private

  def todo_param
    params.require(:todo).permit(:title, :completed)
  end
end
