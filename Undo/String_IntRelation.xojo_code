#tag Class
Protected Class String_IntRelation
Implements Flattener
	#tag Method, Flags = &h0
		Sub Add(s As String, i As Integer)
		  IntToString.Value(i) = s
		  StringToInt.Value(s) = i
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  IntToString = New Dictionary
		  StringToInt = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(s As String, f As FlattenManager)
		  //Begin by calling regular constructor
		  String_IntRelation
		  
		  RestoreStateFromString s, f
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(i As Integer) As Boolean
		  Return IntToString.HasKey(i)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(s As String) As Boolean
		  Return StringToInt.HasKey(s)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Flatten(f As FlattenManager) As String
		  Dim s As String
		  Dim Counter, IntKey, ListUBound As Integer
		  
		  ListUBound = IntToString.Count - 1
		  For Counter = 0 To ListUBound
		    IntKey = IntToString.Key(Counter)
		    s = s + FlattenString(IntToString.Value(IntKey))
		    s = s + FlattenInteger(IntKey)
		  Next
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identification() As String
		  Return "String_IntRelation"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IntFromString(s As String) As Integer
		  Return StringToInt.Value(s)
		  Exception
		    
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IntValue(n As Integer) As Integer
		  //So we can enumerate the content
		  Return IntToString.Key(n)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RestoreStateFromString(s As String, f As FlattenManager)
		  //Reconstruct the object from flattened state
		  //See Flatten
		  Dim CurrentLoc, NextLength As Integer
		  Dim NextString As String
		  
		  //Now unpack the string
		  CurrentLoc = 1
		  While CurrentLoc <= Len(s)
		    //Get the string length
		    NextLength = UnFlattenInteger(Mid(s, CurrentLoc, 4))
		    CurrentLoc = CurrentLoc + 4
		    //Get the string
		    NextString = Mid(s, CurrentLoc, NextLength)
		    CurrentLoc = CurrentLoc + NextLength
		    //Get the Int it's related to, and store it along with its associated string
		    Add NextString, UnFlattenInteger(Mid(s, CurrentLoc, 4))
		    CurrentLoc = CurrentLoc + 4
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringFromInt(i As Integer) As String
		  Return IntToString.Value(i).StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue(n As Integer) As String
		  //So we can enumerate over the content
		  Return StringFromInt(IntValue(n))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound() As Integer
		  Return IntToString.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnFlatten(s As String, f As FlattenManager, i As Integer)
		  Dim SIR As String_IntRelation
		  SIR = New String_IntRelation
		  f.AddBeforeUnflatten SIR, i
		  SIR.RestoreStateFromString(s, f)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected IntToString As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected StringToInt As Dictionary
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
