class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy
	#инструкции dependent: :destroy показывает,
	#что существование товарной позиции зависит от существования корзины.
	#Если мы уничтожим корзину, удалив ее из базы данных, нам нужно, 
	#чтобы Rails также уничтожила все товарные позиции, связанные с этой корзиной.

	def add_product(product_id)#метод проверачки на то что есть товар, да + нет =1
		current_item = line_items.find_by(product_id: product_id)
		#find_by() является модернизированной версией метода where(), 
		#который вместо возвращения массива результатов 
		#возвращает либо существующую товарную позицию LineItem, либо nil.#

		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(product_id: product_id)
		end
		current_item
	end

	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end
end
