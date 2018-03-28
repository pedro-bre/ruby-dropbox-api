module Dropbox::Results
	class GetCopyReference < Base

		# Metadata of the file or folder.
		def resource
			Dropbox::Metadata::Parser.parse(@data['metadata'])
		end

		# A copy reference to the file or folder.
		def copy_reference
			@data["copy_reference"]
		end

		# The expiration date of the copy reference.
		def expires
			Time.parse(@data["expires"])
		end

	end
end