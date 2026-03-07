extends lock
var waits = {1:true,2:true,3:true,4:true,5:true,6:true,7:true,8:true,9:true}
var buts = {1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0}
var checks = {0:{1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0},1:{1:1,2:0,3:0,4:0,5:1,6:0,7:0,8:0,9:1},2:{1:1,2:0,3:1,4:0,5:1,6:0,7:1,8:0,9:1}}
var rand = randi()%4
var timer = 0

func spec() -> void:
	if timer == 9:
		timer = 0
		g.tick.emit()
	if not locked:
		timer = 0
		rand = randi()%3
		buts = {1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0}
	but1()
	num = 4
	but2()
	but3()
	but4()
	but5()
	but6()
	but7()
	but8()
	but9()
	var check = true
	for i in buts:
		if buts[i]%2 == checks[rand][i]%2:
			check = false
	if check == true:
		unlock()
	if buts[1]%2:
		$but1.modulate = Color(0.0, 0.0, 18.892, 1.0)
	else:
		$but1.modulate = Color(0.013, 0.006, 0.0, 1.0)
	if buts[2]%2:
		$but2.modulate = Color(0.0, 0.0, 18.892, 1.0)
	else:
		$but2.modulate = Color(0.013, 0.006, 0.0, 1.0)
	if buts[3]%2:
		$but3.modulate = Color(0.0, 0.0, 18.892, 1.0)
	else:
		$but3.modulate = Color(0.013, 0.006, 0.0, 1.0)
	if buts[4]%2:
		$but4.modulate = Color(0.0, 0.0, 18.892, 1.0)
	else:
		$but4.modulate = Color(0.013, 0.006, 0.0, 1.0)
	if buts[5]%2:
		$but5.modulate = Color(0.0, 0.0, 18.892, 1.0)
	else:
		$but5.modulate = Color(0.013, 0.006, 0.0, 1.0)
	if buts[6]%2:
		$but6.modulate = Color(0.0, 0.0, 18.892, 1.0)
	else:
		$but6.modulate = Color(0.013, 0.006, 0.0, 1.0)
	if buts[7]%2:
		$but7.modulate = Color(0.0, 0.0, 18.892, 1.0)
	else:
		$but7.modulate = Color(0.013, 0.006, 0.0, 1.0)
	if buts[8]%2:
		$but8.modulate = Color(0.0, 0.0, 18.892, 1.0)
	else:
		$but8.modulate = Color(0.013, 0.006, 0.0, 1.0)
	if buts[9]%2:
		$but9.modulate = Color(0.0, 0.0, 18.892, 1.0)
	else:
		$but9.modulate = Color(0.013, 0.006, 0.0, 1.0)

func but1():
	if waits[1]:
		waits[1] = false
		await $but1.pressed
		buts[2] += 1
		buts[4] += 1
		buts[1] += 1
		waits[1] = true
		timer +=1

func but2():
	if waits[2]:
		waits[2] = false
		await $but2.pressed
		buts[1] += 1
		buts[3] += 1
		buts[5] += 1
		buts[2] += 1
		waits[2] = true
		timer +=1

func but3():
	if waits[3]:
		waits[3] = false
		await $but3.pressed
		buts[2] += 1
		buts[3] += 1
		buts[6] += 1
		waits[3] = true
		timer +=1

func but4():
	if waits[4]:
		waits[4] = false
		await $but4.pressed
		buts[1] += 1
		buts[4] += 1
		buts[5] += 1
		buts[7] += 1
		waits[4] = true
		timer +=1

func but5():
	if waits[5]:
		waits[5] = false
		await $but5.pressed
		buts[2] += 1
		buts[4] += 1
		buts[5] += 1
		buts[6] += 1
		buts[8] += 1
		waits[5] = true
		timer +=1

func but6():
	if waits[6]:
		waits[6] = false
		await $but6.pressed
		buts[3] += 1
		buts[6] += 1
		buts[5] += 1
		buts[9] += 1
		waits[6] = true
		timer +=1

func but7():
	if waits[7]:
		waits[7] = false
		await $but7.pressed
		buts[8] += 1
		buts[7] += 1
		buts[4] += 1
		waits[7] = true
		timer +=1

func but8():
	if waits[8]:
		waits[8] = false
		await $but8.pressed
		buts[7] += 1
		buts[8] += 1
		buts[9] += 1
		buts[5] += 1
		waits[8] = true
		timer +=1

func but9():
	if waits[9]:
		waits[9] = false
		await $but9.pressed
		buts[8] += 1
		buts[9] += 1
		buts[6] += 1
		waits[9] = true
		timer +=1
