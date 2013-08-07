class HotTours < ActiveRecord::Base
  default_scope :order => 'hot_tours.id DESC'
  attr_accessible :cover, :description, :title, :active, :cover_remote_url

  translates  :title, :description
  active_admin_translates :title, :description do
    validates_presence_of :title, :description
  end

  has_attached_file :cover,
    :styles => { 
      :thumb => '370x290#'
    },
    :default_url => "/assets/ph/:attachment_:style.gif", 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  before_save :upload_cover_from_remote_url
  before_save :change_file_name

  def upload_cover_from_remote_url
    self.cover = open(cover_remote_url) if cover_remote_url.present?
    # self.cover.clear if remove_cover == '1'
  rescue OpenURI::HTTPError
  end

  def change_file_name
    extension = File.extname(cover_remote_url.present? ? cover_remote_url : cover_file_name).gsub(/^\.+/, '')
    name = title.to_slug.normalize(transliterations: :ukrainian).to_s
    cover.instance_write(:file_name, "#{name}.#{extension}")
  end
end
