# frozen_string_literal: true

# config/initializers/ransack.rb
Ransack.configure do |config|
  config.add_predicate 'from_month', arel_predicate: 'eq',
                                     formatter: proc { |v| v.month },
                                     validator: proc { |v| v.present? },
                                     type: :integer

  # config.add_predicate 'until_day', :arel_predicate => 'lteq',
  #                                   :formatter => proc { |v| v.to_date.end_of_day },
  #                                   :validator => proc { |v| v.present? },
  #                                   :type => :string
end
