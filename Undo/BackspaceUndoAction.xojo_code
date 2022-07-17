#tag Class
Protected Class BackspaceUndoAction
Inherits UndoAction
	#tag Event
		Function Description() As String
		  If Len(TheText) > UndoDescriptionLength Then
		    Return "Delete " + Chr(210) + Left(TheText, UndoDescriptionLength) + "…" + Chr(211)    // <-- CONVERTED
		  Else
		    Return "Delete " + Chr(210) + TheText + Chr(211)
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Function FlattenEvent(f As FlattenManager) As String
		  Dim d As DataString
		  d = New DataString
		  
		  d.AddInteger TheLocation
		  d.AddString TheText
		  
		  Return d.Result
		End Function
	#tag EndEvent

	#tag Event
		Function IdentificationEvent() As String
		  //A unique identifier for the class, stored with flattened instances, so we know where to go for the code to unflatten it.
		  Return "BackspaceUndoAction"
		End Function
	#tag EndEvent

	#tag Event
		Sub InvokeEvent()
		  theTarget.AddText TheText, TheLocation, 0
		End Sub
	#tag EndEvent

	#tag Event
		Function MergeEvent(a As UndoAction) As Boolean
		  //If we get two backspace actions in a row, and they're for the same target, they must be next to each other, so merge them.
		  Dim b As BackspaceUndoAction
		  If a IsA BackspaceUndoAction Then
		    b = BackspaceUndoAction(a)
		    If b.theTarget = theTarget Then
		      b.TheText = TheText + b.TheText
		      b.TheLocation = TheLocation
		      Return True
		    End If
		  End If
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Function NewThisUndoActionType() As UndoAction
		  Return New BackspaceUndoAction
		End Function
	#tag EndEvent

	#tag Event
		Sub RestoreStateFromStringEvent(s As String, f As FlattenManager)
		  Dim d As DataString
		  d = New DataString(s)
		  
		  TheLocation = d.FetchInteger
		  TheText = d.FetchString
		End Sub
	#tag EndEvent

	#tag Event
		Sub UninvokeEvent()
		  theTarget.DeleteText TheLocation, Len(TheText)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  //No-arguments constructor for unflattening
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(u As UndoQueue, Target As TextEntryObject, Location As Integer, WhatDeleted As String)
		  Super.Constructor u//Call super's constructor
		  theTarget = Target
		  TheLocation = Location
		  TheText = WhatDeleted
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		TheLocation As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		TheText As String
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
			Name="TheLocation"
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
