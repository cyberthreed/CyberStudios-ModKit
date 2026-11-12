--  -- B1 Main (presentation layer script)
-- Runs on the game thread. Use for visual/camera/FX/animation customization.
-- B1 cannot access simulation data directly; use inzoi.message to talk to B2.

local M = {}

function M.on_begin()
    print("[] B1 Main initialized")
end

function M.on_end()
    print("[] B1 Main shutdown")
end

return M