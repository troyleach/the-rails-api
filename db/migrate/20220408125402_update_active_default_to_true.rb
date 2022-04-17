class UpdateActiveDefaultToTrue < ActiveRecord::Migration[6.0]
  def change
    change_column_default :links, :active, from: nil, to: true
  end
end
