# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:hubs_raw) do
      String :change
      String :country
      String :location
      String :name
      String :namewodiacritics
      String :subdivision
      String :function
      String :status
      String :date
      String :iata
      String :coordinates
      String :remarks
    end
  end
end
