module Dropbox::Metadata
	class MediaInfo < Base

		class << self

			def new(data)
				tag = data['.tag'].to_sym
				return :pending if tag == :pending

				Dropbox::Metadata::MediaMetadata.new(data['metadata'])
			end

		end

	end
end