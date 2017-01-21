source 'https://rubygems.org'
ruby '2.3.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.19'
gem 'puma', '~> 3.0'

gem 'thor-rails'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'

gem 'jbuilder', '~> 2.5'

gem 'figaro'
gem 'annotate'

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.1.5'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
