require 'bundler'
require 'tty-prompt'

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

require_all 'lib'
require_all 'app'
require_all 'db/migrate'

# To turn off completely, just add this to your environment file (i.e. production.rb):  
ActiveRecord::Base.logger = nil
