# frozen_string_literal: true

require 'yaml'

module RuboCop
  module Cop
    module Migration
      # Ensure that no one commits any migrations where a column name uses a reserved word.
      # The reserved words for postgres can be found here: https://www.postgresql.org/docs/current/sql-keywords-appendix.html
      class ReservedWordColumnName < Cop
        MSG = 'Avoid using PostgreSQL reserved words for column names. Found: %<reserved_word>s'

        dir = File.dirname(File.expand_path(__FILE__))
        POSTGRESQL_RESERVED_WORDS = YAML.load_file("#{dir}/reserved_words.yaml")

        def on_send(node)
          return unless migration_method?(node)

          column_name = extract_column_name_based_on_method(node)
          check_column_name(node, column_name) if column_name
        end

        private

        def migration_method?(node)
          %i[add_column rename_column].include?(node.method_name)
        end

        def extract_column_name_based_on_method(node)
          case node.method_name
          when :add_column
            extract_column_name(node)
          when :rename_column
            extract_new_column_name(node)
          end
        end

        def extract_column_name(node)
          node.arguments[1].to_a[0].to_s
        end

        def extract_new_column_name(node)
          node.arguments[2].to_a[0].to_s
        end

        def check_column_name(node, column_name)
          return unless reserved_word?(column_name)

          add_offense(node, message: format(MSG, reserved_word: column_name.upcase))
        end

        def reserved_word?(column_name)
          POSTGRESQL_RESERVED_WORDS.include?(column_name.upcase)
        end
      end
    end
  end
end
