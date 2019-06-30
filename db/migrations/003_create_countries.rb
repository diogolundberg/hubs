# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:countries) do
      String :id
      String :name
    end
  end
end
