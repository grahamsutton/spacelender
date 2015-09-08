FactoryGirl.define do
  factory :location, :class => "Location" do
    street_address "1399 West 79th Street"
    city "Hialeah"
    state "FL"
    country "USA"
    zip 33014
    #latitude 23.9109586
    #longitude -80.3045967
  end

  factory :nonexistent_location, :class => "Location" do
    street_address "544 asd98tqyr4"
    city "apduasdfa23i"
    state "23"
    country "IUIPU$BG"
    zip 11111
  end
end