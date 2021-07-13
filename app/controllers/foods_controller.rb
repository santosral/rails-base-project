class FoodsController < ApplicationController
    require "uri"
    # require 'rest-client'
    require 'net/http'
    require 'carrierwave/orm/activerecord'

    def new
      @food = Food.new
    end

    def create
      @food = Food.new(food_params)
      # @#food.save!
      
      url = URI("https://api.logmeal.es/v2/recognition/complete/v0.9?skip_types=[1,3]&language=eng")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "multipart/form-data"
      request["Authorization"] = "Bearer c0b05d461f5debd4f8b4a53b3478196a33095ec8"
      form_data = @food.food_id.image
      request.set_form form_data, 'multipart/form-data'
      response = https.request(request)
      puts response
      # response =RestClient.post RestClient.post 'https://api.logmeal.es/v2/recognition/complete/v0.9?skip_types=[1,3]&language=eng',
      #                   {:Authorization => 'Bearer c0b05d461f5debd4f8b4a53b3478196a33095ec8'}, 
      #                   :image => File.new(@food.image.current_path, 'rb')
      # puts response
    end

    private
    def food_params
        params.require(:food).permit(:image, :authenticity_token, :commit)
    end
end
