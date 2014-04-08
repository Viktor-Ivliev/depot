require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success

    #Первый тест с селектором ищет элемент по имени a, 
    #который содержится в элементе с атрибутом id, имеющим значение side,
    #который, в свою очередь, содержится внутри элемента с атрибутом id, 
    #имеющим значение columns. 
    #Этот тест проверяет, что у нас имеется минимум четыре таких элемента.
    assert_select '#columns #side a', minimum: 4

    #проверяется наличие трех элементов,
    #у которых есть атрибут class по имени entry в той части страницы, 
    #которая имеет атрибут id со значением main.
	assert_select '#main .entry', 3

	
	assert_select 'h3', 'Programming Ruby 1.9'
	assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
 