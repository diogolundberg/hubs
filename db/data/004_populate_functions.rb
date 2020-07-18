# frozen_string_literal: true

Sequel.migration do
  up do
    functions = [
    ['0', 'Function not known, to be specified'],
    ['1', 'Port, as defined in Rec 16'],
    ['2', 'Rail Terminal'],
    ['3', 'Road Terminal'],
    ['4', 'Airport'],
    ['5', 'Postal Exchange Office'],
    ['6', 'Multimodal Functions (ICDs, etc'],
    ['7', 'Fixed Transport Functions (e.g. Oil platform'],
    ['8', 'Inland Port'],
    ['B', 'Border Crossing'],
    ]

    DB[:functions].import(%i[id name], functions)
  end

  down { DB[:functions].truncate }
end
