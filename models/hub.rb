# frozen_string_literal: true

class Hub < Sequel::Model
  Reducer = Rack::Reducer.new(
    self,
    ->(name:) { where('name ilike ?', "%#{name}%") },
    ->(country:) { where(country_id: country.upcase) },
    ->(function:) { where('? && function', function.pg_array) },
    ->(page: 1, size: 10) { paginate(page, size) },
    ->(sort: :name) { order(sort.to_sym) },
    ->(direction:) { direction == 'desc' ? reverse : all },
  )

  def self.paginate(page, size)
    dataset.paginate(page, size)
  end
end
