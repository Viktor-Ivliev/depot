# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.delete_all
# . . .
Product.create!(title: 'Comanche Magnum M 17" зеленый-черный',
description:
	%{<p>
	велосипед для взрослых, горный, с амортизационной вилкой,
	 колеса: 26", тип тормозов: ободные, материал рамы: сталь,
	 количество скоростей: 18, размер рамы: L
	</p>},
image_url: '1.jpg',
price: 2310.00)
# . . .

