# frozen_string_literal: true

require 'yaml'

module RuboCop
  module Cop
    module Migration
      # Ensure that no one commits any migrations where a column name uses a reserve word.
      # The reserved words for postgres can be found here: https://www.postgresql.org/docs/current/sql-keywords-appendix.html
      class ReservedWordColumnName < Cop
        MSG = 'Avoid using PostgreSQL reserved words for column names. Found: %<reserved_word>s'

        dir = File.dirname(File.expand_path(__FILE__))
        POSTGRESQL_RESERVED_WORDS = YAML.load_file("#{dir}/reserved_words.yaml")

        def on_send(node)
          return unless migration_method?(node)

          column_name = extract_column_name(node).upcase
          return unless POSTGRESQL_RESERVED_WORDS.include?(column_name)

          add_offense(node, message: format(MSG, reserved_word: column_name))
        end

        private

        def migration_method?(node)
          node.method_name == :add_column || node.method_name == :remove_column || node.method_name == :rename_column
        end

        def extract_column_name(node)
          node.arguments[1].to_a[0].to_s
        end
      end
    end
  end
end
