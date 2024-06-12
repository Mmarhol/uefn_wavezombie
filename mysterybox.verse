using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Random }
using { /Fortnite.com/Characters }

Reward := class<concrete><public>:
    # Get our devices that we can assign in the UEFN Editor
    @editable ItemGranter<public> : item_granter_device = item_granter_device{} # The Item Granters that one of which will be randomly chosen | Can be used to grant items (Leave empty to grant nothing when this granter is chosen)                                                                                        #Hi 👋😀
    @editable HUDMessage<public> : hud_message_device = hud_message_device{} # The Hud Message Device that one of which will be randomly chosen | Can be used to show messages on screen (Example: You found an Acorn!)
    @editable MessageFeed<public> : elimination_feed_device = elimination_feed_device{} # The Elimination Feed Device that one of which will be randomly chosen | Can be used to activate messages in the Kill Feed :P
    @editable Trigger<public> : trigger_device = trigger_device{} # Adds an Trigger that you can link to whatever you want, I won't judge :D
    
    
    #Variables
    @editable DebugMessage : string = "Hello World" 
    @editable DebugMode : logic = false # Can be used for debugging i guess

    GrantReward(Agent:agent):void=
        ItemGranter.GrantItem(Agent)  
        HUDMessage.Show(Agent) 
        MessageFeed.Activate(Agent) 
        Trigger.Trigger(Agent) 
        if (DebugMode?):
            Print("{DebugMessage}")


SearchableObjectManager := class(creative_device): # Makes it a Creative Device... 
    #Get our arrays :)
    @editable Rewards : []Reward = array{} # Makes it so you can add more Reward Classes in the Editor
    @editable Buttons : []conditional_button_device = array{} # Choose the BUTTON devices that you can use to activate the GrantItem function (Can be assigned in the editor) 
    

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void= # Activates when the game starts
        for (Objects : Buttons): # I honestly have no idea why this has to be here but it doesn't work without it (Try removing it and you can see an error (Use Ctrl+Z to reverse it if you try))
            Objects.ActivatedEvent.Subscribe(GrantItem) # Activates the GrantItem when the button is pressed
            
            
    GrantItem(Agent : agent) :void = # Activates when a button is pressed
        @editable RandomNumber := GetRandomInt(0, 11) # Generates an random number between 0 and the amount Indexes your array has (-1 at the end since it starts counting at 1 but we want to start at 0)
            Print("RANDOM NUMBER  AVANT IF: {RandomNumber}")

        if (TheReward := Rewards[RandomNumber - 1]):  # Chooses the Index that was generated on the previous line
          
           
            Print("RANDOM NUMBER  : {RandomNumber}")
            Print("RANDOM NUMBER-INDEXCHOOSEN {RandomNumber - 1}")

            spawn:
                Ptitdelay()
            TheReward.ItemGranter.GrantItem(Agent) # Grants the Item
            TheReward.HUDMessage.Show(Agent) # Shows the Hud Message
            TheReward.MessageFeed.Activate(Agent) # Shows the message in the kill feed
            TheReward.Trigger.Trigger(Agent) 

    Ptitdelay()<suspends>:void=
        Print("Ptitdelay triggered for 3sec")
        Sleep(3.0)
        Print("Ptitdelay over")







    RotationDeLaBox():void=
        AllPlayers := GetPlayspace().GetPlayers()
        if (Player : player = AllPlayers[0]):
            if (FNCharacter : fort_character = Player.GetFortCharacter[]):
                FNCharacter.GetViewRotation()
                FNCharacter.GetTransform()