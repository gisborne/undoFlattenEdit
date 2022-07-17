#tag Module
Protected Module FlattenSupport
	#tag Method, Flags = &h0
		Function ControlIdentifier(c As DesktopUIControl, f As FlattenManager) As Integer
		  If c.Window IsA Flattener Then
		    //We use negative numbers for controls, in a way that contains both the window ID and the control number.
		    Return -(f.KeyFromObject(Flattener(c.Window)) * ControlModulus + ControlNumFromControl(c) + 1)
		    //+1 in case we're control 0 in window 0, to make sure it's negative.
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ControlNumFromControl(c As DesktopUIControl) As Integer
		  Dim Counter As Integer
		  For Counter = 0 To c.Window.ControlCount
		    If c.Window.Control(Counter) = c Then
		      Return Counter
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FlattenBoolean(b As Boolean) As String
		  //Returns b As A 1-character string
		  If b Then
		    Return "1"
		  Else
		    Return "0"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FlattenColor(c As Color) As String
		  //Converts c to a 3-character string
		  TheBuffer.ColorValue(0, 24) = c
		  Return TheBuffer.StringValue(0, 3)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FlattenDouble(d As Double) As String
		  //Converts d to a 8-character string
		  TheBuffer.DoubleValue(0) = d
		  Return TheBuffer.StringValue(0, 8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FlattenInteger(i As Integer) As String
		  //Converts i to a 4-character string
		  TheBuffer.Long(0) = i
		  Return TheBuffer.StringValue(0, 4)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FlattenSingle(s As Single) As String
		  //Converts s to a 4-character string
		  TheBuffer.SingleValue(0) = s
		  Return TheBuffer.StringValue(0, 4)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FlattenString(s As String) As String
		  //Returns a 4-byte length for s, followed by s
		  Return FlattenInteger(Len(s)) + s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitialiseFlattenSupport()
		  TheBuffer = NewMemoryBlock(8)//Maximum length for data types
		  FlattenManager.RegisterProxy DocWindow
		  DocWindow.Visible = False
		  FlattenManager.RegisterProxy New UndoQueue
		  FlattenManager.RegisterProxy New SelectionChangeUndoAction
		  FlattenManager.RegisterProxy New DeleteTextUndoAction
		  FlattenManager.RegisterProxy New BackspaceUndoAction
		  FlattenManager.RegisterProxy New ForwardDeleteUndoAction
		  FlattenManager.RegisterProxy New CopyUndoAction
		  FlattenManager.RegisterProxy New PasteUndoAction
		  FlattenManager.RegisterProxy New CutUndoAction
		  FlattenManager.RegisterProxy New TypingUndoAction
		  FlattenManager.RegisterProxy New DragUndoAction
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UnFlattenBoolean(s As String) As Boolean
		  Return s = "1"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UnFlattenColor(s As String) As Color
		  //Converts i to a 4-character string
		  TheBuffer.StringValue(0, 3) = s
		  Return TheBuffer.ColorValue(0,24)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UnFlattenDouble(s As String) As Double
		  //Converts i to a 4-character string
		  TheBuffer.StringValue(0, 8) = s
		  Return TheBuffer.DoubleValue(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UnFlattenInteger(s As String) As Integer
		  //Converts i to a 4-character string
		  TheBuffer.StringValue(0, 4) = s
		  Return TheBuffer.Long(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UnFlattenSingle(s As String) As Single
		  //Converts i to a 4-character string
		  TheBuffer.StringValue(0, 4) = s
		  Return TheBuffer.SingleValue(0)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected TheBuffer As MemoryBlock
	#tag EndProperty


	#tag Constant, Name = ControlModulus, Type = Integer, Dynamic = False, Default = \"1000000", Scope = Public
	#tag EndConstant


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
End Module
#tag EndModule
