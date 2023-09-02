# frozen_string_literal: true

class Listing < ApplicationRecord
  belongs_to :user

  def image_url
    return unless image_url.present?

    s3 = Aws::S3::Resource.new(
      region: ENV["AWS_REGION"],
      credentials: Aws::Credentials.new(
        ENV["AWS_ACCESS_KEY_ID"],
        ENV["AWS_SECRET_ACCESS_KEY"]
      )
    )

    obj = s3.bucket(ENV["S3_BUCKET"]).object(image_url)

    obj.presigned_url(
      :get,
      expires_in: 3600, # URL will expire in 1 hour
      response_content_type: "image/png", # replace with the correct content type
      response_content_disposition: "attachment" # or 'inline'
    )
  end
end
