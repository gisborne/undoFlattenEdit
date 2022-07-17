#tag Class
Protected Class Int_IntRelation
Implements Flattener
	#tag Method, Flags = &h0
		Sub Add(k As Integer, t As Integer)
		  Key1ToKey2.Value(k) = t
		  Key2ToKey1.Value(t) = k
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Key1ToKey2 = New Dictionary
		  Key2ToKey1 = New Dictionary
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
		  Dim Counter, FirstKey, ListUBound As Integer
		  
		  ListUBound = Key1ToKey2.Count - 1
		  For Counter = 0 To ListUBound
		    FirstKey = Key1ToKey2.Key(Counter)
		    s = s + FlattenInteger(FirstKey)
		    s = s + FlattenInteger(Key1ToKey2.Value(FirstKey))
		  Next
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identification() As String
		  Return "Int_IntRelation"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key1(n As Integer) As Integer
		  Return Key1ToKey2.Key(n).IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key1FromKey2(t As Integer) As Integer
		  Return Key2ToKey1.Value(t)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key2(n As Integer) As Integer
		  Return Key2ToKey1.Key(n).IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key2FromKey1(t As Integer) As Integer
		  Return Key1ToKey2.Value(t)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RestoreStateFromString(s As String, f As FlattenManager)
		  //Reconstruct the object from flattened state
		  //See Flatten
		  Dim CurrentLoc As Integer
		  
		  //Now unpack the string
		  CurrentLoc = 1
		  
		  While CurrentLoc <= Len(s)
		    Add UnFlattenInteger(Mid(s, CurrentLoc, 4)), UnFlattenInteger(Mid(s, CurrentLoc + 4, 4))
		    CurrentLoc = CurrentLoc + 8
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound() As Integer
		  Return Key1ToKey2.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnFlatten(s As String, f As FlattenManager, i As Integer)
		  Dim IIR As Int_IntRelation
		  IIR = New Int_IntRelation
		  f.AddBeforeUnflatten IIR, i
		  IIR.RestoreStateFromString(s, f)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected Key1ToKey2 As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Key2ToKey1 As Dictionary
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
