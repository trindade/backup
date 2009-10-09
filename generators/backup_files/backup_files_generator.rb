class BackupFilesGenerator < Rails::Generator::Base

  # This method gets initialized when the generator gets run.
  # It will receive an array of arguments inside @args
  def initialize(runtime_args, runtime_options = {})
    super
    extract_args
    set_defaults
    confirm_input
  end
  
  # Processes the file generation/templating
  # This will automatically be run after the initialize method
  def manifest
    record do |m|
      
      # Generate the Rake Tasks
      m.directory "lib/tasks"
      m.directory "lib/tasks/backup"
      m.directory "lib/tasks/backup/files"
      m.file      "config.rake",    "lib/tasks/backup/config.rake"
      m.file      "s3.rake",        "lib/tasks/backup/s3.rake"
      m.file      "ssh.rake",       "lib/tasks/backup/ssh.rake"
      m.file      "db.rake",        "lib/tasks/backup/db.rake"
      m.file      "setup.rake",     "lib/tasks/backup/setup.rake"
      m.file      "backup.sqlite3", "lib/tasks/backup/files/backup.sqlite3"
      
      # Generate the YAML files
      m.directory "config/backup"
      m.file      "s3.yml",       "config/backup/s3.yml"
      m.file      "ssh.yml",      "config/backup/ssh.yml"
      
      # Generates the backup.sqlite3 database
      m.directory "db"
      m.file      "backup.sqlite3", "db/backup.sqlite3"
      
    end
  end
  
  # Creates a new Hash Object containing the user input
  # The user input will be available through @input and input
  def extract_args
    @input = Hash.new
    @args.each do |arg|
      if arg.include?(":") then
        @input[:"#{arg.slice(0, arg.index(":"))}"] = arg.slice((arg.index(":") + 1)..-1)
      end
    end
  end
  
  # Input Method that's available inside the generated templates
  # because instance variable are not available, so we access them through methods
  def input
    @input
  end

  # Sets defaults for user input when left blank by the user
  # for each parameter
  def set_defaults
  end
  
  # Confirms whether the model and attachment arguments were passed in
  # Raises an error if not
  def confirm_input
  end
  
  private
  
  def input_error
  end
  
end