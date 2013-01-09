require 'sequel'

platform_specific_adapter = RUBY_PLATFORM == "java" ? "jdbc:" : nil

DB = Sequel.connect("#{platform_specific_adapter}sqlite:database/retro.db")
