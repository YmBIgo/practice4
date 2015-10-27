class Wear < ActiveRecord::Base
  # association
  belongs_to :user
  belongs_to :brand

  # # avatar
  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", xsmall: "50x50>"}
  # validates_attachment_content_type :avatar, content_type: ["image/jpg","image/jpeg","image/png"]

  has_attached_file :wimage,
                    :styles => {
                        :xsmall => "50x50",
                        :thumb  => "100x100",
                        :medium => "300x300"
                    },
                    :storage => :s3,
                    :s3_permissions => :private,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => ":attachment/:id/:style.:extension"

  validates_attachment_content_type :wimage, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  # validation
  validates_presence_of :price, :wimage, :brand_id, :user_id

  def authenticated_image_url(style)
    wimage.s3_object(style).url_for(:read, :secure => true)
  end
end
