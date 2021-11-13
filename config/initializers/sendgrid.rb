ActionMailer::Base.add_delivery_method :sendgrid, 
                                       Mail::SendGrid,
                                       api_key: ENV['SEND_GRID_API_KEY']
