class NoDuplicateValuesValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		@values = []
		@values << value

		if @values.uniq.length != @values.length
			record.errors[attribute] << (options[:message] || "Duplicate values are not allowed.")
		end
	end
end