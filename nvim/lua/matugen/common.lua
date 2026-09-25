local M = {}

function M.load_matugen_colors()
    local path = vim.fs.normalize("~/.cache/matugen_outputs/neovim.json")

    local fd = vim.uv.fs_open(path, "r", 438)
    if not fd then
        return {}
    end

    local stat = vim.uv.fs_fstat(fd)
    local content = vim.uv.fs_read(fd, stat.size, 0)
    vim.uv.fs_close(fd)

    local ok, colors = pcall(vim.json.decode, content)

    if not ok then
        vim.notify(
            "Invalid Matugen JSON: " .. tostring(colors),
            vim.log.levels.ERROR
        )
        return {}
    end

    return colors
end

local function parse_hex(hex)
    if type(hex) ~= "string" then
        return nil
    end
    hex = hex:gsub("^#", "")
    if #hex ~= 6 then
        return nil
    end
    return {
        tonumber(hex:sub(1, 2), 16),
        tonumber(hex:sub(3, 4), 16),
        tonumber(hex:sub(5, 6), 16),
    }
end

--- Blend two hex colors. `amount` is the weight of `hex2` (0 = pure hex1, 1 = pure hex2).
---@param hex1 string
---@param hex2 string
---@param amount number
---@return string
function M.blend(hex1, hex2, amount)
    local a, b = parse_hex(hex1), parse_hex(hex2)
    if not a or not b then
        return hex1 or hex2 or "#000000"
    end
    amount = amount or 0.5
    local function channel(i)
        return math.floor(a[i] * (1 - amount) + b[i] * amount + 0.5)
    end
    return string.format("#%02x%02x%02x", channel(1), channel(2), channel(3))
end

return M
