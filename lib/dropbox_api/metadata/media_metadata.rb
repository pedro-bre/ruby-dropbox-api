module Dropbox::Metadata
	class MediaMetadata < Base

		class << self

			def new(data)
				tag = data['.tag']	
				class_for(tag.to_sym).new(data)
			end

			private

			def class_for(tag)
				case tag
				when :photo
					Dropbox::Metadata::PhotoMetadata
				when :video
					Dropbox::Metadata::VideoMetadata
				else
					raise ArgumentError, "Unable to build metadata with `#{tag}`"
				end
			end

		end

	end
end