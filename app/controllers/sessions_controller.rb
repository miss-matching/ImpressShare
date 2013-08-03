#coding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
    session.delete(:user_id)

    user = User.authenticate(params[:login_id],params[:password])

    if user
      session[:user_id] = user.id
      redirect_to params[:from] || :root
    else
      flash[:alert] = 'ユーザID、パスワードの組み合わせが不正です。'
      render :new     
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root
  end

end
