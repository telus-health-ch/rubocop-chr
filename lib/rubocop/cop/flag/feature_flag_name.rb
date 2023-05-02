# frozen_string_literal: true

module RuboCop
  module Cop
    module Flag
      # The Feature Flag Name Cop is used to identify flag names that are not
      # using the snake case pattern.
      #
      # @example
      #   # bad
      #   if FeatureFlag.enabled? 'SEARCH_MY_FLAG_ID'
      #
      #   # good
      #   if FeatureFlag.enabled? 'search_my_flag_id'
      class FeatureFlagName < Base
        def_node_matcher :feature_flag_name, <<~PATTERN
        (send
          (const nil? :FeatureFlag) :enabled?
          (str $_))
        PATTERN

        RESTRICT_ON_SEND = [:enabled?].freeze

        def on_send(node)
          feature_flag_name(node) do |name|
            next if to_snake_case(name) == name

            add_offense(node, message: 'Use snake_case with lowercase for feature flag names.')
          end
        end

        def to_snake_case(word)
          word
            .to_s
            .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
            .gsub(/([a-z\d])([A-Z])/, '\1_\2')
            .tr('-', '_')
            .downcase
        end
      end
    end
  end
end
