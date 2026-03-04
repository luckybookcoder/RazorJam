extends robot
var text = []

func _process(delta: float) -> void:
	buggy = true
	text = moves.duplicate_deep()
	for i in text.size():
		if text[i] is Vector2:
			while abs(text[i].x) >= 64:
				text[i].x /= 2
			while abs(text[i].y) >= 64:
				text[i].y /= 2
	if g.focus == $".":
		print(text)
		g.text = text
	lastmove = Vector2.ZERO
		

func move():
	for i in moves.size():
		if abs(moves[i].x) < 64 and abs(moves[i].y) < 64:
			moves[i] *= Vector2(2,2)
	if not moving:
		moving = true
		g.newposses.clear()
		if g.longest < moves.size():
			g.longest += moves.size()
		use = moves
		collision_layer = 1
		for i in 999:
			await g.tick
			pointer +=1
			collision_layer = 3
			if use.size() <= i:
				moving = false
				pointer = 0
				moves.clear()
				return
			if use.get(i) is Vector2:
				await get_tree().physics_frame
				if g.playerpos == &"door":
					if not g.newposses.count(position+use.get(i)) > 1:
						lastmove = use.get(i)
						
						if move_and_collide(use.get(i), true):
							@warning_ignore("integer_division")
							if move_and_collide(use.get(i)/Vector2(2,2), true).get_collider():
								pass
							else:
								g.newposses.append(position+use.get(i)/Vector2(2,2))
								move_and_collide(use.get(i)/2)
						else:
							move_and_collide(use.get(i))
						g.newposses.clear()
				else:
					for x in i+1:
						use.pop_front()
					moves = use.duplicate_deep()
					moving = false
					pointer = 0
					return
			else:
				g.newposses.append(position)
				lastmove = Vector2.ZERO
				if use.get(i) == &"pickup":
					if area.get_overlapping_areas():
						var lastitem = currentitem
						currentitem = area.get_overlapping_areas().front.get_parent()
						g.itemposses[currentitem] = "held"
						if lastitem:
							g.itemposses[lastitem] = position
				elif use.get(i) == &"putdown":
					if currentitem:
						g.itemposses[currentitem] = position
						currentitem = 0
		for i in 99:
			g.newposses.append(position)
			await g.tick
			if g.playerpos != &"door":
				moving = false
				pointer = 0
				return
			if i > 0:
				lastmove =Vector2.ZERO
			g.newposses.clear()
