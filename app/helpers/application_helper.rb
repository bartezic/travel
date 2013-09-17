module ApplicationHelper
  def full_year_callendar(days)
    p = "<table class='table table-striped table-bordered table-condensed'><thead><tr><th>#{t 'callendar.month_year'}</th>"
    days.each { |k,v| p << "<th>#{k}</th>" }
    p << "<tr></thead><tbody>"
    arr = Array.new(12) { Array.new(days.size) }

    days.each_with_index do |(k,v),i|
      v.each { |key, val| 
        arr[key-1][i] = (val.size > 4) && (val.last - val.first == val.size-1) ? "#{val.first} - #{val.last}" : val.join(',')
      }
    end
    arr.each_with_index do |i,ind| 
      if i.compact.any?
        p << "<tr><th>#{t('date.month_names')[ind+1]}</th>"
        i.each{ |j| p << (j ? "<td><span class='label label-warning'>#{j}</span></td>" : '<td>-</td>') }
        p << '</tr>'
      end
    end
    p << '</tbody></table>'  
  end

  def tour_program(programs)
    if programs.any? && programs.size > 1
      p = "<table class='tour_program table table-striped table-bordered table-condensed'>
            <thead>
              <tr>
                <th><p class=text-center>#{t 'tours.day'}</p></th>
                <th><p class=text-center>#{t 'tours.tour_program'}</p></th>
              </tr>
            </thead>
          <tbody>"
      programs.each { |program|
        regions = program.regions.map {|region|
          "#{link_to region.name, region} <small><em>(#{link_to region.country.name, region.country})</em></small>"
        }

        p << "<tr>
                <td rowspan=2>
                  <p class=text-center><b>#{program.day_number}</b></p>
                </td>
                <td>
                  <p class='pull-right regions-links'>#{regions.join(', ')}</p>
                </td>
              </tr>
              <tr>
                <td>#{program.description}</td>
              </tr>"
      }
      p << '</tbody></table>'
    end
  end

  def marshrut(programs)
    regions = programs.map(&:regions).flatten.uniq
    countries = regions.map(&:country).uniq 
    if regions.size > 1 
      if countries.size > 1
        regions.map{ |region|
          "#{link_to region.name, region} <small><em>(#{link_to region.country.name, region.country})</em></small>"
        }.join(' - ')
      else
        regions.map{ |region| link_to(region.name, region) }.join(' - ') << " <small><em>(#{link_to countries.first.name, countries.first})</em></small>"
      end
    end
  end

  def tour_subtitle(programs, marshrut = false, seo = false)
    if programs.any?
      regions = programs.map(&:regions).flatten.uniq
      if regions.size == 1
        region = regions.first
        res = if seo 
          "#{region.name} (#{region.country.name})"
        else
          "<small>#{link_to region.name, region}
            <small>
              <em>(#{link_to region.country.name, region.country})</em>
            </small>
          </small>"
        end
      elsif marshrut
        countries = regions.map(&:country).uniq
        res = if countries.size == 1
          regions.map(&:name).join(' - ') << " (#{countries.first.name})"
        else
          regions.map{ |region| "#{region.name} (#{region.country.name})" }.join(' - ')
        end
        
        res = "<span class='label label-warning' data-toggle='tooltip' title='#{res}'>#{t 'tours.marshrut'}</span>" unless seo
      end
    end
    res 
  end
end
