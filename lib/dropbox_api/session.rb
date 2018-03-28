module Dropbox
	class Session

		RCP_ENDPOINT = 'api.dropboxapi.com'
		CONTENT_ENDPOINT = 'content.dropboxapi.com'

		attr_reader :access_token

		def initialize(access_token)
			@access_token = access_token
		end

		def rcp(path, options = {})
			url = URI::HTTPS.build(host: RCP_ENDPOINT, path: "/2#{path}")

			unless options.empty?
				settings = default_settings

				settings.merge!(body: JSON.generate(options))[:headers]
								.merge!('Content-Type' => 'application/json')
			end

			response = HTTParty.post(url, settings)		
			raise Dropbox::ApiError.new(response) if response.code != 200

			JSON.parse(response.body)
		end

		def content_upload(path, body, options = {})
			url = URI::HTTPS.build(host: CONTENT_ENDPOINT, path: "/2#{path}")

			settings = default_settings
			settings.merge!(body: body)[:headers]
							.merge!('Dropbox-API-Arg' => JSON.generate(options))
							.merge!('Content-Type' => 'application/octet-stream')

			response = HTTParty.post(url.to_s, settings)
			raise Dropbox::ApiError.new(response) if response.code != 200

			JSON.parse(response.body)
		end

		def content_download(path, options = {})
			url = URI::HTTPS.build(host: CONTENT_ENDPOINT, path: "/2#{path}")

			settings = default_settings
			settings[:headers].merge!('Dropbox-API-Arg' => JSON.generate(options))

			response = HTTParty.post(url.to_s, settings)
			raise Dropbox::ApiError.new(response) if response.code != 200

			return JSON.parse(response.headers['Dropbox-API-Result']), response.body
		end

		private

		def default_settings
			{
				headers: {
					'Content-Type' => 'text/plain; charset=utf-8',
					'Authorization' => "Bearer #{@access_token}",
					'User-Agent' => "Dropbox API SDK/#{Dropbox::VERSION}"
				}
			}
		end

	end
end