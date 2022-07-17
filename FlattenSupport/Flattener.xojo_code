#tag Interface
Protected Interface Flattener
	#tag Method, Flags = &h8
		Function Flatten(f As FlattenManager) As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h8
		Function Identification() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h8
		Sub RestoreStateFromString(s As String, f As FlattenManager)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h8
		Sub UnFlatten(s As String, f As FlattenManager, i As Integer)
		  
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
