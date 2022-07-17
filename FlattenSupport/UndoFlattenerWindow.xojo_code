#tag Class
Protected Class UndoFlattenerWindow
Inherits FlattenerWindow
	#tag Event
		Function FlattenOther(f As FlattenManager) As String
		  Dim d As DataString
		  
		  d = New DataString
		  
		  d.AddInteger f.KeyFromObject(GetUndoQueue)
		  d.AddString FlattenOther(f)
		  
		  Return d.Result
		End Function
	#tag EndEvent

	#tag Event
		Sub UnFlattenOther(s As String, f As FlattenManager)
		  Dim d As DataString
		  
		  d = New DataString(s)
		  
		  TheUndoQueue = UndoQueue(f.ObjectFromKey(d.FetchInteger))
		  UnFlattenOther d.FetchString, f
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event FlattenOther(f As FlattenManager) As String
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UnFlattenOther(s As String, f As FlattenManager)
	#tag EndHook


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
	#tag EndViewBehavior
End Class
#tag EndClass
