local M = {}

-- See if the file exists.
function M.file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- Get all lines from a file.
function M.lines_from(file)
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

-- Parse all lines and create a map.
function M.get_tab(lines)
  local tab = {}

  for _, str in pairs(lines) do
    local separated = {}

    for v in str:gmatch "[^%=]+" do
      table.insert(separated, v)
    end

    -- TODO: check if separated is len 2
    tab[separated[1]] = separated[2]
  end
  return tab
end

return M
