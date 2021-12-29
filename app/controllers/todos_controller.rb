class TodosController < ApplicationController
  def index
    todos = Todo.order("created_at DESC")
    # FIXME: right now this returns all todos, most likely only want yesterdays and todays
      # actually maybe this is ok, maybe the FE should deal with the dates it wants. the api just returns shit.
    # FIXME: also it takes the time into account so there is a key for every todo created in a 24 hour span

    # list.group_by(&:group_by_assign_date).map {|k,v| [k, v.length]}.sort
    # list.group_by(&:group_by_assign_date).map {|k,v| [k, v.length]}.sort
    if params[:type]
      # I don't like that I am overwriting the variable
      fetch_type = params[:type].to_sym
      todos = todos.group_by(&fetch_type)
    end
    render json: todos
  end

  def create
    todo = Todo.new(todo_param)
    if todo.save
      render json: todo, status: 201
    else
      message = { 'message': "Something went wrong with creating this todo #{todo}" }
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
    params.require(:todo).permit(:title, :completed, :assign_date)
  end
end
