class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # association
  belongs_to :ward
  belongs_to :station
  has_many   :wears

  # # avatar
  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>"}
  # validates_attachment_content_type :avatar, content_type: ["image/jpg","image/jpeg","image/png"]

  has_attached_file :image,
                    :styles => {
                        :xsmall => "50x50",
                        :thumb  => "100x100",
                        :medium => "300x300"
                    },
                    :storage => :s3,
                    :s3_permissions => :private,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => ":attachment/:id/:style.:extension"

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def authenticated_image_url(style)
    image.s3_object(style).url_for(:read, :secure => true)
  end
  def full_profile?
    family_name? && first_name? && station_id? && ward_id? && image?
  end

  def sum_price(c)
    sum = 0
      if c.wears.present?
        c.wears.each do |p|
          sum+=p.price
        end
      end

    return sum
  end
end
