#tag Class
Protected Class DeleteTextUndoAction
Inherits UndoAction
	#tag Event
		Function Description() As String
		  If Len(TheSelText) > UndoDescriptionLength Then
		    Return "Delete " + Chr(210) + Left(TheSelText, UndoDescriptionLength) + "…" + Chr(211)    // <-- CONVERTED
		  Else
		    Return "Delete " + Chr(210) + TheSelText + Chr(211)
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Function FlattenEvent(f As FlattenManager) As String
		  Dim d As DataString
		  d = New DataString
		  
		  d.AddInteger TheSelStart
		  d.AddString TheSelText
		  
		  Return d.Result
		End Function
	#tag EndEvent

	#tag Event
		Function IdentificationEvent() As String
		  //A unique identifier for the class, stored with flattened instances, so we know where to go for the code to unflatten it.
		  Return "DeleteTextUndoAction"
		End Function
	#tag EndEvent

	#tag Event
		Sub InvokeEvent()
		  'theTarget.AddText TheSelText, TheSelStart, 0
		  theTarget.AddText TheSelText, theTarget.GetSelStart, 0
		  theTarget.SetSelection TheSelStart, Len(TheSelText)
		End Sub
	#tag EndEvent

	#tag Event
		Function MergeEvent(a As UndoAction) As Boolean
		  //Deletions are always discrete actions
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Function NewThisUndoActionType() As UndoAction
		  Return New DeleteTextUndoAction
		End Function
	#tag EndEvent

	#tag Event
		Sub RestoreStateFromStringEvent(s As String, f As FlattenManager)
		  Dim d As DataString
		  d = New DataString(s)
		  
		  TheSelStart = d.FetchInteger
		  TheSelText = d.FetchString
		End Sub
	#tag EndEvent

	#tag Event
		Sub UninvokeEvent()
		  theTarget.DeleteText TheSelStart, Len(TheSelText)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  //Empty constructor for unflattening
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(u As UndoQueue, Target as TextEntryObject, TheStart As Integer, TheText As String)
		  Super.Constructor u//Call super's constructor
		  theTarget = Target
		  TheSelStart = TheStart
		  TheSelText = TheText
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		TheSelStart As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		TheSelText As String
	#tag EndProperty


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
		#tag ViewProperty
			Name="TheSelStart"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TheSelText"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
