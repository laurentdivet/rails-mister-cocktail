class AddToCocktails < ActiveRecord::Migration[5.0]
  def change
    create_table :cocktails do |t|
      t.string :picture

      t.timestamps
    end
  end
end
