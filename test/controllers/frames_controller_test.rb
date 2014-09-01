require 'test_helper'

class FramesControllerTest < ActionController::TestCase
  setup do
    @frame = frames(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:frames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create frame" do
    assert_difference('Frame.count') do
      post :create, frame: { is_active: @frame.is_active, roll1_pins: @frame.roll1_pins, roll2_pins: @frame.roll2_pins, roll3_pins: @frame.roll3_pins }
    end

    assert_redirected_to frame_path(assigns(:frame))
  end

  test "should show frame" do
    get :show, id: @frame
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @frame
    assert_response :success
  end

  test "should update frame" do
    patch :update, id: @frame, frame: { is_active: @frame.is_active, roll1_pins: @frame.roll1_pins, roll2_pins: @frame.roll2_pins, roll3_pins: @frame.roll3_pins }
    assert_redirected_to frame_path(assigns(:frame))
  end

  test "should destroy frame" do
    assert_difference('Frame.count', -1) do
      delete :destroy, id: @frame
    end

    assert_redirected_to frames_path
  end
end
