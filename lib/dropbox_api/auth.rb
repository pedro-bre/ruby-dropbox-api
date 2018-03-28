module Dropbox
	class Auth

		attr_accessor :client_id, :client_secret, :redirect_uri

		def initialize(client_id, client_secret, redirect_uri = nil)
			@client_id = client_id
			@client_secret = client_secret
			@redirect_uri = redirect_uri	
		end

		def authorize_url
			generate_authorize_url
		end

		def get_token(code)
			payload = {
				code: code,
				grant_type: 'authorization_code',
				client_id: @client_id,
				client_secret: @client_secret,
				redirect_uri: @redirect_uri
			}

			response = HTTParty.post(
				'https://api.dropboxapi.com/1/oauth2/token',
				{
					body: payload
				}
			)
			raise Dropbox::ApiError.new(response) if response.code != 200
			
			JSON.parse(response.body)['access_token']
		end

		def generate_authorize_url
			params = {
				client_id: @client_id,
				response_type: 'code',
				redirect_uri: @redirect_uri
			}
			query = URI.encode_www_form(params)

			"https://www.dropbox.com/authorize/1/oauth2/authorize?#{query}"
		end

	end
end