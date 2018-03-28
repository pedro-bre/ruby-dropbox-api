module Dropbox
	class Client

		def initialize(access_token)
			@session = Dropbox::Session.new(access_token)
		end

		# Disable the access token used to authenticate the call.
		def revoke_token
			@session.rcp('/auth/token/revoke')
		end

		# Copy a file or folder to a different location in the user's Dropbox.
		def copy(from_path, to_path)
			response = @session.rcp('/files/copy_v2', from_path: from_path, to_path: to_path)

			parse_metadata(response)
		end

		# Get a copy reference to a file or folder.
		def get_copy_reference(path)
			Dropbox::Results::GetCopyReference.new(
				@session.rcp('/files/copy_reference/get', path: path)
			)
		end

		# Create a folder at a given path
		def create_folder(path, options = {})
			validate_options([:autorename], options)
			options.merge!(path: path)

			response = @session.rcp('/files/create_folder_v2', options)

			Dropbox::Metadata::Folder.new(response['metadata'])
		end

		# Delete the file or folder at a given path
		def delete(path)
			response = @session.rcp('/files/delete_v2', path: path)

			parse_metadata(response['metadata'])
		end

		# Download a file from a user's Dropbox.
		def download(path)
			response, contents = @session.content_download('/files/download', path: path)

			yield(Dropbox::Metadata::File.new(response), contents)
		end

		# Get the contents of a folder.
		def list_folder(path, options = {})
			validate_options([
				:recursive,
				:include_media_info,
				:include_deleted,
				:include_has_explicit_shared_members
			], options)
			options.merge!(path: path)

			Dropbox::Results::ListFolder.new(
				@session.rcp('/files/list_folder', options)
			)
		end

		# Returns the metadata for a file or folder.
		def get_metadata(path, options = {})
			validate_options([
				:include_media_info,
				:include_deleted,
				:include_has_explicit_shared_members
			], options)
			options.merge!(path: path)

			parse_metadata(@session.rcp('/files/get_metadata', options))
		end

		# Get a preview for a file.
		def get_preview(path)
			response, preview = @session.content_download('/files/get_preview', path: path)

			yield(Dropbox::Metadata::File.new(response), preview)
		end

		# Get a temporary link to stream content of a file.
		def get_temporary_link(path)
			Dropbox::Results::GetTemporaryLink.new(
				@session.rcp('/files/get_temporary_link', path: path)
			)
		end

		# Move a file or folder to a different location in the user's Dropbox.
		def move(from_path, to_path)
			response = @session.rcp('/files/move_v2', from_path: from_path, to_path: to_path)

			parse_metadata(response)
		end

		# Create a new file.
		def upload(path, body, options = {})
			validate_options([
				:mode,
				:autorename,
				:mute
			], options)
			options.merge!(path: path)

			Dropbox::Metadata::File.new(@session.content_upload('/files/upload', body, options))
		end

		private

		def parse_metadata(response)
			Dropbox::Metadata::Parser.parse(response)
		end

		# Takes in a list of valid option keys and a hash of options. 
		# If one of the keys in the hash is invalid an ArgumentError will be raised.
		def validate_options(valid_option_keys, options)
			options.keys.each do |key|
				unless valid_option_keys.include? key.to_sym
					raise ArgumentError, "Invalid option `#{key}`"
				end
			end
		end

	end
end