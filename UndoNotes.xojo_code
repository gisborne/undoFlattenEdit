#tag Module
Protected Module UndoNotes
	#tag Note, Name = About the Undo framework
		Undo: Control Instrumentation
		Any user interface element that is to support Undo/Redo must be "instrumented". This means it must
		convert all significant user interface actions into some UndoAction subclass, which is sent to the current
		UndoQueue.
		
		Any such class should probably also support the TextEntryObject Class Interface. This abstracts the external
		interface necessary for Undo support from an EditField, and is likely to be required for any other UI class
		that supports undo/redo. In particular, this Class Interface abstracts the access the UndoAction subclasses
		require in order to actually perform the undo and redo state modifications.
		The Undo Framework is intended to be a "deluxe" undo framework. It provides the following features:
		- multiple undo/redo
		- easily configurable "collapsing" of multiple user interface events into one undoable action (eg multiple
		sequential KeyDown events can be treated as one "typingAction" that is undone in one block);
		- undo actions can provide verbose descriptions of what they will do, to support descriptive undo menu
		options ("Undo Typing", "Undo Delete" etc)
		
	#tag EndNote

	#tag Note, Name = How to implement undo in your application
		Undo is a subtle thing, and will need to work differently in different applications. For example, in a database user interface,
		you will probably want to forbid Undo past saving a record (but maybe not). In a multi-window application, you might want
		separate undo buffers for each window (as in this application), or maybe a global undo buffer.
		
		So the framework is written with such details separate.
		
		The first thing you need to do is to work out if you have one or many undo buffers, and how a given part of your user
		interface can get at its undo buffer.
		
		Then you will need is "instrumented" Kontrols. Every action the user can cause needs to generate￼a suitable UndoAction subclass.
		This will need to support the following Events:
		
		Description returns a textual description of the action, for display in an Undo control (eg "Delete 'abcd...f'")
		
		InvokeEvent causes the action it represents to be reversed
		
		UninvokeEvent causes the undo it did to be reversed
		
		MergeEvent (optional) gives the action an opportunity to merge with the immediately preceding UndoAction, becoming one
		action. For example, each typing keystroke generates a typingUndoAction, but sequential typingUndoActions always merge
		into one, because you don't want to have to undo typing one keystroke at a time. In a word processor, you might want a
		different policy. For example, pressing return might become a merging boundary, or a period might, so the user would
		undo one sentence or paragraph at a time.
		
		(Note that NewThisUndoActionType [as are the other events] is part of the Undo framework's participation in the Flatten
		framework, and won't be discussed further).
		
		If you look at the examples, you'll see that your Undo action will need to keep track of its UndoQueue, the object for
		which it represents an Undo, and all the information needed to Undo and Redo the action it represents.
		
		The "client" user interface elements of the UndoAction will need to be able to generate the Undo actions and provide
		them with a suitable interface to carry out their actions. An instrumented plain-text EditField class is provided as an
		example. Note the use of the TextEntryObject Class Interface to abstract the interface necessary for the Undo actions.
		Other instrumented control classes are likely to be able to reuse much of this work, by supporting the same Class
		Interface.
	#tag EndNote

	#tag Note, Name = Undo: UndoActions and the UndoQueue
		An "instrumented" control should convert all undoable Events into a suitable UndoAction subclass, and submit
		them to the current UndoQueue by calling the global AddToUndoQueue method.
		
		On receiving a new UndoAction, the UndoQueue offers it an opportunity to merge with the previous undoAction
		on the queue, *if* there hasn't been an undo in between. This can be used to, for example, merge two or more
		sequential typing events into a single TypingUndoAction (since it is tedious to require the user to undo typing
		one character at a time). So note that the instrumented control need not be concerned with such matters.
		
		An instrumented control should be accessed by the UndoActions through a suitable high-level Class Interface
		(rather than relying on intimate details of the control). See the TextEntryObject Class Interface for an example. It is
		quite likely that another instrumented control class won't need anything other than the TextEntryObject's methods.
		
		In order to support UI components that update their state as the undo queue changes, an UndoQueue supports
		listeners (that support the UndoQueueListener Class Interface). Added to the UndoQueue by calling
		UndoQueue.AddListener, each such object is notified (via UndoQueueListener.UndoQueueChanged) each time the
		UndoQueue changes.
	#tag EndNote


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
