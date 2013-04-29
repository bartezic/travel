SitemapGenerator::Sitemap.default_host = "http://mongrasse.com.ua"
SitemapGenerator::Sitemap.sitemaps_path = 'system/'
SitemapGenerator::Sitemap.create do
  [:uk, :ru].each do |locale|
    add url_for(:controller => 'static', :action => 'home', :host => '', :only_path => true, :locale => locale), :changefreq => 'daily'
    add url_for(:controller => 'static', :action => 'contacts', :host => '', :only_path => true, :locale => locale), :changefreq => 'daily'
    add url_for(:controller => 'static', :action => 'visas', :host => '', :only_path => true, :locale => locale), :changefreq => 'daily'
    
    ['tours', 'countries', 'continents', 'regions', 'attractions'].each do |classs|
      add url_for(:controller => classs, :action => 'index', :host => '', :only_path => true, :locale => locale), :changefreq => 'daily'
      classs.classify.constantize.find_each do |i|
        add url_for(:controller => classs, :action => 'show', :id => i, :host => '', :only_path => true, :locale => locale), :lastmod => i.updated_at
      end
    end
  end
end
