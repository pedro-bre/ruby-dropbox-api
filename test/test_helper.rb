require 'minitest/autorun'
require 'fakeweb'
require 'dropbox_api'
require 'json'

def stub(name)
	JSON.generate(JSON.parse(File.read("test/stubs/#{name}.json")))
end

def rcp_url(path)
	"https://api.dropboxapi.com/2/#{path}"
end

def content_url(path)
	"https://content.dropboxapi.com/2/#{path}"
end