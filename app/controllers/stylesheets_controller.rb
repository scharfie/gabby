class StylesheetsController < ApplicationController
  skip_before_filter :login_required
  
  before_filter :set_headers
  after_filter  { |c| c.cache_page }
  session :off
  layout nil

private
  def set_headers
    headers['Content-Type'] = 'text/css; charset=utf-8'
  end
end