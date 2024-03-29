require 'test_helper'

class WinesControllerTest < ActionController::TestCase
  setup do
    @wine = wines(:wine1)
  end

  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:wines)
  # end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end
  #
  # test "should create wine" do
  #   assert_difference('Wine.count') do
  #     post :create, wine: { country_of_origin: @wine.country_of_origin, description: @wine.description, grape_type: @wine.grape_type, name: @wine.name, pic_url: @wine.pic_url, price: @wine.price, short_description: @wine.short_description, supplier_id: suppliers(:supplier1), vegetarian: @wine.vegetarian }
  #   end
  #
  #   assert_redirected_to wine_path(assigns(:wine))
  # end

  test "should show wine" do
    get :show, id: @wine
    assert_response :success
  end

  # test "should get edit" do
  #   get :edit, id: @wine
  #   assert_response :success
  # end
  #
  # test "should update wine" do
  #   patch :update, id: @wine, wine: { country_of_origin: @wine.country_of_origin, description: @wine.description, grape_type: @wine.grape_type, name: @wine.name, pic_url: @wine.pic_url, price: @wine.price, short_description: @wine.short_description, supplier_id: suppliers(:supplier1), vegetarian: @wine.vegetarian }
  #   assert_redirected_to wine_path(assigns(:wine))
  # end
  #
  # test "should destroy wine" do
  #   assert_difference('Wine.count', -1) do
  #     delete :destroy, id: @wine
  #   end
  #
  #   assert_redirected_to wines_path
  # end
end
