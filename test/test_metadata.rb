require 'test_helper'

class DropboxMetadataTest < Minitest::Test

	def test_file_initialize
		file = Dropbox::Metadata::File.new(
			'id' => 'id:123', 
			'name' => 'file',
			'path_lower' => '/folder/file', 
			'path_display' => '/folder/file',
			'rev' => '123455',
			'size' => 11, 
			'client_modified' => '2007-07-07T00:00:00Z',
			'server_modified' => '2007-07-07T00:00:00Z'
		)

		assert_equal 'id:123', file.id
		assert_equal 'file', file.name
		assert_equal '/folder/file', file.path_lower
		assert_equal '/folder/file', file.path_display
		assert_equal 11, file.size
	end

end