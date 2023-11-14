# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Rails5::NoStringDefaultForJson, :config do
  let(:config) { RuboCop::Config.new }

  it 'registers an offense when using string as default value for json field on create_table' do
    expect_offense(<<~RUBY)
      t.json :archive_data, default: '{}'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use string as a default value for JSON or JSONB columns. Column: archive_data
    RUBY

    expect_offense(<<~RUBY)
      t.jsonb :archive_data, default: '[]'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use string as a default value for JSON or JSONB columns. Column: archive_data
    RUBY
  end

  it 'registers an offense when using string as default value for json field on add_column/change_colum' do
    expect_offense(<<~RUBY)
      add_column :appointments, :more_data, :json, default: '[]'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use string as a default value for JSON or JSONB columns. Column: more_data
    RUBY

    expect_offense(<<~RUBY)
      change_column :questions, :archive_data, :jsonb, default: '{}'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use string as a default value for JSON or JSONB columns. Column: archive_data
    RUBY
  end

  it 'does not register offenses when using objects as default values' do
    expect_no_offenses(<<~RUBY)
      add_column :appointments, :more_data, :json, default: []
    RUBY

    expect_no_offenses(<<~RUBY)
      change_column :questions, :archive_data, :jsonb, default: {}
    RUBY
  end
end
