# frozen_string_literal: true

require 'bundler/setup'
require 'identifiable'
require 'active_record'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

load "#{File.dirname(__FILE__)}/db/schema.rb"
require "#{File.dirname(__FILE__)}/db/models.rb"
