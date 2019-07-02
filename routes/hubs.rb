# frozen_string_literal: true

class Application
  route('hubs') do |r|
    schema = Dry::Schema.Params do
      optional(:name).value(:string)
      optional(:country).value(:string)
      optional(:function).array(:string)
      optional(:page).filled(:integer, gt?: 0)
      optional(:size).filled(:integer, gt?: 0)
      optional(:sort).filled(included_in?: Hub.columns.map(&:to_s))
      optional(:direction).filled(included_in?: %w[asc desc])
    end

    r.get do
      params = schema.call(request.params)
      r.halt(422, params.errors.to_h) unless params.success?
      Hub::Reducer.apply(params.to_h)
    end
  end
end
