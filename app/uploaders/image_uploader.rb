class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  storage :file
  version :simple do
    process resize_to_fill: [164, 164, :fill]
    process convert: 'jpg'
    cloudinary_transformation quality: 80
  end
  # storage :fog
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # to set where we save our image to Image folder
  def public_id
    # return "Image/" + Cloudinary::Utils.random_public_id
    "Image/#{model.food_key}"
  end
end
