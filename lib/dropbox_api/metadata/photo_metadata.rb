module Dropbox::Metadata
	class PhotoMetadata < Base

		field :dimensions, Dropbox::Metadata::Dimensions, :optional
		field :location, Dropbox::Metadata::Location, :optional
		field :time_taken, Time, :optional

	end
end