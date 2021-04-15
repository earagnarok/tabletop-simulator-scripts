function onLoad(script_state)
    state = JSON.decode(script_state)

    if (state == nil) then
      state = {
        position = {},
        player = {},
        saved = false
      }
    end

    if (state.saved == true) then
      self.addContextMenuItem("Reveal position", moveToPosition)
    else
      self.addContextMenuItem("Save position", savePosition)
    end
end

function savePosition(color)
  state.position = self.getPosition()
  state.player = color
  state.saved = true

  self.clearContextMenu()
  self.addContextMenuItem("Reveal position", moveToPosition)
end

function moveToPosition(color)
  if (state.player == color) then
    self.setPositionSmooth(state.position, false, false)

    state.position = {}
    state.player = {}
    state.saved = false

    self.clearContextMenu()
    self.addContextMenuItem("Save position", savePosition)
  else
    broadcastToAll("Only " .. state.player .. " player can reveal saved position!", {r=1, g=0, b=0})
  end
end

function onSave()
  return JSON.encode(state)
end
