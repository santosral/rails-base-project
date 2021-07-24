require 'uri'
require 'net/http'
require 'openssl'
require 'carrierwave/orm/activerecord'
require 'json'
class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = current_user.foods.all.sort_by(&:updated_at).reverse
  end

  def show
    @cur_user = current_user
    @food = current_user.foods.find(params[:id])
    @nutrition = @food.nutritional_informations.all
  end

  def new
    @food = current_user.foods.new
  end

  def create
    @food = current_user.foods.create(food_params)
    food_api = find_food(File.open(@food.image.current_path))
    Cloudinary::Uploader.upload(@food.image.current_path, public_id: @food.food_key)
    Rails.logger.debug @foods_recognized = food_api
    render :new
  end

  def nutritional_info
    @foods = current_user.foods.all
    @food = @foods.where(food_name: nil).last
    @food.food_name = params[:food_name]
    @food.save
    url_food = "https://edamam-food-and-grocery-database.p.rapidapi.com/parser?ingr=#{params[:food_name]}"
    url = URI(url_food)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request['x-rapidapi-key'] = 'ef49aa5439mshc227905b2f5affep1e0ed8jsn44f99977d013'
    request['x-rapidapi-host'] = 'edamam-food-and-grocery-database.p.rapidapi.com'

    response = http.request(request)
    @nutrition = JSON.parse(response.read_body)

    @food.nutritional_informations.create(food_name: @food.food_name, label: 'Energy', quantity: @nutrition['parsed'][0]['food']['nutrients']['ENERC_KCAL'], unit: 'kcal')
    @food.nutritional_informations.create(food_name: @food.food_name, label: 'Protein', quantity: @nutrition['parsed'][0]['food']['nutrients']['PROCNT'], unit: 'g')
    @food.nutritional_informations.create(food_name: @food.food_name, label: 'Fat', quantity: @nutrition['parsed'][0]['food']['nutrients']['FAT'], unit: 'g')
    @food.nutritional_informations.create(food_name: @food.food_name, label: 'Carbohydrates', quantity: @nutrition['parsed'][0]['food']['nutrients']['CHOCDF'], unit: 'g')
    @food.nutritional_informations.create(food_name: @food.food_name, label: 'Fibre', quantity: @nutrition['parsed'][0]['food']['nutrients']['FIBTG'], unit: 'g')

    deletable = @foods.where(food_name: nil)
    deletable&.destroy_all

    redirect_to food_path(@food)
  end

  def edit
    @food = current_user.foods.find(params[:id])
  end

  def update
    @food = current_user.foods.find(params[:id])

    if @food.update(food_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @food = current_user.foods.find(params[:id])
    @food.destroy

    redirect_to root_path
  end

  private

  def food_params
    params.require(:food).permit(:user_username, :food_key, :image, :commit, :form_data, :caption, :recipe_url)
  end

  def request_api(url, form_data)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request['Content-Type'] = 'multipart/form-data'
    request['Authorization'] = 'Bearer d39ee38785434a14fb1a5f388c66b75a67fa4ed8'
    request.set_form form_data, 'multipart/form-data'
    response = https.request(request)
    JSON.parse(response.read_body)
  end

  def find_food(image_path)
    request_api(URI('https://api.logmeal.es/v2/recognition/complete/v0.9?skip_types=[1,3]&language=eng'), [['image', image_path]])
  end
end
