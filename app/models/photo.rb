class Photo < ActiveRecord::Base
  default_scope :order => 'photos.id ASC'

  has_and_belongs_to_many :galleries, :join_table => :galleries_photos
  has_many :countries
  has_many :tours
  has_many :continents
  has_many :regions
  has_many :attractions
  has_many :hotels
  has_many :hot_tours

  attr_accessible :title, :asset, :gallery_ids, :asset_remote_url
  translates :title

  active_admin_translates :title do
    validates_presence_of :title
  end

  has_attached_file :asset,
    :styles => { 
      :thumb_130 => ['130x100#', :jpg],
      :thumb_370 => ['370x290#', :jpg],
      :thumb_770 => ['770x433#', :jpg],
      :thumb_150x => ['150x', :jpg], 
      :thumb_250x => ['250x', :jpg]
    },
    :convert_options => { 
      :medium => "-interlace Plane",
      :small => "-interlace Plane",
      :thumb => "-interlace Plane",
      :small_thumb => "-interlace Plane" 
    },
    :default_url => "/assets/ph/:attachment_:style.gif", 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  before_save :upload_asset_from_remote_url
  before_save :change_file_name

  scope :meta_galleries_eq, lambda { |ids| includes(:galleries).where("galleries.id IN (?)", ids) unless ids.blank? }
  scope :meta_countries_eq, lambda { |ids| includes(:countries).where("countries.id IN (?)", ids) unless ids.blank? }
  search_method :meta_galleries_eq, :type => :integer  
  search_method :meta_countries_eq, :type => :integer

  def upload_asset_from_remote_url
    self.asset = open(asset_remote_url) if asset_remote_url.present?
    # self.cover.clear if remove_cover == '1'
  rescue OpenURI::HTTPError
  end

  def change_file_name
    extension = File.extname(asset_remote_url.present? ? asset_remote_url : asset_file_name).gsub(/^\.+/, '')
    name = title.to_slug.normalize(transliterations: :ukrainian).to_s
    asset.instance_write(:file_name, "#{name}.#{extension}")
  end

end
