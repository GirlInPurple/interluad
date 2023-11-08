--[[ 

This file is to test if certain features of Bloxel's computer system are working correctly.

The save-load system is now working,
ports are not.

]]

local saved = {}

function save(name, value)
  saved[name] = value
end

function load(name)
  return saved[name]
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end