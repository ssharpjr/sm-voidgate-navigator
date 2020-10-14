-- Starmourn Voidgate Navigator

function smvgn.echo(text)
	cecho("\n<white>[<goldenrod>SMVGN<white>]<white>: "..text)
end

function smvgn.getVoidgate(letter)
	if not smvgn.voidgates[letter:lower()] then
		smvgn.echo("Error calculating destination. Unknown voidgate letter of: "..letter..".")
	else
		return smvgn.voidgates[letter:lower()]
	end
end

function smvgn.createPath(from, to)
	local x, y = from:title(), to:title()
	if not smvgn.voidgate_destinations[x] then
		smvgn.echo("Error finding destination. Unknown takeoff gate: "..x..".")
	elseif not smvgn.voidgate_destinations[x][y] then
		smvgn.echo("Error finding destination. Not sure how to get to "..y.." from "..x..".")
	else
		smvgn.moveSequence = {}
    smvgn.echo("Calculating optimal route...")
		for _, warp in pairs(smvgn.voidgate_destinations[x][y]) do
			table.insert(smvgn.moveSequence, smvgn.getVoidgate(warp))
		end
		smvgn.echo("Optimal route from <cyan>"..x.." <white>to <cyan>"..y.." <white>is: ")
		cecho("\n  <LightSkyBlue>"..table.concat(smvgn.moveSequence, " -> ")..".")
		smvgn.echo("Total cost of travel is: <gold>"..(#smvgn.moveSequence * smvgn.ship_cost)..
                    " <white>marks (<cyan>"..#smvgn.moveSequence..
                    " <white>hops <goldenrod>X <cyan>"..smvgn.ship_cost.." <white>marks per hop).")
		smvgn.echo("Use <green>smvgn go <white>to travel this route.")
	end
end

function smvgn.activateWarp()
  for _, destination in pairs(smvgn.moveSequence) do
	send("ship gatewarp "..destination,false)
  end
  tempTimer(5, function() smvgn.echo("Auto-Navigation complete.") end)
  -- Clear db after warping
  tempTimer(10, function() smvgn.clear_moveSequence() end)
end

function smvgn.clear_moveSequence()
  smvgn.moveSequence = {}
  smvgn.echo("Calculated route cleared.")
end

function smvgn.help()
  smvgn.echo("Welcome to <goldenrod>SMVGN <white>- <cyan>Starmourn Voidgate Navigator <white>(for ships).")
  smvgn.echo("")
  smvgn.echo("Version: <cyan>"..smvgn.version)
  smvgn.echo("")
  smvgn.echo("This script will determine the best route between 2 voidgates for ship travel.")
  smvgn.echo("It will calculate the cost based on your current ship.")
  smvgn.echo("(Enter your ship cost in <goldenrod>Customizations <white>under <goldenrod>Scripts")
  smvgn.echo("")
  smvgn.echo("Usage: <green>smvgn <white><STARTING GATE> <DESTINATION GATE> <green>[go]")
  smvgn.echo("The <green>go <white>at the end is an optional argument to save a step.")
  smvgn.echo("If you omit it, you will be prompted the enter <green>smvgn go <white>to launch the sequence.")
  smvgn.echo("")
  smvgn.echo("Credit for the voidgate data and calculations goes to <yellow>Maruna <white>on the forums.")
  smvgn.echo("See <cyan>https://forums.starmourn.com/discussion/760/voidgates-for-lazy-people <white>for the original.")
  echo("\n\n")
end


