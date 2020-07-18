# frozen_string_literal: true

Sequel.migration do
  change do
    run <<~SQL
      UPDATE hubs_raw SET coordinates = '4427N 06425W' WHERE country = 'CA' AND location = 'BHH';
      UPDATE hubs_raw SET coordinates = '4312N 08006W' WHERE country = 'CA' AND location = 'JSS';
      UPDATE hubs_raw SET coordinates = '2444N 05045E' WHERE country = 'SA' AND location = 'SAL';
    SQL
  end
end
