# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Rails6::NoUpdateAttributes, :config do
  let(:config) { RuboCop::Config.new }

  it 'registers an offense when using update_attributes' do
    expect_offense(<<~RUBY)
      setting.update_attributes data: attributes
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use `update_attributes/update_attributes!`. This method is deprecated and will be removed on Rails 6.1. Please use `update/update!` instead
    RUBY
  end

  it 'registers an offense when using update_attributes with brackets' do
    expect_offense(<<~RUBY)
      setting.update_attributes(data: attributes)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use `update_attributes/update_attributes!`. This method is deprecated and will be removed on Rails 6.1. Please use `update/update!` instead
    RUBY
  end

  it 'registers an offense when using update_attributes!' do
    expect_offense(<<~RUBY)
      setting.update_attributes! data: attributes
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use `update_attributes/update_attributes!`. This method is deprecated and will be removed on Rails 6.1. Please use `update/update!` instead
    RUBY
  end

  it 'registers an offense when using update_attributes! with brackets' do
    expect_offense(<<~RUBY)
      setting.update_attributes!(data: attributes)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use `update_attributes/update_attributes!`. This method is deprecated and will be removed on Rails 6.1. Please use `update/update!` instead
    RUBY
  end

  it 'does not register offenses when using update' do
    expect_no_offenses(<<~RUBY)
    setting.update data: attributes
    RUBY
  end

  it 'does not register offenses when using update with brackets' do
    expect_no_offenses(<<~RUBY)
    setting.update(data: attributes)
    RUBY
  end

  it 'does not register offenses when using update!' do
    expect_no_offenses(<<~RUBY)
    setting.update! data: attributes
    RUBY
  end

  it 'does not register offenses when using update! with brackets' do
    expect_no_offenses(<<~RUBY)
    setting.update!(data: attributes)
    RUBY
  end
end
