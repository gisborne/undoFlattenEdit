#tag Class
Protected Class AddTextUndoAction
Inherits UndoAction
	#tag Event
		Function FlattenEvent(f As FlattenManager) As String
		  Dim d As DataString
		  d = New DataString
		  
		  d.AddInteger TheLocation
		  d.AddString TheReplacedText
		  d.AddString TheText
		  
		  Return d.Result
		End Function
	#tag EndEvent

	#tag Event
		Sub InvokeEvent()
		  theTarget.AddText TheReplacedText, TheLocation, Len(TheText)
		End Sub
	#tag EndEvent

	#tag Event
		Function MergeEvent(a As UndoAction) As Boolean
		  //We merge with another AddTextUndoAction
		  //Note that this means that eg a paste followed by typing will be merged into one action
		  Dim b As AddTextUndoAction
		  If a IsA AddTextUndoAction Then
		    b = AddTextUndoAction(a) 
		    If b.theTarget = theTarget And b.TheLocation = TheLocation - Len(b.TheText) Then
		      b.TheText = b.TheText + TheText
		      Return True
		    End If
		  End If
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Sub RestoreStateFromStringEvent(s As String, f As FlattenManager)
		  Dim d As DataString
		  d = New DataString(s)
		  
		  TheLocation = d.FetchInteger
		  TheReplacedText = d.FetchString
		  TheText = d.FetchString
		End Sub
	#tag EndEvent

	#tag Event
		Sub UninvokeEvent()
		  theTarget.AddText TheText, TheLocation, Len(TheReplacedText)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  //Empty constructor for when we're unflattening
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(u As UndoQueue, InObj As TextEntryObject, t As String, r As String, WhereAdded As Integer)
		  Super.Constructor u//Call parent's constructor
		  theTarget = InObj
		  TheText = t
		  TheReplacedText = r
		  TheLocation = WhereAdded
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		TheLocation As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		TheReplacedText As String
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
		#tag ViewProperty
			Name="TheReplacedText"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
