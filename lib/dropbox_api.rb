require 'httparty'
require 'json'
require 'cgi'
require 'openssl'

require 'dropbox_api/auth'

require 'dropbox_api/session'
require 'dropbox_api/client'
require 'dropbox_api/api_error'
require 'dropbox_api/version'

require 'dropbox_api/metadata/base'
require 'dropbox_api/metadata/parser'

require 'dropbox_api/metadata/dimensions'
require 'dropbox_api/metadata/location'
require 'dropbox_api/metadata/photo_metadata'
require 'dropbox_api/metadata/video_metadata'
require 'dropbox_api/metadata/media_info'
require 'dropbox_api/metadata/media_metadata'

require 'dropbox_api/metadata/file'
require 'dropbox_api/metadata/folder'

require 'dropbox_api/results/base'
require 'dropbox_api/results/list_folder'
require 'dropbox_api/results/get_copy_reference'
require 'dropbox_api/results/get_temporary_link'

module Dropbox
end