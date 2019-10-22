require 'bundler'
Bundler.require
require_rel '../app'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'app'

ActiveRecord::Base.logger = nil 
