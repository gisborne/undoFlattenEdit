#tag Class
Protected Class DragAwareEditField
Inherits TextKeyEditField
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  Dragging = False
		  Return KeyDown(Key)
		End Function
	#tag EndEvent

	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Dim c As Integer
		  
		  c = CharPosAtXY(X, Y)
		  
		  If c >= SelStart And c <=SelStart + SelLength Then//Down on selection
		    SelStartAtMouseDown = SelStart
		    Dragging = True
		  Else
		    Dragging = False
		  End If
		  Return MouseDown(X, Y)
		End Function
	#tag EndEvent

	#tag Event
		Sub TextChange()
		  If Dragging And SelStart <> SelStartAtMouseDown Then
		    WasDragged = True
		  Else
		    WasDragged = False
		  End If
		  TextChanged
		  Dragging = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function DraggedFrom() As Integer
		  If WasDragged Then
		    Return SelStartAtMouseDown
		  Else
		    Return -1
		  End If
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event KeyDown(Key As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseDown(X As Integer, Y As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TextChanged()
	#tag EndHook


	#tag Property, Flags = &h0
		Dragging As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		SelStartAtMouseDown As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		WasDragged As Boolean
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
		#tag ViewProperty
			Name="SelStartAtMouseDown"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Dragging"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WasDragged"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
