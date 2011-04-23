# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  before_filter :configure_charsets

  def check_administrator_role
     unless logged_in? && current_user.login == "admin"
       if logged_in?
         permission_denied
       else
         store_referer
         access_denied
       end
     end
  end
  
  protected

    def configure_charsets
      response.headers["Content-Type"] = "text/html; charset=utf-8"
      suppress(ActiveRecord::StatementInvalid) do
        ActiveRecord::Base.connection.execute 'SET NAMES UTF8'
      end
   end
end
