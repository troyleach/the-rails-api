class AddAssignDateToTodo < ActiveRecord::Migration[6.0]
  def up
    add_column :todos, :assign_date, :datetime
  end

  def down
    remove_column :todos, :assign_date
  end
end
