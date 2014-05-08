if Rails.env.production? || Rails.env.staging?
	Paperclip::Attachment.default_options.merge!({
	  storage: :s3,
	  s3_credentials: {
	    access_key_id: 			ENV['s3_access_key_id'],
	    secret_access_key: 	ENV['s3_secret_key_id'],
	    bucket:        			ENV["s3_bucket"]
	  }
	});
end