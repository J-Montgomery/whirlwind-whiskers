import "CoreLibs/qrcode"
import "Menu"

class('GenericErrorScreen').extends(Menu)

function GenericErrorScreen:QRCallback(image, errorMsg)
    self.qr_code = image
    self.secondary_reason = errorMsg
end

function GenericErrorScreen:UpdateScreen()
    playdate.timer.updateTimers() 

    gfx.clear(gfx.kColorWhite)
    gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
    gfx.drawText("Unknown error occurred", 0, 0)

    local cause = string.format("Cause: %s", self.reason)
    gfx.drawText(reason, 26, 0)

    local secondary_cause = string.format("Cause: %s", self.secondary_reason)
    gfx.drawText(reason, 26, 0)

    return true
end

function GenericErrorScreen:SetErrorReason(reason)
    self.reason = reason
    self.secondary_reason = ""
    gfx.generateQrCode(self.reason, nil, self.QRCallback)
end
