require 'unirest'

def primary_image images
	images.each do |image|
		return image["url"] if image["primary"]
	end
	return nil
end

def analyse url
	token = "55b926c2d517a686c705a3846534f87a"
	type = "article"
	response = Unirest::get "http://api.diffbot.com/v2/#{type}", 
						parameters: { token: token, url: url }
	{text: response.body["text"], 
	 image: response.body["images"] ? primary_image(response.body["images"]) : nil}
end

url = ARGV[0]
p analyse url