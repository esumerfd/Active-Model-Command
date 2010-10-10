Gem::Specification.new do |spec|
  
  spec.name = %q{active_model_command}
  spec.version = "0.1"
  
  spec.authors = ["Ed Sumerfield"]
  spec.email = "active_model_command@bitbashers.org"

  spec.files = ["lib/active_model_command.rb", "spec/active_model_command_spec.rb", "README.md"]

  spec.homepage = %q{http://github.com/esumerfd/active_model_command}

  spec.require_paths = ["lib"]
  spec.rubygems_version = %q{1.3.6}
  spec.summary = "Allow command objects to be added as events on the model."
  spec.description = "In the same way that methods can be entered as after_save events, command objects can be set on the model by controllers to define transactional behavior with web layer context."
  spec.post_install_message = "Thank you for trying out Active Model Command. Let me know if you like it esumerfd [at] bitbashers.org"
end
