require 'test_helper'

class RequestScoresControllerTest < ActionController::TestCase
  setup do
    @request_score = request_scores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:request_scores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create request_score" do
    assert_difference('RequestScore.count') do
      post :create, request_score: { ip: @request_score.ip, request_count: @request_score.request_count }
    end

    assert_redirected_to request_score_path(assigns(:request_score))
  end

  test "should show request_score" do
    get :show, id: @request_score
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @request_score
    assert_response :success
  end

  test "should update request_score" do
    patch :update, id: @request_score, request_score: { ip: @request_score.ip, request_count: @request_score.request_count }
    assert_redirected_to request_score_path(assigns(:request_score))
  end

  test "should destroy request_score" do
    assert_difference('RequestScore.count', -1) do
      delete :destroy, id: @request_score
    end

    assert_redirected_to request_scores_path
  end
end
