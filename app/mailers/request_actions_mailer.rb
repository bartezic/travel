# encoding: utf-8
class RequestActionsMailer < ActionMailer::Base
  layout false
  default :from => "noty.mongrasse@gmail.com"

  def new_request(request, host)
    @request = request
    @host = host
    AdminUser.all.each do |user|
      mail(to: user.email, subject: "Нова реєстрація на акції.")
    end
  end
end
