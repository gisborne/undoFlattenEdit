#tag Class
Protected Class FlattenUndoRedoMenu
Inherits UndoRedoMenu
Implements FlattenerControl
	#tag Method, Flags = &h8
		Function Flatten(f As FlattenManager) As String
		  Dim d As DataString
		  Dim Counter As Integer
		  
		  d = New DataString
		  
		  d.AddBoolean Enabled
		  Counter = 0
		  
		  //We use a Try to catch an empty list
		  Try
		    Do Until List(Counter) = ""
		      d.AddString List(Counter)
		      Counter = Counter + 1
		    Loop
		  Catch e As OutOfBoundsException
		    //do nothing -- list was empty
		  End Try
		  
		  Return d.Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier(f As FlattenManager) As Integer
		  //We use negative numbers for controls, in a way that contains both the window ID and the control number.
		  Dim Counter As Integer
		  For Counter = 0 To Window.ControlCount
		    If Window.Control(Counter) = Me Then
		      Return -(f.KeyFromObject(Flattener(Window)) * ControlModulus + Counter + 1)
		      //+1 in case we're control 0 in window 0, to make sure it's negative.
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h8
		Sub UnFlatten(s As String, f As FlattenManager)
		  Dim d As DataString
		  
		  d = New DataString(s)
		  
		  Enabled = d.FetchBoolean
		  Do Until d.DoneFetching
		    AddRow d.FetchString
		  Loop
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
