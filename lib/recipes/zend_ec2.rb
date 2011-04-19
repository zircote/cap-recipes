

after "zend_ec2:s3_config_load", "zend_ec2:restart:all"
  
namespace :zend_ec2 do
  desc <<-DESC
  Save Current Config On the machine to the S3 Storage
  DESC
  task :s3_config_save, :roles => :web do
      sudo "/usr/local/zend/bin/zend-server-s3-config-save  -b #{s3_bucket}  -p zend-server-config-#{stage}-#{Time.now.to_i}  -a #{aws_key}  -s #{aws_secret}"
  end
  desc <<-DESC
  Load the Zend Server Config from the S3 Entity.
  DESC
  task :s3_config_load, :roles => :web do
      sudo "/usr/local/zend/bin/zend-server-s3-config-load  -b #{s3_bucket}  -p #{current_zend_server_config_profile}  -a #{aws_key}  -s #{aws_secret}"
  end
  desc <<-DESC
  Install required pear packages.
  DESC
  namespace :restart do
    task :all, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  restart"
    end
    desc <<-DESC
    Stops the Monitor Service
    DESC
    task :monitor, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  restart-monitor"
    end
    desc <<-DESC
    Stops the Apache Service
    DESC
    task :apache, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  restart-apache"
    end
    desc <<-DESC
    Stops the Zend Server User Interface Service
    DESC
    task :lighttpd, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  restart-lighttpd"
    end
    desc <<-DESC
    Stops the Session Cluster Service
    DESC
    task :scd, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  restart-scd"
    end
    desc <<-DESC
    Stops the Job Queue Service
    DESC
    task :jobqueue, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  restart-jobqueue"
    end
  end
  namespace :stop do
    task :all, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  stop"
    end
    desc <<-DESC
    Stops the Monitor Service
    DESC
    task :monitor, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  stop-monitor"
    end
    desc <<-DESC
    Stops the Apache Service
    DESC
    task :apache, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  stop-apache"
    end
    desc <<-DESC
    Stops the Zend Server User Interface Service
    DESC
    task :lighttpd, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  stop-lighttpd"
    end
    desc <<-DESC
    Stops the Session Cluster Service
    DESC
    task :scd, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  stop-scd"
    end
    desc <<-DESC
    Stops the Job Queue Service
    DESC
    task :jobqueue, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  stop-jobqueue"
    end
  end
  namespace :start do
    task :all, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  start"
    end
    desc <<-DESC
    Starts the Monitor Service
    DESC
    task :monitor, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  start-monitor"
    end
    desc <<-DESC
    Starts the Apache Service
    DESC
    task :apache, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  start-apache"
    end
    desc <<-DESC
    Starts the Zend Server User Interface Service
    DESC
    task :lighttpd, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  start-lighttpd"
    end
    desc <<-DESC
    Starts the Session Cluster Service
    DESC
    task :scd, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  start-scd"
    end
    desc <<-DESC
    Starts the Job Queue Service
    DESC
    task :jobqueue, :roles => :web do
        sudo "/usr/local/zend/bin/zendctl.sh  start-jobqueue"
    end
  end
  desc <<-DESC
  Provides the current environment and PHP info for the Server(s)
  DESC
  task :extract_meta_data, :roles => :web do
    sudo '/usr/local/zend/bin/extract_meta_data.sh'
  end
  desc <<-DESC
  Provides the PHP Config parameters for the server.
  DESC
  task :php_config, :roles => :web do
    sudo '/usr/local/zend/bin/php-config'
  end
  desc <<-DESC
  Clears the shared memory semaphores
  DESC
  task :clean_semaphores, :roles => :web do
    sudo '/usr/local/zend/bin/clean_semaphores.sh'
  end
end