using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Random }
using { /Fortnite.com/Characters }

RewardModded := class<concrete><public>:
    # Get our devices that we can assign in the UEFN Editor
    @editable ItemGranterModded<public> : item_granter_device = item_granter_device{} # The Item Granters that one of which will be randomly chosen | Can be used to grant items (Leave empty to grant nothing when this granter is chosen)                                                                                        #Hi 👋😀
    @editable HUDMessageModded<public> : hud_message_device = hud_message_device{} # The Hud Message Device that one of which will be randomly chosen | Can be used to show messages on screen (Example: You found an Acorn!)
    @editable MessageFeedModded<public> : elimination_feed_device = elimination_feed_device{} # The Elimination Feed Device that one of which will be randomly chosen | Can be used to activate messages in the Kill Feed :P
    @editable TriggerModded<public> : trigger_device = trigger_device{} # Adds an Trigger that you can link to whatever you want, I won't judge :D
    
 
    
    #Variables
    @editable DebugMessageModded : string = "Hello World" 
    @editable DebugModeModded : logic = false # Can be used for debugging i guess




SearchableObjectManagerModded := class(creative_device): # Makes it a Creative Device... 
    #Get our arrays :)
    @editable Rewards : []Reward = array{} # Makes it so you can add more Reward Classes in the Editor
    @editable Button : conditional_button_device = conditional_button_device{} # Choose the BUTTON devices that you can use to activate the GrantItem function (Can be assigned in the editor) 
    @editable SFXOpen<public> : audio_player_device = audio_player_device{}
    @editable HUDMessageMysteryBox<public> : hud_message_device = hud_message_device{}
    @editable VFX1<public> : vfx_spawner_device = vfx_spawner_device{}
    @editable VFX2<public> : vfx_spawner_device = vfx_spawner_device{}
    @editable MysteryBoxAnimation<public>: cinematic_sequence_device = cinematic_sequence_device{}
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void= # Activates when the game starts
       
        Button.ActivatedEvent.Subscribe(GrantItem) # Activates the GrantItem when the button is pressed
            
            
    GrantItem(Agent : agent) :void = # Activates when a button is pressed
        SFXPlaySound()
        VFX1.Enable()
        VFX2.Enable()
        MysteryBoxAnimation.Play()
        @editable RandomNumber := GetRandomInt(0, 11) # Generates an random number between 0 and the amount Indexes your array has (-1 at the end since it starts counting at 1 but we want to start at 0)
            #Print("RANDOM NUMBER  AVANT IF: {RandomNumber}")

        if (TheRewardModded := Rewards[RandomNumber - 1]):  # Chooses the Index that was generated on the previous line
          
           
            #Print("RANDOM NUMBER  : {RandomNumber}")
            #Print("RANDOM NUMBER-INDEXCHOOSEN {RandomNumber - 1}")

            spawn:
                Ptitdelay(TheRewardModded, Agent)
            
            #TheReward.HUDMessage.Show(Agent) # Shows the Hud Message
            HUDMessageMysteryBox.Show(Agent)
            TheRewardModded.MessageFeed.Activate(Agent) # Shows the message in the kill feed
            TheRewardModded.Trigger.Trigger(Agent) 
            
    Ptitdelay(TheRewardModded : Reward, Agent : agent)<suspends>:void=
        #Print("Ptitdelay triggered for 3sec")
        Sleep(6.0)
        TheRewardModded.ItemGranter.GrantItem(Agent) # Grants the Item
        VFX1.Disable()
        VFX2.Disable()
        Button.Enable()
        #Print("Ptitdelay over")

    SFXPlaySound():void=
        SFXOpen.Play()
            


