# Welcome to Active Model Command

This gem introduces the concept of the [Command Pattern] (http://en.wikipedia.org/wiki/Command_pattern) to the rails
Active Model. 

## Problem

These are two problems that I have faced with integrating business behavior into the Rails model layer that this gem solves. The first requires that an email is sent to a user when some information is changed that they are "watching". A possible solution to this is to use an "after_save" event on the model where you would check to see what the changes were and decide whether an email needs to be sent. If you need to send that email and it needs information in it related to the user that is logged in then you are out of luck because your model doesn't have any references to the controller where that information is usually stored in the session.

Another problem I face is managing the maintenance of an "updated_by" field on a model. If I always need to know who made the last change then I have to supply the model with the current user. Injecting a command that encapsulates the behavior for applying the current user information to the model not only allows context to be supplied but also a common way to offer the context to different models if that field is required on many tables.

## Solution

The Command Pattern allows to give the model something to do. Since we control the creation of the command we can maintain context on the information that we need.

    class MyModel
      extend ActiveModelCommand
      after_save_command :send_emails
    end
  
    class MyController
      def create
        my = MyModel.new
        my.send_emails = SendEmailCommand.new(current_user)
        my.save
      end
    end
  
    class SendEmailCommand
      dev initialize(current_user)
        @current_user = current_user
      end
      def call(model)
        # send an email with the current user email address in it.
      end
    end

