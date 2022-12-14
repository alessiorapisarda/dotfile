local leap_status_ok, leap = pcall(require, "leap")
if not leap_status_ok then
    return
end

local flit_status_ok, flit = pcall(require, "flit")
if not flit_status_ok then
    return
end

leap.add_default_mappings()
flit.setup()
