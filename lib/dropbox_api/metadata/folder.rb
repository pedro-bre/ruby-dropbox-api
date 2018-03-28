module Dropbox::Metadata
	class Folder < Base

		field :id, String
		field :name, String
		field :path_lower, String
		field :path_display, String

		def to_hash
			Hash['.tag', 'folder'].merge(super)
		end

	end
end