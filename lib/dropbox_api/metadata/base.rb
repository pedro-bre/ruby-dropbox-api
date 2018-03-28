module Dropbox::Metadata
	class Base

		class << self
			attr_reader :fields

			def field(name, type, *options)
				@fields ||= []

				@fields << {
					name: name,
					type: type,
					options: options
				}
			end

		end

		def initialize(metadata)
			self.class.fields.each do |field_data|
				field_name = field_data[:name].to_s
				field = validate(field_data, metadata[field_name])

				self.class.send(:define_method, field_name.to_sym){ field }

				instance_variable_set("@#{field_name}", field)
			end
		end

		def to_hash
			field_names = self.class.fields.map{ |f| f[:name].to_s }

			Hash[field_names.map do |field_name|
				[field_name.to_s, serialize_field(field_name)]
			end.select { |k, v| !v.nil? }]
		end

		private

		def validate(field_data, metadata)
			if metadata.nil?
				raise ArgumentError, "`#{field_data[:name]}` is required" unless field_data[:options].include? :optional
				nil
			else
				cast(metadata, field_data[:type])
			end
		end

		def cast(field_value, field_type)
			if field_type == String
				field_value.to_s
			elsif field_type == Integer
				field_value.to_i
			elsif field_type == Float
				field_value.to_f
			elsif field_type == Time
				Time.parse(field_value)
			elsif field_type.ancestors.include? Dropbox::Metadata::Base
				field_type.new(field_value)
			else
				raise NotImplementedError, "Can't cast `#{field_type}`"
			end
		end

		def serialize_field(field_name)
			value = send(field_name)
			case value
			when Time
				value.utc.strftime("%FT%TZ")
			when Dropbox::Metadata::Base
				value.to_hash
			else
				value
			end
		end

	end
end