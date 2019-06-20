class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # SessionsHelperの中で定義されているメソッドを、自身のインスタンスメソッドとして取り込んでいる
  # これをMix-inという。
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
