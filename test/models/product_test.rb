require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products
	#включение стенда модели
	#Инструкция fixtures() приводит к загрузке стендовых данных, соответствующих заданному имени модели
  # test "the truth" do
  #   assert true
  # end
  	test "product attributes must not be empty" do
		# свойства товара не должны оставаться пустыми
		product = Product.new
		assert product.invalid?#валидны ли данные?
		assert product.errors[:title].any?#какое из свойст пустое
		assert product.errors[:description].any?
		assert product.errors[:price].any?
		assert product.errors[:image_url].any?
	end

	test "product price must be positive" do
		# цена товара должна быть положительной
		product = Product.new(title: "My Book Title",
		description: "yyy",
		image_url: "zzz.jpg") # заполняем тестовыми данными поля=)
		product.price = -1 # назначаем первую цену
		assert product.invalid?

		assert_equal ["must be greater than or equal to 0.01"],
		product.errors[:price]
		# должна быть больше или равна 0.01
		product.price = 0# назначаем вторую цену
		assert product.invalid?

		assert_equal ["must be greater than or equal to 0.01"],
		product.errors[:price]
		product.price = 1# назначаем третью цену
		assert product.valid?
	end

	test "image url" do
		# url изображения
		ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif } # созжаем хэшики
		bad = %w{ fred.doc fred.gif/more fred.gif.more }

		ok.each do |name|
			assert new_product(name).valid?, "#{name} shouldn't be invalid "
			# не должно быть неприемлемым
		end

		bad.each do |name|
			assert new_product(name).invalid?, "#{name} shouldn't be valid "
			# не должно быть приемлемым
		end
	end

	test "product is not valid without a unique title" do
		# если у товара нет уникального названия, то он недопустим
		product = Product.new(title: products(:ruby).title,
		description: "yyy",
		price: 1,
		image_url: "fred.gif")
		assert product.invalid?
		assert_equal [I18n.translate('activerecord.errors.messages.taken')], product.errors[:title]
		# уже было использовано
	end
end