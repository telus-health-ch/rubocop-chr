# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Rails5::StringConditional, :config do
  let(:config) { RuboCop::Config.new }

  it 'registers an offense when using `validates` with a string conditional' do
    expect_offense(<<~RUBY)
      validates :foo, :bar, if: 'conditional_statement'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `validates :foo, :bar, if: -> { conditional_statement }` instead of `if: "conditional_statement"`.
    RUBY
  end

  it 'registers an offense when using `before_validation` with a string conditional' do
    expect_offense(<<~RUBY)
      before_validation :foo, if: 'conditional_statement'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `before_validation :foo, if: -> { conditional_statement }` instead of `if: "conditional_statement"`.
    RUBY
  end

  it 'registers an offense when using `after_validation` with a string conditional' do
    expect_offense(<<~RUBY)
      after_validation :foo, if: 'conditional_statement'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `after_validation :foo, if: -> { conditional_statement }` instead of `if: "conditional_statement"`.
    RUBY
  end

  it 'registers an offence when using more then one option in `validates`' do
    expect_offense(<<~RUBY)
      validates :foo, presence: true, if: 'conditional_statement'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `validates :foo, if: -> { conditional_statement }` instead of `if: "conditional_statement"`.
    RUBY

    expect_offense(<<~RUBY)
      validates :foo, if: 'conditional_statement', presence: true
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `validates :foo, if: -> { conditional_statement }` instead of `if: "conditional_statement"`.
    RUBY
  end

  it 'does not register an offense when using `validates` with a prod conditional' do
    expect_no_offenses(<<~RUBY)
      validates :foo, if: -> { bar }
    RUBY
  end

  it 'does not register an offense when using `before_validation` with a prod conditional' do
    expect_no_offenses(<<~RUBY)
      before_validation :foo, if: -> { bar }
    RUBY
  end

  it 'does not register an offense when using `after_validation` with a prod conditional' do
    expect_no_offenses(<<~RUBY)
      after_validation :foo, if: -> { bar }
    RUBY
  end
end
