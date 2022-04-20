class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :display_text
      t.text :url
      t.boolean :active

      t.timestamps
    end
  end
end
