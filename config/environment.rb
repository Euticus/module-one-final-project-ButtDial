require 'bundler'
Bundler.require
require_rel '../app'

require 'tty-prompt'
require 'figlet'
require 'colorize'
require 'rest-client'
require 'net/http'
require 'uri'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'app'

ActiveRecord::Base.logger = nil 
