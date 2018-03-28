module Dropbox::Metadata
	class VideoMetadata < Base

		field :dimensions, Dropbox::Metadata::Dimensions, :optional
		field :location, Dropbox::Metadata::Location, :optional
		field :time_taken, Time, :optional
		field :duration, Integer, :optional

	end
end