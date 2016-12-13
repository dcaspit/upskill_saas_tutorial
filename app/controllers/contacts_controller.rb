class ContactsController < ApplicationController
   def new
      # Running on creating contact page.
      @contact = Contact.new
   end
   
   def create
      # Running when sumbiting the form.
      @contact = Contact.new(contact_params)
      if @contact.save # Checking if the form Inserted succesfully into the db.
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