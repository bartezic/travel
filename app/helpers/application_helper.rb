module ApplicationHelper
  def full_year_callendar(b)
    p = "<table><thead><tr><th></th>"
    b.each { |k,v| p << "<th>#{k}</th>" }
    p << "<tr></thead><tbody>"
    arr = Array.new(b.size) { Array.new(12) }

    b.each_with_index { |(k,v),i|
      v.each { |key, val| 
        arr[i][key-1] = val.join(", ")
      }
    }
    arr.transpose.each_with_index{ |i,ind| 
      if i.compact.any?
        p << "<tr><th>#{t('date.month_names')[ind+1]}</th>"
        i.each{ |j| p << "<td><span class='badge badge-success'>#{j}</span></td>" }
        p << '</tr>'
      end
    }
    p << '</tbody></table>'  
  end
end
