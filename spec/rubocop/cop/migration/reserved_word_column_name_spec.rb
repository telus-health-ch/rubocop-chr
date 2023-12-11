# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RuboCop::Cop::Migration::ReservedWordColumnName do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  it 'registers an offense when a column name is a reserved word' do
    inspect_source('add_column :users, :select, :string')

    expect(cop.offenses.size).to eq(1)
    expect(cop.messages).to eq(['Avoid using PostgreSQL reserved words for column names. Found: SELECT'])
  end

  it 'does not register an offense when a column name is not a reserved word' do
    inspect_source('add_column :users, :nomeclature, :string')

    expect(cop.offenses).to be_empty
  end
end
