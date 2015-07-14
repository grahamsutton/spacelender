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

module ActionView
  module Helpers
	  class FormBuilder 
	      def date_select(method, options = {}, html_options = {})
	        existing_date = @object.send(method) 
	        formatted_date = existing_date.to_date.strftime("%F") if existing_date.present?
	        @template.content_tag(:div, :class => "input-group") do    
	          text_field(method, :value => formatted_date, :class => "form-control datepicker", :"data-date-format" => "MM-DD-YYYY") +
	          @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
	        end
	      end

	      def datetime_select(method, options = {}, html_options = {})
	        existing_time = @object.send(method) 
	        formatted_time = existing_time.to_time.strftime("%F %I:%M %p") if existing_time.present?
	        @template.content_tag(:div, :class => "input-group") do    
	          text_field(method, :value => formatted_time, :class => "form-control datetimepicker", :"data-date-format" => "MM-DD-YYYY hh:mm A") +
	          @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
	        end
	      end
	  end
  end
end
