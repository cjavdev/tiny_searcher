source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "4.0.9"

gem "rails", "~> 8.1.0"
gem 'sprockets-rails'
gem 'pg'
gem 'puma', '>= 6.0'
gem 'dartsass-sprockets'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :windows]
  gem 'factory_bot_rails'
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen'
  gem 'pry-rails'
  gem 'annotaterb'
  gem 'byebug'
  gem 'rubocop', require: false
end

gem 'tzinfo-data', platforms: [:windows, :jruby]

gem "csv"
