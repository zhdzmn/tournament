require 'test_helper'

class CompetentsControllerTest < ActionController::TestCase
  setup do
    @competent = competents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:competents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create competent" do
    assert_difference('Competent.count') do
      post :create, competent: { group: @competent.group, name: @competent.name }
    end

    assert_redirected_to competent_path(assigns(:competent))
  end

  test "should show competent" do
    get :show, id: @competent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @competent
    assert_response :success
  end

  test "should update competent" do
    put :update, id: @competent, competent: { group: @competent.group, name: @competent.name }
    assert_redirected_to competent_path(assigns(:competent))
  end

  test "should destroy competent" do
    assert_difference('Competent.count', -1) do
      delete :destroy, id: @competent
    end

    assert_redirected_to competents_path
  end
end
