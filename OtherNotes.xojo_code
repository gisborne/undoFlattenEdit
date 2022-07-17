#tag Module
Protected Module OtherNotes
	#tag Note, Name = About proxies
		Until REALbasic has first-class classes, we need some objects that can represent all the instances of a class, to provide flattening and unflattening services specific to
		the class (such as providing an identifying name).
		
		We use an instance of the class, which we call a proxy.
		
	#tag EndNote

	#tag Note, Name = Copyright and Support
		All copyright is hereby absolved. You may use the code herein for any purpose, without attribution.
		
		The code was developed by Guyren G Howe, from Relevant Logic (http://relevantlogic.com).
		
		Some email support may be available as opportunity presents. Relevant Logic is available on a consulting basis for this and other
		REALbasic consulting, including code review and Object Oriented Design consulting.
		
		Contact:
		Guyren G. Howe
		guyren@relevantlogic.com
		http://relevantlogic.com
		
		1 512 538 0655
		
		REALbasic, PHP, Python programming
		PostgreSQL, MySQL database design and consulting
		Technical writing and training
	#tag EndNote

	#tag Note, Name = Joining the frameworks
		It seemed simplest to join the frameworks by attaching the class hierarchy for flattening to the bottom of the classes
		for undoing, or where it was desirable to add shared flattening features to a superclass, to put the flattening code
		and the undo code in the one class.
		
		While this will make it a little difficult to separate one framework from the other, it greatly facilitates the use of both
		frameworks together. And it would be simple to just ignore the other framework if only the features of one were requried.
		
	#tag EndNote

	#tag Note, Name = Overview of the project
		This project is a vehicle to demonstrate two frameworks: an Undo framework, and a flatten framework.
		
		The Undo framework provides a complete set of undo features: multiple undo/redo (that intelligently
		treats multiple actions, such as keystrokes, as one action), descriptive menu commands ("Undo typing"
		and the like), and multiple ways of requesting undo/redo (menu commands, buttons etc).
		
		Flattening is variously referred to as serializing, marshalling, pickling and some other things. It refers to
		converting an arbitrary part of a program's state into a string and back again. This is mostly useful for
		saving program state to a file or sending it over a network.
		
		The two frameworks are put together into an application that provides a multiple undo/redo text editor,
		that saves the state of the undo/redo buffer across file save/loads.
		
		The frameworks are themselves described in separate notes here, and notes are used throughout the
		application provide detailed documentation.
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
