class Photo < ActiveRecord::Base
  default_scope :order => 'id ASC'

  has_and_belongs_to_many :galleries, :join_table => :galleries_photos
  belongs_to :gallery
  has_many :countries
  has_many :tours

  attr_accessible :title, :asset, :gallery_ids, :asset_remote_url
  translates :title

  active_admin_translates :title do
    validates_presence_of :title
  end

  has_attached_file :asset,
    :styles => { 
      :thumb_150x => '150x', 
      :thumb_250x => '250x',
      :big_1170x => '1170x1000>' 
    },
    :default_url => "/images/ph/:attachment_:style.png", 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  before_save :upload_asset_from_remote_url
  before_save :change_file_name

  def upload_asset_from_remote_url
    self.asset = open(asset_remote_url) if asset_remote_url.present?
    # self.cover.clear if remove_cover == '1'
  rescue OpenURI::HTTPError
  end

  def change_file_name
    extension = File.extname(asset_file_name || asset_remote_url).gsub(/^\.+/, '')
    name = title.to_slug.normalize(transliterations: :ukrainian).to_s
    asset.instance_write(:file_name, "#{name}.#{extension}")
  end

end
