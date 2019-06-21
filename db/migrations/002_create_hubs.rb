# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:hubs) do
      String :country_id
      String :location
      String :name
      column :function, 'text[]'
      String :coordinates
    end
  end
end
