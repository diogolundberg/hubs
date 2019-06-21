# frozen_string_literal: true

class Application
  route('hubs') do |r|
    function = Dry.Types.Constructor(Array) { |s| Array.new(s.split('')) }
    schema = Dry::Schema.Params do
      optional(:function).filled(function)
      optional(:name).value(:string)
      optional(:country).value(:string)
      optional(:sort).filled(included_in?: Hub.columns.map(&:to_s))
      optional(:direction).value(:string)
      optional(:page).value(:integer, gt?: 0)
      optional(:size).value(:integer, gt?: 0)
    end

    r.get do
      params = schema.call(request.params)
      params.success? ? Hub::Reducer.apply(params.to_h) : params.errors.to_h
    end
  end
end
