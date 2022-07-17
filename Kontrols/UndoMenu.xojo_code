#tag Class
Protected Class UndoMenu
Inherits FlattenUndoRedoMenu
	#tag Event
		Sub FetchUndoRedoItems(ByRef TheActions() As String)
		  GetUndoQueue().UndoDescriptions TheActions
		End Sub
	#tag EndEvent

	#tag Event
		Sub InvokeOnce()
		  UndoWindow(Window).TheUndoQueue.Undo
		End Sub
	#tag EndEvent

	#tag Event
		Sub UndoQueueChangedEvent()
		  Dim u As Integer
		  u = GetUndoQueue().CountUndos
		  
		  If u > 0 Then
		    Enabled = True
		  Else
		    Enabled = False
		  End If
		End Sub
	#tag EndEvent


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
