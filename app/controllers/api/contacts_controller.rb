class Api::ContactsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :verify_authenticity_token

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      head :ok
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :category, :message)
  end
end
