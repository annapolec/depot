require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    @update = {
      title: 'Lorem Ipsum',
      description: 'Wibbles are fun!',
      image_url: 'cs.png',
      price: 19.95
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products) #assigns a valid articles instance variable (in controller action #index)
    assert_select 'table tr td', minimum: 5 #test if there are at least 5 cells (with 3 products, there are 6)
    assert_select 'img', minimum: 2 #test if there are at least 2 images (in html file, we used image_tag helper)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select 'h1', 'New product'
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @update
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
    assert_select 'a', minimum: 2 #test if there areath least 2 links (in html file, we used link_to helper)
  end

  test "should update product" do
    patch :update, id: @product, product: @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
