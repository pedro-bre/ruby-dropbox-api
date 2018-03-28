module Dropbox::Metadata
	class File < Base

		field :id, String
		field :name, String
		field :client_modified, Time
		field :server_modified, Time
		field :path_lower, String
		field :path_display, String
		field :rev, String
		field :size, Integer
		field :content_hash, String, :optional
		field :media_info, Dropbox::Metadata::MediaInfo, :optional

		def to_hash
			Hash['.tag', 'file'].merge(super)
		end

	end
end