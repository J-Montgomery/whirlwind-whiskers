import "Menu"

class('GenericErrorScreen').extends(Menu)

local reason = "Unknown Error"
local secondary_reason = "Not Found"

function GenericErrorScreen:UpdateScreen()
    gfx.clear(gfx.kColorWhite)
    gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
    gfx.drawText("Unknown error occurred", 0, 0)

    local cause = string.format("Cause: %s", reason)
    gfx.drawText(cause, 0, 20)

    local secondary_cause = string.format("Debugging Aid: %s", secondary_reason)
    gfx.drawText(secondary_cause, 0, 40)

    return true
end

function GenericErrorScreen:SetErrorReason(reasonMsg)
    reason = reasonMsg
    secondary_reason = ""
end
