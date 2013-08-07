#coding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
    session.delete(:user_id)

    auth = request.env["omniauth.auth"]
    
    user = User.find_by_twitter_uid( auth[:uid]) || User.new
    user.twitter_uid = auth[:uid]
    user.name = auth[:info][:nickname]
    user.image_url = auth[:info][:image]
    user.save

    session[:user_id] = user.id

    redirect_to :root

    # todo: エラー処理
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root
  end

end
