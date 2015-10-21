module ApplicationHelper
  include Flot
  
  def countries
    [ 
      ["United States", "US"]
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

	def credit_card_months
		[
			["01 Jan", "01"],
			["02 Feb", "02"],
			["03 Mar", "03"],
			["04 Apr", "04"],
			["05 May", "05"],
			["06 Jun", "06"],
			["07 Jul", "07"],
			["08 Aug", "08"],
			["09 Sep", "09"],
			["10 Oct", "10"],
			["11 Nov", "11"],
			["12 Dec", "12"]
		]
	end

	def credit_card_years
		@array = []
		index = 0

		# 15 year range
		yearLimit = 15

		(index..yearLimit).each do |i|
			# @array.push(["#{Time.now.year + i}", Time.now.year])
		end
	end

  def numbered_days
    days = []

    (1..31).each do |day|
      if day < 10
        days << ["0#{day}", "0#{day}"]
      else
        days << ["#{day}", "#{day}"]
      end
    end

    days
  end

  def years_until_now
    years = []
    (1900..DateTime.now.year).each do |year|
      years << [year, year]
    end

    years
  end

  def translate_time_to_hours(endTime, startTime)
    totalHours = (endTime - startTime).to_i / 3600
  end

  def translate_time_to_days(endTime, startTime)
    totalDays = (translate_time_to_hours(endTime, startTime) / 24) + 1  # +1 to account for same start and end dates
  end

  def rate_based_time_display(reservationObj, reservationObjPeriod)
    if reservationObj.rate.hourly?
      return reservationObjPeriod.strftime("%l:%m %p - %B %-d, %Y")
    else
      return reservationObjPeriod.strftime("%B %-d, %Y")
    end
  end
end
