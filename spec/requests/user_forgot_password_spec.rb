require 'spec_helper'

describe "User forget password" do

  before(:each) do
    @user = Factory(:user)
  end

  it "sends an email with instructions" do
    visit new_user_password_path
    fill_in "Email", :with => @user.email
    click_button "Reset password"
    current_path.should == new_user_session_path
    page.has_content? "You will receive an email with instructions"
  end

  it "enables changing password after following email link" do
    @user.send("generate_reset_password_token!")
    visit edit_user_password_path(@user, :reset_password_token => @user.reset_password_token)
    fill_in "New password", :with => "password"
    fill_in "Confirm your new password", :with => "password"
    click_button "Change my password"
    current_path.should == root_path
    page.has_content? "Your password was changed successfully. You are now signed in."
  end

end
