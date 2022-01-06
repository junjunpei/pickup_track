class Api::ContactsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :verify_authenticity_token

  def create
    @contact = Contact.new(contact_params)
    return unless @contact.save

    if contact_params[:email] != ''
      ContactMailer.send_mail(@contact).deliver_now
    end
    head :ok
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :category, :message)
  end
end
