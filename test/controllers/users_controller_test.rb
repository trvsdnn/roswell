require "minitest_helper"

describe UsersController do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  it "refuses to edit not me" do
    get :edit, id: FactoryGirl.create(:user)
    assert_redirected_to login_path
  end

  it "accepts to edit me" do
    get :edit, id: user
    assert_response :success
  end

  it "refuses to update not me" do
    post :update, id: FactoryGirl.create(:user), user: valid_attributes
    assert_redirected_to login_path
  end

  it "updates me if attributes are valid" do
    post :update, id: user, user: valid_attributes
    user.reload
    assert_equal 'this_is_me', user.username
    assert_redirected_to user
  end

  it "re-renders the form if attributes are not valid" do
    post :update, id: user, user: invalid_attributes
    assert_response :success
  end


  def valid_attributes
    { username: 'this_is_me', password: 'secret_password', password_confirmation: 'secret_password' }
  end
  def invalid_attributes
    { username: 'this_is_me', password: 'secret_password', password_confirmation: 'oups...' }
  end
end