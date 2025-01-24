# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Rails7::CustomToSWithArgument, :config do
  let(:config) { RuboCop::Config.new }

  it 'does not register ofenses when using to_s with the other arguments' do
    expect_no_offenses(<<~RUBY)
      DateTime.current.to_s(:other)
    RUBY
  end

  it 'registers an offense when using to_s with the non allowed arguments' do
    expect_offense(<<~RUBY)
      DateTime.current.to_s(:db)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `to_fs` instead.
    RUBY

    expect_offense(<<~RUBY)
      DateTime.current.to_s(:full)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `to_fs` instead.
    RUBY

    expect_offense(<<~RUBY)
      DateTime.current.to_s(:h_mm_a)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `to_fs` instead.
    RUBY

    expect_offense(<<~RUBY)
      DateTime.current.to_s(:HH_mm)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `to_fs` instead.
    RUBY

    expect_offense(<<~RUBY)
      DateTime.current.to_s(:iso8601)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `to_fs` instead.
    RUBY

    expect_offense(<<~RUBY)
      DateTime.current.to_s(:nsec)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `to_fs` instead.
    RUBY

    expect_offense(<<~RUBY)
      DateTime.current.to_s(:short)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `to_fs` instead.
    RUBY

    expect_offense(<<~RUBY)
      DateTime.current.to_s(:yyyy_mm_dd)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `to_fs` instead.
    RUBY

    expect_offense(<<~RUBY)
      DateTime.current.to_s(:YYYY_MM_DD)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `to_fs` instead.
    RUBY

    expect_offense(<<~RUBY)
      DateTime.current.to_s(:yyyy_mm_dd_HH_mm)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `to_fs` instead.
    RUBY

    expect_offense(<<~RUBY)
      DateTime.current.to_s(:yyyymmdd)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `to_fs` instead.
    RUBY
  end
end
