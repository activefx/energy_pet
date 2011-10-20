# Put all your default configatron settings here.
require 'openid/store/filesystem'

# Example:
#   configatron.emails.welcome.subject = 'Welcome!'
#   configatron.emails.sales_reciept.subject = 'Thanks for your order'
#
#   configatron.file.storage = :s3
  # OpenID config
  configatron.openid.storage_location = '/tmp'
  configatron.openid.storage_handler = OpenID::Store::Filesystem.new(configatron.openid.storage_location),
  # Github omniauth config
  configatron.github.app_id = nil
  configatron.github.app_key = nil
  configatron.github.app_scope = 'user,public_repo'
  # LinkedIn omniauth config
  configatron.linked_in.app_id = nil
  configatron.linked_in.app_secret = nil
  # Facebook omniauth config
  configatron.facebook.app_id = nil
  configatron.facebook.app_key = nil
  configatron.facebook.app_scope = 'email,user_about_me,offline_access'
  # Twitter omniauth config
  configatron.twitter.app_id = nil
  configatron.twitter.app_secret = nil
  # Google omniauth / openid config
  configatron.google.open_id.enabled = false
  configatron.google.open_id.name = 'google'
  configatron.google.open_id.identifier = 'https://www.google.com/accounts/o8/id'
  # Yahoo omniauth / openid config
  configatron.yahoo.open_id.enabled = false
  configatron.yahoo.open_id.name = 'yahoo'
  configatron.yahoo.open_id.identifier = 'yahoo.com'

