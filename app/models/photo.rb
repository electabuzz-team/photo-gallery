class Photo < ActiveRecord::Base
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" },
                    :storage => :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml")
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  acts_as_mappable :lat_column_name => :latitude,
                   :lng_column_name => :longitude
end
