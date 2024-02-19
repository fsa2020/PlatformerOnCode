# PlatformerOnCode Demo 
A platformer demo which use 'code blocks' platform , including : 
1. Level generation by python file.
2. Character control ;trap system (spring, trigger, pry ... ) enabled player to pause time and place the trap .
3. Building transforms by 'code blocks'. 
4. Easy plot dialog ;
5. Simple user record saving.

# Generate platform by codes
1. Edit level you want in c++ codes like : platformer_floor\codeFloor\floor0.cpp
2. Change level id in py code
3. Run lexer.py to generate json file

# Create trap Example
set traps in few codes 

Extends Trap
```GDScript
extends Trap
class_name TrapSpring
```
Override functions
```GDScript
func onTargetEnter(target):
	if (target.velocity.y<-200):
        return
	Events.playEffectSound.emit("Bubble heavy 1.wav")

	# label animation
	label.position = Vector2(0,0)
	var up = Actions.MoveBy.new(Vector2(0,-20),0.05).easeOutCirc()
	var down = Actions.MoveBy.new(Vector2(0,20),0.1).easeInCirc()
	Actions.Seq.new([up,down]).run(label)

	# target velocity
	target.velocity = Vector2(0,-500)
	
```

# Set Trap Example
set traps in trap cfg (todo: create in no auto load files)
```GDScript
var levels = {
	"lv0" = [
		{
			"pos" = {
				line = 80,
				count = 65,
			},

			"trap" = TrapPlot.new("lv0guide1")
		},
		{
			"pos" = {
				line = 78,
				count = 1,
			},
			"trap" = TrapSpring.new()
		}
    ]
}
```

# Preview
'Code blocks' platform and trap system
<p align='center'>
<img src='previews\PlatformerDemoPreview1.png' title='images' style='max-width:600px'></img>
</p>
Plot dialog 
<p align='center'>
<img src='previews\PlatformerDemoPreview2.png' title='images' style='max-width:600px'></img>
</p>
Building transforms by 'code blocks'
<p align='center'>
<img src='previews\PlatformerDemoPreview3.png' title='images' style='max-width:600px'></img>
</p>