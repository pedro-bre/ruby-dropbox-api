require 'test_helper'

class DropboxClientTest < Minitest::Test

	def setup
		@client = Dropbox::Client.new('access-token-1234567890000000000000000000000000000000')
	end

	def test_get_metadata
		FakeWeb.register_uri(:post, rcp_url('files/get_metadata'),
			body: stub('file'),
			content_type: "application/json"
		)
		path = '/Prime_Numbers.txt'
		file = @client.get_metadata(path)

		assert file.is_a?(Dropbox::Metadata::File)
		assert_match /^id:[a-z0-9_-]+$/i, file.id
		assert_equal 'Prime_Numbers.txt', file.name
		assert file.server_modified.is_a?(Time)
		assert_match /^[a-z0-9_-]+$/i, file.rev
		assert_equal 7212, file.size
	end

end