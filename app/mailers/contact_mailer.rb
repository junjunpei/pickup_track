class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail to: @contact.email, subject: '[お問い合わせについて]'
  end
end
