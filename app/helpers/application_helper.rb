module ApplicationHelper
	def pusher_include_tag(version)
    domain = if request.ssl?
               'https://d3dy5gmtp8yhk7.cloudfront.net'
             else
               'http://js.pusher.com'
             end

    javascript_include_tag "#{domain}/#{version}/pusher.min.js"
  end	
end
