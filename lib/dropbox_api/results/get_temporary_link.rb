module Dropbox::Results
	class GetTemporaryLink < Base

		# Metadata of the file.
		def file
			Dropbox::Metadata::File.new(@data['metadata'])
		end

		# The temporary link which can be used to stream content the file.
		def link
			@data['link']
		end

	end
end