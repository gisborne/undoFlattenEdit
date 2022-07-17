#tag Class
Protected Class CutCopyUndoAction
Inherits UndoAction
	#tag Event
		Function FlattenEvent(f As FlattenManager) As String
		  Dim d As DataString
		  d = New DataString
		  
		  d.AddString OldClipRTF
		  d.AddString OldClipText
		  d.AddBoolean RTFAvailable
		  d.AddBoolean TextAvailable
		  d.AddInteger TheSelStart
		  d.AddInteger f.KeyFromObject(Flattener(TheTarget))
		  d.AddString TheText
		  
		  Return d.Result
		End Function
	#tag EndEvent

	#tag Event
		Sub InvokeEvent()
		  If RTFAvailable Then
		    TheClipboard.AddMacData(OldClipRTF, "RTF")
		  ElseIf TextAvailable Then
		    TheClipboard.Text = OldClipText
		  End If
		  InvokeEvent
		End Sub
	#tag EndEvent

	#tag Event
		Function MergeEvent(a As UndoAction) As Boolean
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Sub RestoreStateFromStringEvent(s As String, f As FlattenManager)
		  Dim d As DataString
		  d = New DataString(s)
		  
		  OldClipRTF = d.FetchString
		  OldClipText = d.FetchString
		  RTFAvailable = d.FetchBoolean
		  TextAvailable = d.FetchBoolean
		  TheSelStart = d.FetchInteger
		  TheTarget = TextEntryObject(f.ObjectFromKey(d.FetchInteger))
		  TheText = d.FetchString
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  //Blank constructor for unflattening
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Target As TextEntryObject, SelStart As Integer, Text As String, u As UndoQueue)
		  TheTarget = Target
		  TheSelStart = SelStart
		  TheText = Text
		  If TheClipboard.MacDataAvailable("RTF") Then
		    OldClipRTF = TheClipboard.MacData("RTF")
		    RTFAvailable = True
		  ElseIf TheClipboard.TextAvailable Then
		    OldClipText = TheClipboard.Text
		    TextAvailable = True
		  End If
		  
		  Super.Constructor u
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event InvokeEvent()
	#tag EndHook


	#tag Property, Flags = &h0
		OldClipRTF As String
	#tag EndProperty

	#tag Property, Flags = &h0
		OldClipText As String
	#tag EndProperty

	#tag Property, Flags = &h0
		RTFAvailable As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		TextAvailable As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		TheSelStart As Integer
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
			Name="TheSelStart"
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
			Name="OldClipText"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="OldClipRTF"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RTFAvailable"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextAvailable"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
