#tag Class
Protected Class Flatten_KeyRelation
	#tag Method, Flags = &h0
		Sub Add(f As Flattener, k As Integer)
		  KeyToObject.Value(k) = f
		  ObjectToKey.Value(f) = k
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  KeyToObject = New Dictionary
		  ObjectToKey = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(f As Flattener) As Boolean
		  Return ObjectToKey.HasKey(f)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(k As Integer) As Boolean
		  Return KeyToObject.HasKey(k)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FlattenFromKey(k As Integer) As Flattener
		  Return KeyToObject.Value(k)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function KeyFromFlatten(f As Flattener) As Integer
		  Return ObjectToKey.Value(f)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected KeyToObject As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected ObjectToKey As Dictionary
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
