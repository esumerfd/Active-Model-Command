require 'rspec'
require 'active_model_command'

describe ActiveModelCommand do

  context "instrument model" do

    before do

      class FooModel
        class << self
          attr_accessor :after_save_called
        end

        def self.after_save(method)
          FooModel.after_save_called = true
        end

        extend ActiveModelCommand
        after_save_command :bar
      end

      class Command
        attr_reader :called
        def call(model)
          @called = true
        end
      end

    end

    it "adds the attribute" do
      FooModel.respond_to?(:bar).should be_false
      FooModel.new.respond_to?(:bar).should be_true
    end

    it "create after save method" do
      FooModel.respond_to?(:_run_bar_after_save).should be_false
      FooModel.new.respond_to?(:_run_bar_after_save).should be_true
    end

    it "includes itself as the after_save callback" do
      FooModel.after_save_called.should be_true
    end

    it "delegates to our command on the after_save event" do
      model = FooModel.new
      model.bar = Command.new

      # Simulate after save event
      model.send(:_run_bar_after_save)

      model.bar.called.should be_true
    end

    it "does not delegate anything if there is no command" do
      model = FooModel.new

      model.send(:_run_bar_after_save)
    end
  end
end
