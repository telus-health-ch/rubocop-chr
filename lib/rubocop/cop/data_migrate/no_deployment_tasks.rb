# frozen_string_literal: true

module RuboCop
  module Cop
    module DataMigrate
      # Prevents creation of new deployment tasks in lib/tasks/deployment.
      # Use data-migrate gem instead for data migrations.
      #
      # @example
      #   # bad - creating files in lib/tasks/deployment/
      #
      #   # good - use data-migrate instead
      #   # rails generate data_migration add_new_data
      class NoDeploymentTasks < Base
        MSG = <<~MESSAGE.chomp
          Do not create new files in lib/tasks/deployment/. Use the data-migrate gem instead.

          To create a new data migration:
            rails generate data_migration migration_name

          This will create a file in db/data/ with the following structure:
            class MigrationName < ActiveRecord::Migration[7.2]
              def up
                # Migration code here
              end

              def down
                # Code to revert the changes
              end
            end

          To run data migrations:
            rails db:migrate        # Runs both schema and data migrations (development and test envs only)
            rails data:migrate      # Runs only data migrations
            rails data:rollback     # Rollback data migrations

          For more info, see: https://github.com/ilyakatz/data-migrate
        MESSAGE

        def on_new_investigation
          return unless processed_source.file_path.include?('lib/tasks/deployment/')

          add_global_offense(MSG)
        end
      end
    end
  end
end
