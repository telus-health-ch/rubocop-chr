# frozen_string_literal: true

module RuboCop
  module Cop
    module Rails7
      # Identifies when passing date/time formats to `#to_s`.
      #
      # @example
      #
      #   # bad
      #   obj.to_s(:yyyy_mm_dd)
      #
      #   # good
      #   obj.to_fs(:yyyy_mm_dd)
      #
      class CustomToSWithArgument < Base
        extend AutoCorrector

        FORMATS = Set.new(
          %i[
            db
            full
            h_mm_a
            h_mm_a_z
            HH_mm
            iso8601
            nsec
            short
            yyyy_mm_dd
            YYYY_MM_DD
            yyyy_mm_dd_HH_mm
            yyyymmdd
          ]
        )

        MSG = 'Use `to_fs` instead.'

        RESTRICT_ON_SEND = %i[to_s].freeze

        def on_send(node)
          return unless not_allowed_format?(node)

          add_offense(node)  do |corrector|
            corrector.replace(node.loc.selector, 'to_fs')
          end
        end

        private

        def not_allowed_format?(node)
          node.first_argument&.sym_type? && FORMATS.include?(node.first_argument.value)
        end
      end
    end
  end
end
