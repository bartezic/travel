# encoding: utf-8
class RequestActionsMailer < ActionMailer::Base
  layout false
  default :from => "noty.mongrasse@gmail.com"

  def new_request(request, email)
    @request = request
    mail(to: email, subject: "Нова реєстрація на акції.")
  end
end
