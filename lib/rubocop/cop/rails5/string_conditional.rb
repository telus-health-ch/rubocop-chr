# frozen_string_literal: true

module RuboCop
  module Cop
    module Rails5
      # @example
      #   # bad
      #   class Post < ApplicationRecord
      #     validates :title, if: 'author.present?'
      #   end
      #
      #   # good
      #   class Post < ApplicationRecord
      #     validates :title, if: -> { author.present? }
      #   end
      #
      #   # good
      #   class Post < ApplicationRecord
      #     validates :title, if: :author_present?
      #
      #     private
      #
      #     def author_present?
      #       author.present?
      #     end
      #   end
      #
      class StringConditional < Base
        MSG = 'Use `%<statement>s %<data>s, %<conditional>s: -> { %<str>s }` instead of `%<conditional>s: "%<str>s"`.'

        RESTRICT_ON_SEND = %i[validates before_validation after_validation].freeze

        def_node_matcher :string_validation?, <<~PATTERN
          (send _ ${:validates | :before_validation | :after_validation} $_* (hash {... (pair (sym ${:if | :unless}) (:str $_)) | (pair (sym ${:if | :unless}) (:str $_)) ...}))
        PATTERN

        def on_send(node)
          string_validation?(node) do |statement, data, conditional, str|
            data = Array(data).map { |v| ":#{v.value}" }.join(', ')
            add_offense(node,
                        message: format(MSG, statement: statement, conditional: conditional, data: data, str: str))
          end
        end
      end
    end
  end
end
