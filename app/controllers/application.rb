# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '12d2e0a7215f0f256b4655c623494982'
end


class Hash
  def method_missing(m, *args)
    self[m] if has_key?(m)
  end
end