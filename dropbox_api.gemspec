# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rubygems"
require "dropbox_api/version"


Gem::Specification.new do |s|
	s.name        = "dropbox_api"
	s.version     = Dropbox::VERSION
	s.date        = "2018-03-27"

	s.summary     = "A Ruby library for the Dropbox API V2"
	s.description = ""

	s.authors     = ["Pedro Bre"]
	s.email       = "pedro@optimmerce.net"
	s.files       = Dir["lib/dropbox_api.rb", "lib/dropbox_api/*.rb"]
	s.homepage    = "https://github.com/pedro-bre/ruby-dropbox-api"

	s.add_runtime_dependency "httparty"
	s.add_runtime_dependency "json"
end