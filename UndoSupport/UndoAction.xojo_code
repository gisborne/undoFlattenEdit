#tag Class
Protected Class UndoAction
Implements Flattener
	#tag Method, Flags = &h0
		Sub Constructor(u As UndoQueue)
		  MyUndoQueue = u
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Flatten(f As FlattenManager) As String
		  Dim d As DataString
		  d = New DataString
		  
		  d.AddInteger f.KeyFromObject(MyUndoQueue)
		  d.AddInteger f.KeyFromObject(TheTarget)
		  d.AddString FlattenEvent(f)
		  
		  Return d.Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDescription() As String
		  Return Description
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identification() As String
		  Return RaiseEvent Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Invoke()
		  MyUndoQueue.DisableUndo //So we don't put the changes we're making in as undos
		  TheTarget.AcquireFocus//in case we've changed focus
		  InvokeEvent
		  'MyUndoQueue.EnableUndo
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Merge(a As UndoAction) As Boolean
		  Return MergeEvent(a)//Indicates whether two actions eg typing two letters should be merged into one action
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RestoreStateFromString(s As String, f As FlattenManager)
		  Dim d As DataString
		  d = New DataString(s)
		  
		  MyUndoQueue = UndoQueue(f.ObjectFromKey(d.FetchInteger))
		  TheTarget = TextEntryObject(f.ObjectFromKey(d.FetchInteger))
		  RestoreStateFromStringEvent d.FetchString, f
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnFlatten(s As String, f As FlattenManager, i As Integer)
		  Dim u As UndoAction
		  u = NewThisUndoActionType
		  f.AddBeforeUnflatten u, i
		  u.RestoreStateFromString s, f
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Uninvoke()
		  MyUndoQUeue.DisableUndo //So we don't put the changes we're making in as undos
		  theTarget.AcquireFocus//in case we've changed focus
		  UninvokeEvent
		  'MyUndoQueue.EnableUndo
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Description() As String
	#tag EndHook

	#tag Hook, Flags = &h0
		Event FlattenEvent(f As FlattenManager) As String
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Identifier() As String
	#tag EndHook

	#tag Hook, Flags = &h0
		Event InvokeEvent()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MergeEvent(a As UndoAction) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event NewThisUndoActionType() As UndoAction
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RestoreStateFromStringEvent(s As String, f As FlattenManager)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UninvokeEvent()
	#tag EndHook


	#tag Property, Flags = &h0
		MyUndoQueue As UndoQueue
	#tag EndProperty

	#tag Property, Flags = &h0
		TheTarget As TextEntryObject
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
