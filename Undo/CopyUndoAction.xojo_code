#tag Class
Protected Class CopyUndoAction
Inherits CutCopyUndoAction
	#tag Event
		Function Description() As String
		  If Len(TheText) > UndoDescriptionLength Then
		    Return "Copy " + Chr(210) + Left(TheText, UndoDescriptionLength) + "…" + Chr(211)    // <-- CONVERTED
		  Else
		    Return "Copy " + Chr(210) + TheText + Chr(211)
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Function IdentificationEvent() As String
		  //A unique identifier for the class, stored with flattened instances, so we know where to go for the code to unflatten it.
		  Return "CopyUndoAction"
		End Function
	#tag EndEvent

	#tag Event
		Sub InvokeEvent()
		  //Nothing needed here; it's done by the Super
		End Sub
	#tag EndEvent

	#tag Event
		Function NewThisUndoActionType() As UndoAction
		  Return New CopyUndoAction
		End Function
	#tag EndEvent

	#tag Event
		Sub UninvokeEvent()
		  theTarget.CopyIt
		End Sub
	#tag EndEvent


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
End Class
#tag EndClass
