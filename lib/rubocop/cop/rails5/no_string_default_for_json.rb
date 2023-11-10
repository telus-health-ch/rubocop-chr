# frozen_string_literal: true

module RuboCop
  module Cop
    module Rails5
      # This cop checks for migrations with JSON or JSONB columns
      # that have a default value of string.
      # On Rails 5 and above, we should use a hash or array as a default value.
      # @example
      #   # bad
      #   create_table :test_supporters do |t|
      #     t.jsonb :visible_values, default: '[]'
      #   end
      #
      #   # bad
      #   change_column :questions, :attr, :json, default: '{}'
      #
      #   # good
      #   create_table :test_supporters do |t|
      #     t.jsonb :visible_values, default: []
      #   end
      #
      #   # bad
      #   change_column :questions, :attr, :json, default: {}
      class NoStringDefaultForJson < Cop
        MSG = 'Do not use string as a default value for JSON or JSONB columns. Column: %<column>s'.freeze

        RESTRICT_ON_SEND = %i[json jsonb add_column change_column].freeze

        # t.jsonb :visible_values, default: '[]'
        def_node_matcher :json_column_with_string_default_on_create?, <<~PATTERN
          (send _ {:json :jsonb} (sym $_) (hash (pair (sym :default) (str _))))
        PATTERN

        # add_column :questions, :resource_data, :json, default: '{}'
        # change_column :questions, :archive_data, :json, default: '{}'
        def_node_matcher :json_column_with_string_default_on_change?, <<~PATTERN
          (send nil? {:add_column :change_column} (sym _) (sym $_) (sym {:json :jsonb}) (hash (pair (sym :default) (str _))))
        PATTERN

        def on_send(node)
          json_column_with_string_default_on_create?(node) do |column|
            add_offense(node, message: format(MSG, column: column))
          end

          json_column_with_string_default_on_change?(node) do |column|
            add_offense(node, message: format(MSG, column: column))
          end
        end
      end
    end
  end
end
