module Dropbox::Results
	class ListFolder < Base

		# List of Metadata.
		def entries
			@data['entries'].map do |entry|
				Dropbox::Metadata::Parser.parse(entry)
			end
		end

		def cursor
			@data['cursor']
		end

		def has_more?
			@data["has_more"]
		end

	end
end