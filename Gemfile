source 'https://rubygems.org'

group :development, :test do
  gem 'rspec-rails'
  gem "factory_bot_rails"
  gem 'faker'
  gem 'cucumber'
  gem 'pry-rails'
  gem 'awesome_print'
  gem 'guard'
  gem 'better_errors'
  gem 'tzinfo-data'


  # fault injection to improve testing
  # outdated gem 'heckle', :require => false
  gem 'flog', :require => false
  gem 'flay', :require => false
  gem 'rubocop', :require => false
  gem 'rubocop-performance'

  gem 'mutant', :require => false
  gem 'mutant-rspec', :require => false

  # scans for code smells with rubocop, flay, flog
  gem "rubycritic", :require => false

  # guard plugin for rubycritic, reruns when files change
  gem "guard-rubycritic", :require => false

  # rerun rspec tests when files change
  gem "guard-rspec", :require => false

  # rerun brakeman (checks for rails sec. vulns) when files change
  gem "guard-brakeman", :require => false

  # not sure I need this with guard-rubycritic
  gem "guard-rubocop", :require => false

  # look for rails code smells
  gem "guard-rails_best_practices", :require => false

  # scan for sec vulns (CVEs I think) in bundled gems
  #gem "guard-bundler-audit", :require => false
  #gem "guard-bdd", :require => false

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'web-console'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'shoulda-matchers'

  # added a whole bunch of nifty testing and code-quality gems.
  # Descriptions below...

  # simple code coverage metrics
  gem 'simplecov', :require => false


end


gem 'dpl'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jQuery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

