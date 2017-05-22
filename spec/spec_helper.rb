# frozen_string_literal: true

require File.join('bundler', 'setup')

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'rspec'
require 'pickynode'
