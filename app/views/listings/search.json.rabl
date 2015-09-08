collection @listings
attributes :id, :name, :description, :created_at

child :location do
	attributes :city, :state
end

child :pictures do
	attributes :id

	node :url do |i|
		i.image(:original)
	end
end

child :rates do
	attributes :id, :amount, :date_range
end