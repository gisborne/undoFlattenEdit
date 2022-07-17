#tag Class
Protected Class FlattenEditField
Inherits UndoEditField
Implements FlattenerControl
	#tag Method, Flags = &h0
		Function Flatten(f As FlattenManager) As String
		  Dim Data As DataString
		  Data = New DataString
		  
		  //Flatten state
		  Data.AddString Text
		  Data.AddInteger SelStart
		  Data.AddInteger SelLength
		  Data.AddInteger ScrollPosition
		  
		  Return Data.Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnFlatten(s As String, f As FlattenManager)
		  //Recreate an EditField from a string
		  Dim Data As DataString
		  
		  Data = New DataString(s)
		  
		  Text = Data.FetchString
		  SelStart = Data.FetchInteger
		  SelLength = Data.FetchInteger
		  ScrollPosition = Data.FetchInteger
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
			InitialValue=""
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
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
