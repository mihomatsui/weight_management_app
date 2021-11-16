class ApplicationController < ActionController::Base

  # 全ページをログイン必須とする
  before_action :authenticate_user!
end
