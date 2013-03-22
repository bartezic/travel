class Photo < ActiveRecord::Base
  belongs_to :galery
  attr_accessible :galery_id, :title, :asset
  translates :title

  active_admin_translates :title do
    validates_presence_of :title
  end

  has_attached_file :asset,
    :styles => { :thumb => 'x100', :croppable => '600x600>', :big => '1000x1000>' },
    :default_url => "/images/ph/:attachment_:style.png", 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  before_save :change_file_name

  def change_file_name
    extension = File.extname(asset_file_name).gsub(/^\.+/, '')
    name = title.to_slug.normalize(transliterations: :ukrainian).to_s
    asset.instance_write(:file_name, "#{name}.#{extension}")
  end

end
