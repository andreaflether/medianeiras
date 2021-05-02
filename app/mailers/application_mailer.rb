# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  include Roadie::Rails::Automatic
  default from: 'noreply@ccnsmedianeira.com'
  layout 'mailer'
end
