class Product < ActiveRecord::Base
	validates :title, :description, :image_url, presence: true #presence: true предписывает валидатору проверять наличие данных в каждом из указанных полей
	validates :title, uniqueness: true#проверка на уникальность поля
	validates :price, numericality: {greater_than_or_equal_to: 0.01}#проверить, что цена имеет допустимое, положительное числовое значение. numericality. Мы методу greater_than_or_equal_to (больше чем или равно) зн 0.01:
	#@lol = 'URL должен указывать на изображение формата GIF, JPG или PNG'
	validates :image_url, allow_blank: true, format: { #выбор  поля, и allow_blank: true -что бы не выпадали еще ощибки
		with: %r{\.(gif|jpg|png)\Z}i, #проверка на форматы
		message: 'must be a URL for GIF, JPG or PNG image.'
	}

	def self.latest#код, возвращающий товар, который подвергся изменениям последним.
		Product.order(:updated_at).last
	end
	#validates :title, {langth: Product.title >10}

	has_many :line_items#может принадлежать к множеству  таблиц корзины.....

	before_destroy :ensure_not_referenced_by_any_line_item# както странно аботает, типа если таваров ссылающихся на этот товар нет то очищаем что то
	
	private
	# убеждаемся в отсутствии товарных позиций, ссылающихся на данный товар
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'There are headings')
			#существуют товарные позиции
			return false
		end
	end
end


