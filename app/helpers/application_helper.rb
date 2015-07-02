module ApplicationHelper
  def countries
    [ 
      ["United States", "US"],
      ["Canada", "CA"],
      ["Guatemala", "GU"]
    ]
    
  end
  
	def us_states
	    [
	      ['Alabama', 'AL'],
	      ['Alaska', 'AK'],
	      ['Arizona', 'AZ'],
	      ['Arkansas', 'AR'],
	      ['California', 'CA'],
	      ['Colorado', 'CO'],
	      ['Connecticut', 'CT'],
	      ['Delaware', 'DE'],
	      ['District of Columbia', 'DC'],
	      ['Florida', 'FL'],
	      ['Georgia', 'GA'],
	      ['Hawaii', 'HI'],
	      ['Idaho', 'ID'],
	      ['Illinois', 'IL'],
	      ['Indiana', 'IN'],
	      ['Iowa', 'IA'],
	      ['Kansas', 'KS'],
	      ['Kentucky', 'KY'],
	      ['Louisiana', 'LA'],
	      ['Maine', 'ME'],
	      ['Maryland', 'MD'],
	      ['Massachusetts', 'MA'],
	      ['Michigan', 'MI'],
	      ['Minnesota', 'MN'],
	      ['Mississippi', 'MS'],
	      ['Missouri', 'MO'],
	      ['Montana', 'MT'],
	      ['Nebraska', 'NE'],
	      ['Nevada', 'NV'],
	      ['New Hampshire', 'NH'],
	      ['New Jersey', 'NJ'],
	      ['New Mexico', 'NM'],
	      ['New York', 'NY'],
	      ['North Carolina', 'NC'],
	      ['North Dakota', 'ND'],
	      ['Ohio', 'OH'],
	      ['Oklahoma', 'OK'],
	      ['Oregon', 'OR'],
	      ['Pennsylvania', 'PA'],
	      ['Puerto Rico', 'PR'],
	      ['Rhode Island', 'RI'],
	      ['South Carolina', 'SC'],
	      ['South Dakota', 'SD'],
	      ['Tennessee', 'TN'],
	      ['Texas', 'TX'],
	      ['Utah', 'UT'],
	      ['Vermont', 'VT'],
	      ['Virginia', 'VA'],
	      ['Washington', 'WA'],
	      ['West Virginia', 'WV'],
	      ['Wisconsin', 'WI'],
	      ['Wyoming', 'WY']
	    ]
	end
	
	def times
      [
        ['Hourly', 'per hour'],
        ['Daily', 'per day'],
        ['Weekly', 'per week'],
        ['Monthly', 'per month'],
      ]
  	end

  	# Translates phrases like "hourly" or "per hour" => "hour"
  	def base_time(timePhrase)
  		phrase = timePhrase.downcase

  		if phrase.include? "hour"
  			filtered = "hour"
  		elsif phrase.include?("daily") || phrase.include?("day")
  			filtered = "day"
  		elsif phrase.include? "week"
  			filtered = "week"
  		elsif phrase.include? "month"
  			filtered = "month"
  		else
  			filtered = timePhrase
  		end

  		filtered
  	end

  	def card_types
  	  [
  	  	["Visa", "visa"],
  	  	["MasterCard", "master"],
  	  	["Discover", "discover"],
  	  	["American Express", "american_express"]
  	  ]
  	end
end
