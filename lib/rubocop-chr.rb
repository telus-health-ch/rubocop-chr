# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/chr'
require_relative 'rubocop/chr/version'
require_relative 'rubocop/chr/inject'

RuboCop::Chr::Inject.defaults!

require_relative 'rubocop/cop/chr_cops'
