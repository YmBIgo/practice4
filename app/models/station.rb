class Station < ActiveRecord::Base

# association
  belongs_to :ward
  has_many   :users

end
