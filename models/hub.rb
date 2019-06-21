# frozen_string_literal: true

class Hub < Sequel::Model
  Reducer = Rack::Reducer.new(
    self,
    lambda do |function:|
      where(Sequel.lit('? && function', Sequel.pg_array(function)))
    end,
    ->(name:) { where(Sequel.lit('name ilike ?', "%#{name}%")) },
    ->(country:) { where(country_id: country.upcase) },
    ->(page: 1, size: 10) { paginate(page, size) },
    ->(sort: :name) { order(sort.to_sym) },
    ->(direction:) { direction == 'desc' ? reverse : all },
  )

  def self.paginate(page, size)
    dataset.paginate(page, size)
  end
end
