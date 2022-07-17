#tag Class
Protected Class MultiString
	#tag Method, Flags = &h0
		Sub Add(s As String)
		  //Append s, followed by its length, to our string
		  //We read them back in reverse order; this is a kind of "string stack"
		  TheString = TheString + s + FlattenInteger(Len(s))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BeginReading()
		  //Set the read position to the end of the string. This must be called before we start reading out the strings
		  CurrentReadPos = Len(TheString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DoneReadingStrings() As Boolean
		  Return CurrentReadPos < 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextString() As String
		  //Pre: If Len(TheString) > 0 Then it consists of one or more strings, each followed by its length
		  //  Note: this means we can read each string by starting from the end and counting backward
		  //Post: The string stored at Mid(TheString, 1, CurrentReadPos) is returned, and CurrentReadPos points at the character before it
		  Dim TheLength As Integer
		  
		  If CurrentReadPos > 0 Then
		    TheLength = UnFlattenInteger(Mid(TheString, CurrentReadPos - 3, 4))
		    CurrentReadPos = CurrentReadPos - TheLength - 4
		    Return Mid(TheString, CurrentReadPos + 1, TheLength)
		  Else
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetString(s As String)
		  TheString = s
		  BeginReading
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		CurrentReadPos As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		TheString As String
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
			Name="TheString"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentReadPos"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
