# frozen_string_literal: true

class Application
  route('functions') do |r|
    r.get { Function.all }
  end
end
