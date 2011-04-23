class Department < ActiveRecord::Base
  has_many :users
end
