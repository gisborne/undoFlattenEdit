#tag Class
Protected Class DragUndoAction
Inherits UndoAction
	#tag Event
		Function Description() As String
		  If Len(TheText) > UndoDescriptionLength Then
		    Return "Drag " + Chr(210) + Left(TheText, UndoDescriptionLength) + "…" + Chr(211)    // <-- CONVERTED
		  Else
		    Return "Drag " + Chr(210) + TheText + Chr(211)
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Function FlattenEvent(f As FlattenManager) As String
		  Dim d As DataString
		  d = New DataString
		  
		  d.AddString TheText
		  d.AddInteger WhereFrom
		  d.AddInteger WhereTo
		  
		  Return d.Result
		End Function
	#tag EndEvent

	#tag Event
		Function IdentificationEvent() As String
		  //A unique identifier for the class, stored with flattened instances, so we know where to go for the code to unflatten it.
		  Return "DragUndoAction"
		End Function
	#tag EndEvent

	#tag Event
		Sub InvokeEvent()
		  theTarget.DeleteText WhereTo, Len(TheText)
		  theTarget.AddText TheText, WhereFrom, 0
		  theTarget.SetSelection WhereFrom, Len(TheText)
		End Sub
	#tag EndEvent

	#tag Event
		Function MergeEvent(a As UndoAction) As Boolean
		  If a IsA DragUndoAction Then
		    DragUndoAction(a).WhereTo = GetWhereTo()
		    Return True
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Function NewThisUndoActionType() As UndoAction
		  Return New DragUndoAction
		End Function
	#tag EndEvent

	#tag Event
		Sub RestoreStateFromStringEvent(s As String, f As FlattenManager)
		  Dim d As DataString
		  d = New DataString(s)
		  
		  TheText = d.FetchString
		  WhereFrom = d.FetchInteger
		  WhereTo = d.FetchInteger
		End Sub
	#tag EndEvent

	#tag Event
		Sub UninvokeEvent()
		  theTarget.DeleteText WhereFrom, Len(TheText)
		  theTarget.AddText TheText, WhereTo, 0
		  theTarget.SetSelection WhereTo, Len(TheText)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  //Blank constructor for unflatten
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(u As UndoQueue, Target As TextEntryObject, FromLocation As Integer, ToLocation As Integer, TextMoved As String)
		  Super.Constructor u//Call super's constructor
		  theTarget = Target
		  WhereFrom = FromLocation
		  WhereTo = ToLocation
		  TheText = TextMoved
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetWhereTo() As Integer
		  Return WhereTo
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		TheText As String
	#tag EndProperty

	#tag Property, Flags = &h0
		WhereFrom As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		WhereTo As Integer
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
			Name="WhereFrom"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WhereTo"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TheText"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
