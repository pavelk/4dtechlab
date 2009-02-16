require File.dirname(__FILE__) + '/../test_helper'
require 'libraries_controller'

# Re-raise errors caught by the controller.
class LibrariesController; def rescue_action(e) raise e end; end

class LibrariesControllerTest < Test::Unit::TestCase
  fixtures :libraries

  def setup
    @controller = LibrariesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:libraries)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_library
    old_count = Library.count
    post :create, :library => { }
    assert_equal old_count+1, Library.count
    
    assert_redirected_to library_path(assigns(:library))
  end

  def test_should_show_library
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_library
    put :update, :id => 1, :library => { }
    assert_redirected_to library_path(assigns(:library))
  end
  
  def test_should_destroy_library
    old_count = Library.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Library.count
    
    assert_redirected_to libraries_path
  end
end
