require 'elasticsearch/model'

class Wear < ActiveRecord::Base
  # association
  belongs_to :user
  belongs_to :brand

  # # avatar
  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", xsmall: "50x50>"}
  # validates_attachment_content_type :avatar, content_type: ["image/jpg","image/jpeg","image/png"]

  # Elasticserach
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name "wear_#{Rails.env}" # インデックス名を指定(RDBでいうデータベース)

  settings do
    mappings dynamic: 'false' do
      indexes :id, type: 'integer'
      indexes :price, type: 'integer'
      indexes :month_price, type: 'integer'

      indexes :rent_or_not, type: 'boolean'

      indexes :created_at, type: 'date', format: 'date_time'
      indexes :updated_at, type: 'date', format: 'date_time'

      indexes :brand do
        indexes :name, analyzer: 'keyword', index: 'not_analyzed'
      end

      indexes :user do

        indexes :id, type: 'integer'
        indexes :created_at, type: 'date', format: 'date_time'
        indexes :updated_at, type: 'date', format: 'date_time'

        indexes :station do
          indexes :id, type: 'integer'
          indexes :name, analyzer: 'keyword', index: 'not_analyzed'
        end

        indexes :ward do
          indexes :id, type: 'integer'
          indexes :name, analyzer: 'keyword', index: 'not_analyzed'
        end
      end
    end
  end

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
  validates_presence_of :price, :month_price, :wimage, :brand_id, :user_id

  # s3 authentificated_image_url
  def authenticated_image_url(style)
    wimage.s3_object(style).url_for(:read, :secure => true)
  end

  # マッピングのデータを返す
  def as_indexed_json(options = {})
    attributes
      .symbolize_keys
      .slice(:month_price, :price, :rent_or_not, :created_at, :updated_at)
      .merge( brand: { name: brand.name })
      .merge( user: { id: user.id , station: { name: user.station.name }, ward: { name: user.ward.name } })
  end

  def self.search(params = {})
    keyword = params[:q]
    rent_or_not = params[:rent_or_not].present?
    search_definition = Elasticsearch::DSL::Search.search {
      query {
        filtered {
          query {
            if keyword.present?
              multi_match {
                query keyword
                fields %w{ brand.name user.station.name user.ward.name }
              }
            else
              match_all
            end
          }
          filter {
            term rent_or_not: 'false'
          } unless rent_or_not
        }
      }
    }

    __elasticsearch__.search(search_definition)
  end
end
Wear.import