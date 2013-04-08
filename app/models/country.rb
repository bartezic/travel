class Country < ActiveRecord::Base
  belongs_to :continent
  has_many :regions
  has_one :visa
  
  translates :name, :description, :seo_meta, :kitchen, :recomendation, :climate, :culture, :infrastructure
  attr_accessible :continent_id, :name, :description, :logo, :seo_meta, :kitchen, :recomendation, :climate, :culture, :infrastructure

  active_admin_translates :name, :description, :seo_meta, :kitchen, :recomendation, :climate, :culture, :infrastructure do
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
    if logo_file_name
      extension = File.extname(logo_file_name).gsub(/^\.+/, '')
      logo_name = name.to_slug.normalize(transliterations: :ukrainian).to_s
      logo.instance_write(:file_name, "#{logo_name}.#{extension}")
    end
  end
end
