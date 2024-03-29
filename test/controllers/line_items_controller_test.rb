require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:line_items)
  # end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do

    assert_difference('LineItem.count') do
       post :create, wine_id: wines(:two).id
    end
    item = LineItem.find_by_wine_id wines(:two).id
    assert_redirected_to item.basket
  end

  # test "should show line_item" do
  #   get :show, id: @line_item
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get :edit, id: @line_item
  #   assert_response :success
  # end
  #
  # test "should update line_item" do
  #   patch :update, id: @line_item, line_item: { basket_id: @line_item.basket_id, wine_id: @line_item.wine_id }
  #   assert_redirected_to line_item_path(assigns(:line_item))
  # end

  test "should destroy line_item" do
    #Keep a reference to the containing basket to test redirect
    basket = @line_item.basket
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: @line_item
    end

    assert_redirected_to basket
  end
end
