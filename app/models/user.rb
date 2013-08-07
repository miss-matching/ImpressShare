class User < ActiveRecord::Base
  has_many :slides
  attr_accessible :name, :twitter_uid

  class << self

  end
  
end
