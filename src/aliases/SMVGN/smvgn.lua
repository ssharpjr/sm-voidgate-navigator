-- Alias:
-- Name: smvgn
-- Pattern: ^smvgn\s?(\w+)?\s?(\w+)?\s?(\w+)?

if not matches[2] then
    smvgn.echo("Usage: <green>smvgn <START GATE> <DESTINATION GATE> [go]")
    smvgn.echo("Use <green>voidgate<white> to see all voidgates.")
  elseif matches[2] == "go" then
    smvgn.activateWarp()
  elseif matches[2] == "clear" then
    smvgn.clear_moveSequence()
  elseif matches[2] == "help" then
    smvgn.help()
  else
    smvgn.createPath(matches[2], matches[3])
    if matches[4] then
      if matches[4] == "go" then
        smvgn.activateWarp()
      end
    end
  end