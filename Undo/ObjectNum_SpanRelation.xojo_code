#tag Class
Protected Class ObjectNum_SpanRelation
Implements Flattener
	#tag Method, Flags = &h0
		Sub Add(n As Integer, Start As Integer, Length As Integer)
		  ObjectNumToStart.Value(n) = Start
		  ObjectNumToLength.Value(n) = Length
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  ObjectNumToLength = New Dictionary
		  ObjectNumToStart = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(s As String, f As FlattenManager)
		  //Begin by calling regular constructor
		  Constructor
		  
		  RestoreStateFromString s, f
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Flatten(f As FlattenManager) As String
		  Dim s As String
		  Dim Counter, ListUBound As Integer
		  
		  ListUBound = UBound
		  For Counter = 0 To ListUBound
		    s = s + FlattenInteger(Counter) + FlattenInteger(NthStart(Counter)) + FlattenInteger(NthLength(Counter))
		  Next
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identification() As String
		  Return "ObjectNum_SpanRelation"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LengthFromObjectNum(n As Integer) As Integer
		  Return ObjectNumToLength.Value(n)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NthLength(n As Integer) As Integer
		  Return ObjectNumToLength.Value(n)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NthStart(n As Integer) As Integer
		  Return ObjectNumToStart.Value(n)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RestoreStateFromString(s As String, f As FlattenManager)
		  Dim CurrentLoc As Integer
		  
		  //Now unpack the string
		  CurrentLoc = 1
		  While CurrentLoc <= Len(s)
		    Add UnFlattenInteger(Mid(s, CurrentLoc, 4)), UnFlattenInteger(Mid(s, CurrentLoc + 4, 4)), UnFlattenInteger(Mid(s, CurrentLoc + 8, 4))
		    CurrentLoc = CurrentLoc + 12
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StartFromObjectNum(n As Integer) As Integer
		  Return ObjectNumToStart.Value(n)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound() As Integer
		  Return ObjectNumToLength.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnFlatten(s As String, f As FlattenManager, i As Integer)
		  Dim OSR As ObjectNum_SpanRelation
		  OSR = New ObjectNum_SpanRelation
		  f.AddBeforeUnflatten OSR, i
		  OSR.RestoreStateFromString(s, f)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected ObjectNumToLength As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected ObjectNumToStart As Dictionary
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
	#tag EndViewBehavior
End Class
#tag EndClass
