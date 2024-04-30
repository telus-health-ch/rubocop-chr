# frozen_string_literal: true

module RuboCop
  module Cop
    module Rails6
      # This cop checks if a ruby file is using the method `update_attributes`.
      # This method is deprecated and will be removed on Rails 6.1.
      # This is part of the Rails 6 upgrade.
      # @example
      #   # bad
      #   setting.update_attributes data: attributes
      #
      #   # good
      #   setting.update data: attributes
      class NoUpdateAttributes < Cop
        MSG = 'Do not use `update_attributes/update_attributes!`. This method is deprecated and will be removed on Rails 6.1. Please use `update/update!` instead'.freeze

        def_node_matcher :update_attributes?, <<~PATTERN
          (send _ {:update_attributes :update_attributes!} ...)
        PATTERN

        def on_send(node)
          return unless update_attributes?(node)

          add_offense(node, location: :expression)
        end

        def autocorrect(node)
          lambda do |corrector|
            new_method_name = node.method_name == :update_attributes ? 'update' : 'update!'
            corrector.replace(node.loc.selector, new_method_name)
          end
        end
      end
    end
  end
end
