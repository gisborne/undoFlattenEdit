#tag Class
Protected Class UndoQueue
Implements Flattener
	#tag Method, Flags = &h0
		Sub Add(u As UndoAction)
		  If UndoEnabled Then
		    If NextUndoPoint = UBound(TheActions) Then//If it's the last action, two actions (eg typing) might need to become one
		      If NextUndoPoint <> -1 Then//If there are any actions in the queue
		        If Not u.Merge(TheActions(NextUndoPoint)) Then//If the last action doesn't want to merge with the new one
		          TheActions.Append u
		          NextUndoPoint = NextUndoPoint + 1
		        End If
		      Else
		        TheActions.Append u
		        NextUndoPoint = NextUndoPoint + 1
		      End If
		    Else
		      //If we're not at the end of the queue, we need to throw away the ones that have been undone when we do something different
		      NextUndoPoint = NextUndoPoint + 1
		      Redim TheActions(NextUndoPoint)
		      TheActions(NextUndoPoint) = u
		    End If
		    
		    UpdateListeners
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddListener(x As UndoQueueListener)
		  //Listeners want to know when the undo queue changes
		  TheListeners.Append x
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  ReDim TheActions(-1)
		  NextUndoPoint = -1
		  UpdateListeners
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  NextUndoPoint = -1
		  UndoEnabled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountReDos() As Integer
		  Return UBound(TheActions) - NextUndoPoint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountUndos() As Integer
		  Return NextUndoPoint + 1//0-based
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisableUndo()
		  //For when undo actions are being invoked
		  UndoEnabled = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnableMenuItems()
		  If UndoActionsAvailable() Then
		    EditUndo.Enable
		  End If
		  
		  If RedoActionsAvailable() Then
		    EditRedo.Enable
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnableUndo()
		  UndoEnabled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Flatten(f As FlattenManager) As String
		  Dim d As DataString
		  Dim Counter As Integer
		  d = New DataString
		  
		  d.AddInteger NextUndoPoint
		  d.AddBoolean UndoEnabled
		  
		  //For each array, add its count and then the sequence of key values
		  d.AddInteger UBound(TheActions)
		  For Counter = 0 To UBound(TheActions)
		    d.AddInteger f.KeyFromObject(Flattener(TheActions(Counter)))
		  Next
		  
		  d.AddInteger UBound(TheListeners)
		  For Counter = 0 To UBound(TheListeners)
		    d.AddInteger f.KeyFromObject(TheListeners(Counter))
		  Next
		  
		  Return d.Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextUndoPoint() As Integer
		  Return NextUndoPoint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identification() As String
		  //A unique identifier for the class, stored with flattened instances, so we know where to go for the code to unflatten it.
		  Return "UndoQueue"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Redo()
		  If RedoActionsAvailable() Then
		    NextUndoPoint = NextUndoPoint + 1
		    TheActions(NextUndoPoint).UnInvoke
		  End If
		  UpdateListeners
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RedoActionsAvailable() As Boolean
		  Return NextUndoPoint < UBound(TheActions)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RedoDescriptions(ByRef TheDescriptions() As String)
		  //Pre: UBound(TheDescriptions) = -1
		  
		  Dim Counter As Integer
		  ReDim TheDescriptions(-1)
		  For Counter = NextUndoPoint + 1 To UBound(TheActions)
		    TheDescriptions.Append TheActions(Counter).GetDescription
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveListener(x As UndoQueueListener)
		  //Post: TheListeners contains x one less times
		  
		  Dim Counter As Integer
		  
		  For Counter = 0 To UBound(TheListeners)
		    If TheListeners(Counter) = x Then
		      TheListeners.Remove Counter
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RestoreStateFromString(s As String, f As FlattenManager)
		  Dim d As DataString
		  Dim Counter, NumObjects As Integer
		  d = New DataString(s)
		  
		  NextUndoPoint = d.FetchInteger
		  UndoEnabled = d.FetchBoolean
		  
		  //For each array, add its count and then the sequence of key values
		  NumObjects = d.FetchInteger
		  For Counter = 0 To NumObjects
		    TheActions.Append UndoAction(f.ObjectFromKey(d.FetchInteger))
		  Next
		  
		  NumObjects = d.FetchInteger
		  For Counter = 0 To NumObjects
		    TheListeners.Append UndoQueueListener(f.ObjectFromKey(d.FetchInteger))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Undo()
		  If UndoActionsAvailable() Then
		    TheActions(NextUndoPoint).Invoke
		    NextUndoPoint = NextUndoPoint - 1
		  End If
		  UpdateListeners
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UndoActionsAvailable() As Boolean
		  Return NextUndoPoint > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UndoDescriptions(ByRef TheDescriptions() As String)
		  //Pre: UBound(TheDescriptions) = -1
		  
		  Dim Counter As Integer
		  ReDim TheDescriptions(-1)
		  For Counter = NextUndoPoint DownTo 0
		    TheDescriptions.Append TheActions(Counter).GetDescription
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UndoIsEnabled() As Boolean
		  Return UndoEnabled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnFlatten(s As String, f As FlattenManager, i As Integer)
		  Dim q As New UndoQueue
		  
		  f.AddBeforeUnflatten q, i
		  q.RestoreStateFromString s, f
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateListeners()
		  Dim Counter As Integer
		  
		  For Counter = 0 To UBound(TheListeners)
		    TheListeners(Counter).UndoQueueChanged
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		NextUndoPoint As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		TheActions(-1) As UndoAction
	#tag EndProperty

	#tag Property, Flags = &h0
		TheListeners(-1) As UndoQueueListener
	#tag EndProperty

	#tag Property, Flags = &h0
		UndoEnabled As Boolean
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
		#tag ViewProperty
			Name="NextUndoPoint"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UndoEnabled"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
