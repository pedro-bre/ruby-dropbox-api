module Dropbox
	class ApiError < StandardError
		attr_reader :message

		def initialize(response)
			if response.headers['content-type'] == 'application/json'
				@message = JSON.parse(response.body)['error_summary']
			else
				@message = response
			end
		end

	end
end