#!/bin/bash -x
#Name: Khalid Alsuwaiyel 

# Fix sudoers to permit "vagrant rsync"
sudo sed -i.dist 's/Defaults\s*requiretty//' /etc/sudoers

# Install software packages
sudo yum update -y
sudo yum install -y git gcc gcc-c++ openssl-devel
sudo yum install -y sqlite-devel ruby-devel
sudo yum groupinstall -y 'Development Tools'

#install Mysql
sudo yum install -y mysql-server mysql mysql-devel
sudo service mysqld start

echo 'CREATE DATABASE crime_stoppers_dev;
GRANT ALL PRIVILEGES ON crime_stoppers_dev.* TO crime_stoppers@localhost IDENTIFIED BY
'"'"'vn8PaImYqeIivmzyspx93bfA4UTWCgD9P7Ar7p2S'"'"'; 
FLUSH PRIVILEGES;' > mysql_setup.sql

mysql -u root < mysql_setup.sql


# Change directory ownership so ec2-user can edit files
mkdir csc440
cd csc440
sudo chown -R ec2-user.ec2-user .


# Clone the repository
git clone https://github.com/alexkrebiehl/CSC440-Crime-Stoppers.git csc440

#
cd csc440
sudo gem install bundler
cd crime_stoppers
sudo /usr/local/bin/bundle update multi_json
sudo /usr/local/bin/bundle install
sudo touch /home/ec2-user/csc440/csc440/crime_stoppers/log/production.log

# Install Node.js
if [ ! -d /usr/bin/node-v0.10.33 ]; then
sudo wget -O /usr/local/src/node.tar.gz http://nodejs.org/dist/v0.10.33/node-v0.10.33.tar.gz
sudo tar zxf /usr/local/src/node.tar.gz -C /usr/bin
cd /usr/bin/node-v0.10.33
sudo ./configure
sudo make --silent 
sudo make --silent install
sudo ln -s /usr/local/bin/node /usr/bin/node
sudo ln -s /usr/local/lib/node /usr/lib/node
sudo ln -s /usr/local/bin/npm /usr/bin/npm
sudo ln -s /usr/local/bin/node-waf /usr/bin/node-waf
fi;

# Database migration and run the server with port 3000 
cd /home/ec2-user/csc440/csc440/crime_stoppers
sudo /usr/local/bin/rake db:migrate RAILS_ENV=production
sudo /usr/local/bin/rails s -d -e production
