#
# Allow commands to be created and set on models for integration with the model
# lifecycle events.
#
#   class MyModel
#     extend ActiveModelCommand
#     after_save_command :send_emails
#   end
#
#   class MyController
#     def create
#       my = MyModel.new
#       my.send_emails = SendEmailCommand.new(current_user)
#       my.save
#     end
#   end
#
#   class SendEmailCommand
#     def initialize(current_uer)
#       @current_user = current_user
#     end
#     def call(model)
#       # send an email with the current users email address in it
#     end
#   end
#
module ActiveModelCommand

  def after_save_command(command_attribute)

    # create accessor that will be used by the user to set the command to be run
    attr_accessor(command_attribute)

    # create an instance method that will be called by active model after save
    method = self.send(:define_method, "_run_#{command_attribute}_after_save") do

      # get the command object and call it.
      command = self.send(command_attribute)
      command.call(self) if command
    end

    after_save(method)
  end
end
