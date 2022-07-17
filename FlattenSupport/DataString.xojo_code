#tag Class
Protected Class DataString
	#tag Method, Flags = &h0
		Sub AddBoolean(b As Boolean)
		  TheString = TheString + FlattenBoolean(b)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddColor(c As Color)
		  TheString = TheString + FlattenColor(c)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddDouble(d As Double)
		  TheString = TheString + FlattenDouble(d)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddInteger(i As Integer)
		  TheString = TheString + FlattenInteger(i)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddSingle(s As Single)
		  TheString = TheString + FlattenSingle(s)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddString(s As String)
		  TheString = TheString + FlattenString(s)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  NextStartLocation = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(s As String)
		  TheString = s
		  NextStartLocation = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DoneFetching() As Boolean
		  Return NextStartLocation > Len(TheString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FetchBoolean() As Boolean
		  Dim  CurrentStart As Integer
		  CurrentStart = NextStartLocation
		  NextStartLocation = NextStartLocation + 1
		  Return UnflattenBoolean(Mid(TheString, CurrentStart, 1))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FetchColor() As Color
		  Dim CurrentStart As Integer
		  CurrentStart = NextStartLocation
		  NextStartLocation = NextStartLocation + 3
		  Return UnflattenColor(Mid(TheString, CurrentStart, 3))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FetchDouble() As Double
		  Dim CurrentStart As Integer
		  CurrentStart = NextStartLocation
		  NextStartLocation = NextStartLocation + 8
		  Return UnflattenDouble(Mid(TheString, CurrentStart, 8))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FetchInteger() As Integer
		  Dim CurrentStart As Integer
		  CurrentStart = NextStartLocation
		  NextStartLocation = NextStartLocation + 4
		  Return UnflattenInteger(Mid(TheString, CurrentStart, 4))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FetchSingle() As Single
		  Dim CurrentStart As Integer
		  CurrentStart = NextStartLocation
		  NextStartLocation = NextStartLocation + 4
		  Return UnflattenSingle(Mid(TheString, CurrentStart, 4))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FetchString() As String
		  Dim i, CurrentStart As Integer
		  //First, extract the length
		  i = FetchInteger
		  CurrentStart = NextStartLocation
		  NextStartLocation = NextStartLocation + i
		  Return Mid(TheString, CurrentStart, i)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Remainder() As String
		  //Returns what's left after we've pulled whatever out of TheString
		  Return Mid(TheString, NextStartLocation)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Result() As String
		  //Returns TheString after we've built it
		  Return TheString
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		NextStartLocation As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TheString As String
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
			Name="NextStartLocation"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
