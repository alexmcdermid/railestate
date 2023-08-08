class PhotosController < ApplicationController
  before_action :check_upload_limit, only: :create

  MAX_UPLOADS = 10

  def create
    if params[:photo][:image].present?
      @url = upload_to_s3(params[:photo][:image])
      current_user.increment!(:file_uploads_count)
      render json: { url: @url }
    else
      render json: { error: 'Image not present' }, status: 400
    end
  end
  
  private
  
  def upload_to_s3(image)
    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']))
    obj = s3.bucket(ENV['S3_BUCKET']).object(image.original_filename)
    obj.upload_file(image.tempfile)
    obj.key
  end

  def check_upload_limit
    if current_user.file_uploads_count >= MAX_UPLOADS
      render json: { error: 'Upload limit reached' }, status: 400
    end
  end
end
