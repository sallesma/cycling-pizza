source 'https://rubygems.org'
ruby '2.3.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0'
gem 'pg', '~> 0.19'
gem 'puma', '~> 3.0'

gem 'thor-rails'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem "twitter-bootstrap-rails"

gem 'jbuilder', '~> 2.5'

gem 'figaro'

source 'https://rails-assets.org' do
  gem 'rails-assets-datetimepicker'
  gem 'rails-assets-leaflet'
end

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 3.6'
  gem 'factory_girl_rails'
end

group :development do
  gem 'annotate'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.1.5'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
