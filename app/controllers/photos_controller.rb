class PhotosController < ApplicationController
  def create
    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']))
    obj = s3.bucket(ENV['S3_BUCKET']).object(params[:image].original_filename)
    obj.upload_file(params[:image].tempfile)
  end
end