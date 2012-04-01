class SuggestionMailer < ActionMailer::Base
  default from: "info@electricsafari.com"

  def suggestion_email(user)
    @user = user
    mail(
      :to => @user.childs_email,
      :subject => "Oh Noooooes! Your Animals are in Trouble on Electric Safari"
    )
  end

end

