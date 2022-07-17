#tag Module
Protected Module UndoSupport
	#tag Method, Flags = &h0
		Sub AddToUndoQueue(a As UndoAction)
		  GetUndoQueue().Add a
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUndoQueue() As UndoQueue
		  //We may have DontSaveCancelSave hiding but frontmost, so get the second-front window if needed
		  If Window(0) IsA UndoWindow Then
		    Return UndoWindow(Window(0)).GetUndoQueue()
		  Else
		    Return UndoWindow(Window(1)).GetUndoQueue()
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitialiseUndo()
		  TheClipboard = New Clipboard
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		CurrentFocus As TextEntryObject
	#tag EndProperty

	#tag Property, Flags = &h0
		TheClipboard As Clipboard
	#tag EndProperty

	#tag Property, Flags = &h0
		TheUndoQueue As UndoQueue
	#tag EndProperty


	#tag Constant, Name = UndoDescriptionLength, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant


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
