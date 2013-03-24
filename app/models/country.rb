class Country < ActiveRecord::Base
  belongs_to :continent
  has_many :regions
  
  translates :name, :visa, :description, :meta_description, :kitchen, :recomendation
  attr_accessible :continent_id, :name, :visa, :description, :meta_description, :kitchen, :recomendation

  active_admin_translates :name, :visa, :description, :meta_description, :kitchen, :recomendation do
    validates_presence_of :name
  end

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :logo,
    :styles => { :thumb => 'x100', :croppable => '600x600>', :big => '1000x1000>' },
    :default_url => "/images/ph/:attachment_:style.png", 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  before_save :change_file_name

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end

  def change_file_name
    extension = File.extname(asset_file_name).gsub(/^\.+/, '')
    name = title.to_slug.normalize(transliterations: :ukrainian).to_s
    asset.instance_write(:file_name, "#{name}.#{extension}")
  end
end
