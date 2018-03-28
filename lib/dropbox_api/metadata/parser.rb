module Dropbox::Metadata
	class Parser
		
		class << self
			def parse(response)
				case response['.tag'].to_sym
				when :file
					Dropbox::Metadata::File.new(response)
				when :folder
					Dropbox::Metadata::Folder.new(response)
				when :deleted
					Dropbox::Metadata::Deleted.new(response)
				else
					raise ArgumentError, "Unable to infer resource type for `#{tag}`"
				end
			end
		end

	end
end