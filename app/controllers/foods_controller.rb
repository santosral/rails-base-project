class FoodsController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'carrierwave/orm/activerecord'
  require 'json'
  
  def index
    @foods = Food.all
  end
  def new
    @food = Food.new
  end
  def create
    @food = Food.create(food_params)
    food_api = find_food(File.open(@food.image.current_path))
    Cloudinary::Uploader.upload(@food.image.current_path, :public_id => @food.food_key)
    Rails.logger.debug @foods_recognized = food_api
    render :new
  end

  def nutritional_info
    @image = Food.last.food_key
    @name = params[:food_name]
    url_food = 'https://edamam-food-and-grocery-database.p.rapidapi.com/parser?ingr=' + params[:food_name]
    url = URI(url_food)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = 'ef49aa5439mshc227905b2f5affep1e0ed8jsn44f99977d013'
    request["x-rapidapi-host"] = 'edamam-food-and-grocery-database.p.rapidapi.com'

    response = http.request(request)
    @nutrition = JSON.parse(response.read_body)
    render :new

  end

  private
  def food_params
    params.require(:food).permit(:food_key, :image, :authenticity_token, :commit, :form_data)
  end
  def request_api(url, form_data)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request['Content-Type'] = 'multipart/form-data'
    request['Authorization'] = 'Bearer 2c9ec17ea3987d47c09efce7f8c93f50ab168483'
    request.set_form form_data, 'multipart/form-data'
    response = https.request(request)
    JSON.parse(response.read_body)
  end
  def find_food(image_path)
    request_api(URI('https://api.logmeal.es/v2/recognition/complete/v0.9?skip_types=[1,3]&language=eng'), [['image', image_path]])
  end
end
