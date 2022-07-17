#tag Interface
Protected Interface TextEntryObject
	#tag Method, Flags = &h8
		Sub AcquireFocus()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h8
		Sub AddText(TheText As String, TheLocation As Integer, TheLength As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h8
		Sub Clear()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h8
		Sub CopyIt()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h8
		Sub CutIt()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h8
		Sub DeleteText(TheLocation As Integer, TheLength As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h8
		Function GetSelLength() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h8
		Function GetSelStart() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h8
		Sub PasteIt()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h8
		Sub SelectAll()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h8
		Sub SetSelection(NewSelStart As Integer, NewSelLength As Integer)
		  
		End Sub
	#tag EndMethod


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
End Interface
#tag EndInterface
