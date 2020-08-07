source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby                              '2.6.3'

gem 'rails',                      '~> 6.0.3', '>= 6.0.3.2'
gem 'pg',                         '>= 0.18', '< 2.0'
gem 'puma',                       '~> 4.1'
gem 'sass-rails',                 '>= 6'
gem 'bootstrap-sass',             '~> 3.4'
gem 'mini_magick',                '~> 4.9'
gem 'image_processing',           '~> 1.9'
gem 'active_storage_validations', '~> 0.8'
gem 'webpacker',                  '~> 4.0'
gem 'turbolinks',                 '~> 5'
gem 'jbuilder',                   '~> 2.7'
gem 'devise',                     '~> 4.7', '>= 4.7.2'
gem 'faker',                      '~> 2.12.0'
gem 'bootsnap',                   '>= 1.4.2', require: false
gem 'omniauth-facebook'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'letter_opener'
end

group :development do
  gem 'web-console',              '>= 3.3.0'
  gem 'listen',                   '~> 3.2'
  gem 'spring'                  
  gem 'spring-watcher-listen',    '~> 2.0.0'
end

group :test do
  gem 'capybara',                 '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'guard',                    '~> 2.16', '>= 2.16.2'
  gem 'guard-minitest',           '~> 2.4', '>= 2.4.6'
end

group :production do
  gem 'aws-sdk-s3',               '1.46.0', require: false
  gem 'sendgrid-ruby'
end