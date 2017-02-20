class AddColumnToCocktail < ActiveRecord::Migration[5.0]
  def change
    add_column :cocktails, :categrory, :string
    add_column :cocktails, :image_url, :string
    add_column :cocktails, :alcoholic, :boolean
    add_column :cocktails, :glass_type, :string
    add_column :cocktails, :instructions, :text
  end
end
