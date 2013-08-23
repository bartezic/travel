module ActiveAdmin::ViewHelpers
  def keywords(f)
    f.inputs "Keywords" do
      if f.object.tags && f.object.tags.any?
        f.input :tag_ids, as: :string, input_html: { 
          class: :tag2, 
          value: '', 
          data: { 
            tags: f.object.tags.map{ |tag| 
              { text: tag.title, id: tag.id } 
            }.to_json
          } 
        }
      else
        f.input :tag_ids, as: :string, input_html: { class: :tag2, value: '' }
      end
      f.has_many :tags do |k|
        k.translated_inputs switch_locale: true do |t|
          t.input :title
        end
      end
    end
  end

  def photo(f)
    if f.object.photo
      f.input :photo_id, as: :string, input_html: { 
        class: :photo2, 
        data: { 
          text: f.object.photo.title, 
          id: f.object.photo.id, 
          thumb: f.object.photo.asset(:thumb_150x) 
        }
      }
    else
      f.input :photo_id, as: :string, input_html: { class: :photo2 }
    end
  end

  def regions(f)
    if f.object.regions && f.object.regions.any?
      f.input :region_ids, as: :string, input_html: { 
        class: "region2 multy",
        value: '',
        data: {
          regions: f.object.regions.map{ |region|
            { text: "#{region.name}, #{region.country.name}", id: region.id }
          }
        }
      }
    else
      f.input :region_ids, as: :string, input_html: { class: "region2 multy", value: '' }
    end
  end

  def region(f)
    if f.object.region
      f.input :region_id, as: :string, input_html: { 
        class: :region2,
        value: '',
        data: {
          regions: { 
            text: "#{f.object.region.name}, #{f.object.region.country.name}", 
            id: f.object.region.id 
          }
        }
      }
    else
      f.input :region_id, as: :string, input_html: { class: :region2, value: '' }
    end
  end

  def geo_block(f)
    f.input :geo_input, input_html: { class: :geo_input2 }
    f.input :geo, input_html: { class: :geo2 }
  end

  def gallery(f)
    if f.object.gallery
      f.input :gallery_id, as: :string, input_html: { 
        class: :gallery2, 
        data: { 
          text: f.object.gallery.title, 
          id: f.object.gallery.id
        }
      }
    else
      f.input :gallery_id, as: :string, input_html: { class: :gallery2 }
    end
  end
end