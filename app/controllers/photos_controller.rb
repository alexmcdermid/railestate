class PhotosController < ApplicationController
  def create
    if params[:photo][:image].present?
      @url = upload_to_s3(params[:photo][:image])
      render json: { url: @url }
    else
      render json: { error: 'error' }, status: 400
    end
  end
  
  private
  
  def upload_to_s3(image)
    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']))
    obj = s3.bucket(ENV['S3_BUCKET']).object(image.original_filename)
    obj.upload_file(image.tempfile)
    obj.key
  end
end
