# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:functions) do
      String :id
      String :name
    end
  end
end
