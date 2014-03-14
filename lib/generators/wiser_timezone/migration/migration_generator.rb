require 'generators/wiser_timezone'
require 'rails/generators/active_record'

module WiserTimezone
  module Generators
    # Migration generator that creates migration file from template
    class MigrationGenerator < ActiveRecord::Generators::Base
      extend Base

      argument :name, :type => :string, :default => 'add_wiser_timezone_field'
      # Create migration in project's folder
      def generate_files
        migration_template 'migration.rb', "db/migrate/#{name}"
      end
    end
  end
end