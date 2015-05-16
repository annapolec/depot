require 'test_helper'

class StoreControllerTest < ActionController::TestCase
 test "should get index" do
    get :index #testing index method
    assert_response :success
    assert_select '#columns #side a', minimum: 4 
   	assert_select '#main .entry', 2 #test if there are 2 elem with a class "entry" within id "main" 
	  assert_select 'h3', 'MyString' #testing if on page there is tag h3 with "MyString"
	  assert_select '.price', /\$[,\d]+\.\d\d/ #the price is formated correctly
  
  end

  # # calls to id 
  #. calls to classes
  #(no prefix) calls to an element

end
