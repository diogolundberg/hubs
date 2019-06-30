# frozen_string_literal: true

class Application
  route('countries') do |r|
    r.get { Country.all }
  end
end
