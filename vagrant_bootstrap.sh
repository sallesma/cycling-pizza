#!/bin/sh

# enable console colors
sed -i '1iforce_color_prompt=yes' ~/.bashrc

# disable docs during gem install
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

# essentials
sudo apt-get -y update
sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev libcurl4-openssl-dev curl wget

# SQLite, Git and Node.js
sudo apt-get install -y libsqlite3-dev git nodejs

# Qt and xvfb-run for Capybara Webkit
sudo apt-get install -y libqtwebkit-dev xvfb

# PostgreSQL
sudo apt-get install -y libpq-dev postgresql

# setup rbenv and ruby-build
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# Install ruby 2.1.4 and bundler
export RBENV_ROOT="${HOME}/.rbenv"
export PATH="${RBENV_ROOT}/bin:${PATH}"
export PATH="${RBENV_ROOT}/shims:${PATH}"
rbenv install 2.3.1
rbenv global 2.3.1
gem install bundler
rbenv rehash

# Install Heroku
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh 

# cleanup
sudo apt-get clean