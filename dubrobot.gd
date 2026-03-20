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
		g.text = text
	lastmove = Vector2.ZERO
		

func move():
	for i in moves.size():
		if moves[i] is Vector2:
			if abs(moves[i].x) < 64 and abs(moves[i].y) < 64:
				moves[i] *= Vector2(2,2)
		else:
			print(moves[i])
	if not moving:
		moving = true
		g.newposses.clear()
		if g.longest < moves.size():
			g.longest = moves.size()
		use = moves
		collision_layer = 1
		for i in 999:
			await g.tick
			collision_layer = 3
			if use.size() <= pointer+1:
				moving = false
				print("BBBBBBBBBBB")
				pointer = -1
				moves.clear()
				return
			pointer +=1
			if use.get(pointer) is Vector2:
				g.newposses.append(position+use.get(pointer))
				await get_tree().physics_frame
				if g.playerpos == &"door":
					if not g.newposses.count(position+use.get(pointer)) > 1:
						lastmove = use.get(pointer)
						
						if move_and_collide(use.get(pointer), true):
							@warning_ignore("integer_division")
							if move_and_collide(use.get(pointer)/Vector2(2,2), true):
								pass
							else:
								g.newposses.append(position+use.get(pointer)/Vector2(2,2))
								print("aaaaaaa")
								move_and_collide(use.get(pointer)/2)
						else:
							move_and_collide(use.get(i))
						g.newposses.clear()
				else:
					for x in use.size()-pointer:
						use.pop_front()
					moves = use.duplicate_deep()
					moving = false
					pointer = -1
					print("bbbbbbb")
					return
			else:
				g.newposses.append(position)
				lastmove = Vector2.ZERO
				if use.get(pointer) == &"pickup":
					if area.get_overlapping_areas():
						var lastitem = currentitem
						currentitem = area.get_overlapping_areas().front().get_parent()
						g.itemposses[currentitem] = "held"
						if lastitem:
							g.itemposses[lastitem] = position
				elif use.get(pointer) == &"putdown":
					if currentitem:
						g.itemposses[currentitem] = position
						currentitem = 0
		for i in 99:
			g.newposses.append(position)
			await g.tick
			if g.playerpos != &"door":
				moving = false
				pointer = 0
				print("CCCCCCC")
				return
			if i > 0:
				lastmove =Vector2.ZERO
			g.newposses.clear()
