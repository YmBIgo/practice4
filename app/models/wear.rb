class Wear < ActiveRecord::Base
  # association
  belongs_to :user
  belongs_to :brand

  # avatar
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", xsmall: "50x50>"}
  validates_attachment_content_type :avatar, content_type: ["image/jpg","image/jpeg","image/png"]

  # validation
  validates_presence_of :price, :avatar, :brand_id, :user_id
end
