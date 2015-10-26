class Ward < ActiveRecord::Base

  has_many  :stations
  has_many  :users
end
