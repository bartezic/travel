def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install python-software-properties"
    run "#{sudo} apt-get -y install software-properties-common"
  end

  task :ruby_dep do
    # run "#{sudo} apt-get -y --no-install-recommends install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libgdbm-dev ncurses-dev automake libtool bison subversion pkg-config libffi-dev"
    run "#{sudo} apt-get -y --no-install-recommends install make libreadline6-dev libyaml-dev libsqlite3-dev sqlite3 libxslt1-dev autoconf libgdbm-dev libncurses5-dev automake bison libffi-dev"
  end
end
