class ChangeCategroryFromCocktail < ActiveRecord::Migration[5.0]
  def change
    rename_column :cocktails, :categrory, :category
  end
end
