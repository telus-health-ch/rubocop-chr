# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Flag::FeatureFlagName, :config do
  let(:config) { RuboCop::Config.new }

  it 'registers an offense when using an invalid feature flag name' do
    # An error occurred while CustomCops/FeatureFlagName cop was
    # inspecting /Users/rafaelrocha/src/telus/chr-backend/app/models/
    # respondent/searchable_value.rb:32:11
    expect_offense(<<~RUBY)
      if FeatureFlag.enabled? 'SEARCH_MY_FLAG_ID'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use snake_case with lowercase for feature flag names.
      end
    RUBY
  end

  it 'registers no offense when using a valid feature flag name' do
    expect_no_offenses(<<~RUBY)
      if FeatureFlag.enabled? 'search_my_flag_id'
      end
    RUBY
  end
end
