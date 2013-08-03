class User < ActiveRecord::Base
  has_many :slides
  attr_accessible :login_id, :name, :password, :twitter_uid

  class << self

    def authenticate(login_id, password)
      user = find_by_login_id(login_id)

      if user.present? && user.password == password
        return user
      else
        return nil
      end
    end
  end
  
end
