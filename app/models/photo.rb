class Photo < ActiveRecord::Base
  has_attached_file :photo, styles: { medium: "100x100>", thumb: "20x20>" },
                    :storage => :dropbox
                    # :dropbox_credentials => Rails.root.join("config/dropbox.yml")
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  acts_as_mappable :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  def as_json(options)
    super((options || {}).merge({:methods => [:photo_url, :medium_photo_url, :thumb_photo_url]}))
  end

  def photo_url
    self.photo.url
  end

  def medium_photo_url
    self.photo.url(:medium)
  end

  def thumb_photo_url
    self.photo.url(:thumb)
  end
end
