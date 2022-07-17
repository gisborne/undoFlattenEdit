#tag Class
Protected Class SelectionChangeUndoAction
Inherits UndoAction
	#tag Event
		Function Description() As String
		  If TheNewSelLength = 0 Then
		    Return "Move"
		  Else
		    Return "Change Selection"
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Function FlattenEvent(f As FlattenManager) As String
		  Dim d As DataString
		  d = New DataString
		  
		  d.AddInteger TheNewSelLength
		  d.AddInteger TheNewSelStart
		  d.AddInteger TheOldSelLength
		  d.AddInteger TheOldSelStart
		  
		  Return d.Result
		End Function
	#tag EndEvent

	#tag Event
		Function IdentificationEvent() As String
		  //A unique identifier for the class, stored with flattened instances, so we know where to go for the code to unflatten it.
		  Return "SelectionChangeUndoAction"
		End Function
	#tag EndEvent

	#tag Event
		Sub InvokeEvent()
		  theTarget.SetSelection TheOldSelStart, TheOldSelLength
		End Sub
	#tag EndEvent

	#tag Event
		Function MergeEvent(a As UndoAction) As Boolean
		  Dim m As SelectionChangeUndoAction
		  If a IsA SelectionChangeUndoAction Then
		    m = SelectionChangeUndoAction(a)
		    
		    If m.theTarget = theTarget And m.TheNewSelStart = TheOldSelStart And m.TheNewSelLength = TheOldSelLength Then
		      m.TheNewSelStart = TheNewSelStart
		      m.TheNewSelLength = TheNewSelLength
		      Return True
		    End If
		    
		  ElseIf a IsA DragUndoAction Then
		    If TheNewSelStart = theTarget.GetSelStart And TheNewSelLength = theTarget.GetSelLength Then
		      Return True
		    End If
		  End If
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Function NewThisUndoActionType() As UndoAction
		  Return New SelectionChangeUndoAction
		End Function
	#tag EndEvent

	#tag Event
		Sub RestoreStateFromStringEvent(s As String, f As FlattenManager)
		  Dim d As DataString
		  d = New DataString(s)
		  
		  TheNewSelLength = d.FetchInteger
		  TheNewSelStart = d.FetchInteger
		  TheOldSelLength = d.FetchInteger
		  TheOldSelStart = d.FetchInteger
		End Sub
	#tag EndEvent

	#tag Event
		Sub UninvokeEvent()
		  theTarget.SetSelection TheNewSelStart, TheNewSelLength
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  //Empty constructor for unflattening
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(u As UndoQueue, Target As TextEntryObject, OldStart As Integer, OldLength As Integer, NewStart As Integer, NewLength As Integer)
		  Super.Constructor u//Call super's constructor
		  theTarget = Target
		  TheOldSelStart = OldStart
		  TheOldSelLength = OldLength
		  TheNewSelStart = NewStart
		  TheNewSelLength = NewLength
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		TheNewSelLength As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		TheNewSelStart As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		TheOldSelLength As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		TheOldSelStart As Integer
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
			Name="TheNewSelStart"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TheOldSelLength"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TheNewSelLength"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TheOldSelStart"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
