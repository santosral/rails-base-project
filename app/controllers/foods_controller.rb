class FoodsController < ApplicationController
  require 'net/http'
  require 'carrierwave/orm/activerecord'

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)

    url = URI('https://api.logmeal.es/v2/recognition/complete/v0.9?skip_types=[1,3]&language=eng')
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request['Content-Type'] = 'multipart/form-data'
    request['Authorization'] = 'Bearer 8eea451a5a669bbe383c423c2b420bbe6d48d873'
    form_data = [['image', File.open(@food.image.current_path)]]
    request.set_form form_data, 'multipart/form-data'
    response = https.request(request)
    Rails.logger.debug response.read_body
  end

  private

  def food_params
    params.require(:food).permit(:image, :authenticity_token, :commit, :form_data)
  end
end
