extends Node

var main_index :int = 0
var sub_index :int =0

var corner_index: int = 3

#var mound_index: int = 4
#var clearing_index:int = 4

var teach_index: int = 4
var taka_index: int = 5

var orb_index: int = 6

var dad_gone_index: int = 7

var leave_clearing_index: int = 8

var night_path_index: int = 9

var fork_index: int = 13

var animal_stick_index: int = 15

var stick_worked_index: int = 16

var cave_animal_index: int = 17

var dad_not_working_index: int = 18
var hungry_index: int = 19

var energy_bisucit_index: int = 20


var not_quit_index: int = 21

var all_narration = [
	["My dad was the only one who called me Saif instead of Saiful."],
	["My dad always liked to take me on long walks through the forest...", "but that day we went further than we had ever been before."],
	["I remembered feeling excited and wondering if he had something special planned."],
	["For a second I panicked when I lost sight of my dad."],
	["Dad always liked to teach me something when we went walking."],
	["I suddenly realised I lost the 10 Taka note my dad gave me...", "I had to find it, otherwise he would be really upset."],
	["While I was looking around, I saw something glowing...", "I wanted to show dad what I had found."],
	["Dad was gone. I looked around frantically but he was nowhere to be seen...", "I had to find him."],
	["At the time, I felt I had to follow that glowing light."],
	["It started to get dark."],
	["I'd never been out in the forest this late before."],
	["I remember being just as worried about my lost money as I was about being lost myself."],
	["My dad was a fisherman but he hadn't been working much lately."],
	["I came to a fork in the road and had to make a choice..."],
	["Follow the glowing light, or follow my dad's voice?"],
	["I heared footsteps. Then I rememberd a trick my dad had taught me...", "Throw a stick into the forest as a distraction."],
	["It worked!"],
	["I heard footsteps. I needed to find a place to hide."],
	["With my dad not working we didn't always get much to eat."],
	["After walking so far, I was very hungry."],
	["Energy biscuits! I was hungry but these were not mine? I wasn't sure what to do."],
	
	["I had no idea where I was but I wasn't giving up...", "The fear was leaving me I was more determined than ever...", "That day in the forest changed me."],
	["I never found out what happened to my dad in the forest that day. And now I never will. 
	He passed away yesterday just a few hours after I spoke to him on the phone. It had been a short converation but his final words will haunt me forever. 'Saif, come home' "]	
]

var book_text_en = {
	"voice": "Every night I hear her voice calling my name. I know it can't be her but what if it is?\n\nWhat if she is still out there and is calling for help.",
	"nishi": "Beware the call of the Nishir Daak, it cannot be trusted.",
	"gone": "I only went out for a few minutes and when I came back she was gone. That was two weeks ago.",
	"nishi2": "The Nishir Daak: an evil entity that will lure you to your death.\n\nListen carefully for your ears may deceive you.",
	"aleya":"I spoke to some other fishermen. They told me about the lights.\n\nThey said they were called Aleya and that they were not to be trusted. I don’t know what to believe now.",
	"found":"I haven’t found him yet but I must be getting close. He was always talking about flying lights but I didn’t believe him.\n\nI thought it was just a young child’s imagination but last night I saw one of them for myself. It tried to get closer but it sped away.\n\nTonight I will be quicker. I know he must have followed it.\n\nI believe the light will take me back to my son.",
	"buzz_house": "It's very risky to go out at night.\n\nThe buzzing cloud is attracted to light so I have to go slowly.",
	"buzz_cave": "The exit is haunted by a buzzing, black cloud.\n\nIt seems to like the light which makes taking the tunnel risky."
}

var book_text_bn = {
	"voice": "
প্রতি রাতে আমার নাম ডাকার আওয়াজ শুনতে পাই. আমি জানি এটা সে হতে পারে না কিন্তু যদি হয়? যদি সে এখনো কোথাও আছে এবং আমার সাহায্য চাচ্ছে?",
"nishi": "নিশির ডাকের সাবধান, একে বিশ্বাস করা যায় না।",
"gone":"আমি কিছুক্ষনের জন্য বাইরে গিয়েছিলাম, যখন ফিরে আসি তখন দেখি সে নেই। সেটা দুই সপ্তাহ আগের ঘটনা।",
"nishi2":"নিশির ডাক : একটি দুষ্ট আত্মা যা তোমাকে প্রতারিত করে মৃত্যুর দিকে টেনে নিবে।",
"aleya":"আমি আরও কয়েকজন জেলেদের সঙ্গে কথা বলেছি। তারা আমাকে ভাসমান আলোর কথা বলেছে।\n\nএগুলোকে নাকি আলেয়া বলা হয় এবং এদের বিশ্বাস করা যায় না। আমি এখন কি বিশ্বাস করব জানি না।",
"found":"আমি এখনও তাকে খুঁজে পাইনি তবে কাছে যাচ্ছি। সে সর্বদা উড়ন্ত আলোর কথা বলছিলো কিন্তু আমি তাকে বিশ্বাস করিনি।\n\nআমি ভেবেছিলাম এটি কেবল ছোট শিশুর কল্পনা কিন্তু গতরাতে আমি একটি নিজের চোখে দেখেছি। আমি কাছে যাওয়ার চেষ্টা করলেও দ্রুত সরে যায়। আজ রাতে আমি দ্রুত হবে.\n\nআমি জানি সে  অবশ্যই এটির অনুসরণ করেছে।\n\nআমি বিশ্বাস করি এই আলো আমাকে আমার ছেলের কাছে ফিরিয়ে নিয়ে যাবে।",
"buzz_house": "রাতে বাইরে বের হওয়া খুবই ঝুঁকিপূর্ণ।\n\nগুঞ্জনরত মেঘটি আলোর প্রতি আকৃষ্ট হয়, তাই আমাকে ধীরে ধীরে যেতে হবে।",
"buzz_cave": "বের হওয়ার রাস্তা গুঞ্জনরত মেঘের আস্তানা। এটি আলো পছন্দ করে না যা সুড়ঙ্গ পথে যাওয়া ঝুঁকিপূর্ণ করে তোলে। "
}

var languages = {
	"en": book_text_en,
	"bn": book_text_bn
}

func narrate():
	if main_index < all_narration.size():
		if sub_index < all_narration[main_index].size():
			print ("Read current main index "+str(main_index))
			GlobalSignals.emit_signal("show_narration", all_narration[main_index][sub_index])
			sub_index += 1
			
		else:
			#main_index += 1
			sub_index = 0
			print ("Read next main index "+str(main_index))
			GlobalSignals.emit_signal("show_narration", all_narration[main_index][sub_index])
			sub_index += 1
	else:
		GlobalSignals.emit_signal("show_narration", "NARATION COMPLETE")
		 
func hide_narration():
	if sub_index == all_narration[main_index].size():
		#main_index += 1
		sub_index = 0
		print (" HN main "+str(main_index)+" sub "+str(sub_index))
	else:
		narrate()
		


		
