class AddQuantityToLineItems < ActiveRecord::Migration
  def change
  	add_column :line_items, :quantity, :integer, default: 1#задаем начальное значение равное 1цы
    #add_column :line_items, :quantity, :integer
  end
end
