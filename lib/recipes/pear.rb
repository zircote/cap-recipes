before "pear:install_packages", "pear:discover_channels", "pear:upgrade_pear"
set :pear_channels, ['pear.zfcampus.org','pear.phpunit.de','pear.symfony-project.com' ]
set :pear_packages, ['phpunit/PHPUnit', 'zfcampus/zf']
namespace :pear do
  desc <<-DESC
      Discover required pear channels.
  DESC
  task :discover_channels, :roles => :app do
    pear_channels.each do | channel |
      sudo "/usr/local/zend/bin/pear channel-discover #{channel}; true"
    end
  end
  desc <<-DESC
  Install required pear packages.
  DESC
  task :install_packages, :roles => :app do
    pear_packages.each do |package|
      sudo "/usr/local/zend/bin/pear  install #{package}; true"
    end
  end
  desc <<-DESC
      update pear packages
  DESC
  task :package_setup, :roles => :app do
    sudo "/usr/local/zend/bin/pear upgrade-all; true"
  end
  desc <<-DESC
      Upgrade pear..
  DESC
  task :upgrade_pear, :roles => :app do
    sudo "/usr/local/zend/bin/pear config-set auto_discover 1; true"
    sudo "/usr/local/zend/bin/pear upgrade pear; true"
  end
end