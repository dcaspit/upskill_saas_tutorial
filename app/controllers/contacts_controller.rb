class ContactsController < ApplicationController
   def new
      # Looking for core responding views file that matches the method name.
      @contact = Contact.new
   end
   
   def create
      # Looking for core responding views file that matches the method name.
      @contact = Contact.new(contact_params)
      if @contact.save # Checking if the form Inserted succesfully into the db.
         name = params[:contact][:name]
         email = params[:contact][:email]
         body = params[:contact][:comments]
         ContactMailer.contact_email(name, email, body).deliver
         flash[:success] = "Message sent."
         redirect_to new_contact_path
      else
         # Puting to 'flash' hash a key and a value
         flash[:danger] = @contact.errors.full_messages.join(", ") # Value = the default error message of the flash hash"
         redirect_to new_contact_path
      end
   end
   
   private
      # Creating a method with our contact form parametares
      def contact_params
         params.require(:contact).permit(:name, :email, :comments)
      end
end