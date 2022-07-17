#tag Class
Protected Class UndoEditField
Inherits DragAwareEditField
Implements TextEntryObject
	#tag Event
		Sub Backspace()
		  //Note: TextKeyEditField separates backspacing with no selection from deleting a selection
		  If SelStart > 0 Then
		    'UndoWindow(Window).GetUndoQueue.Add New BackspaceUndoAction(UndoWindow(Window).GetUndoQueue, Me, SelStart - 1, Mid(Text, SelStart, 1))
		    AddToUndoQueue New BackspaceUndoAction(UndoWindow(Window).TheUndoQueue, Me, SelStart - 1, Mid(Text, SelStart, 1))
		    OldSelStart = SelStart - 1
		    OldSelLength = 0
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub ClearSelectionEvent()
		  //Note: TextKeyEditField only calls this when SelLength > 0
		  Clear
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  //Select All not available if all is already selected
		  If SelLength < Len(Text) Then
		    EditSelectAllItem.Enable
		  End If
		  
		  //Cut, Copy available if text is selected
		  If SelLength > 0 Then
		    EditCutItem.Enable
		    EditCopyItem.Enable
		    EditClearItem.Enable
		  End If
		  
		  //Paste available if there is text on the clipboard
		  If TheClipboard.TextAvailable Then
		    EditPasteItem.Enable
		  End If
		  
		  UndoWindow(Window).TheUndoQueue.EnableMenuItems
		End Sub
	#tag EndEvent

	#tag Event
		Sub ForwardDeleteKey()
		  //Note: TextKeyEditField separates backspacing with no selection from deleting a selection
		  If SelStart < Len(Text) Then
		    AddToUndoQueue New ForwardDeleteUndoAction(UndoWindow(Window).TheUndoQueue, Me, SelStart, Mid(Text, SelStart + 1, 1))
		    OldSelStart = SelStart
		    OldSelLength = 0
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub GotFocus()
		  CurrentFocus = Me
		End Sub
	#tag EndEvent

	#tag Event
		Sub SelChange()
		  If UndoWindow(Window).TheUndoQueue.UndoIsEnabled And (SelStart <> OldSelStart Or SelLength <> OldSelLength) And Not Dragging Then
		    AddToUndoQueue New SelectionChangeUndoAction(UndoWindow(Window).TheUndoQueue, Me, OldSelStart, OldSelLength, SelStart, SelLength)
		  End If
		  OldSelStart = SelStart
		  OldSelLength = SelLength
		End Sub
	#tag EndEvent

	#tag Event
		Sub TextChanged()
		  If WasDragged Then
		    AddToUndoQueue New DragUndoAction(UndoWindow(Window).TheUndoQueue, Me, SelStartAtMouseDown, SelStart, SelText)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub TextKey(Key As String)
		  AddToUndoQueue New TypingUndoAction(UndoWindow(Window).TheUndoQueue, Me, Key, SelText, SelStart)
		  
		  //Need to update the OldSelStart so we can detect the selection changing for reasons
		  //  other than typing.
		  //Note: the current value of SelStart is still the *old* one, since the typing isn't displayed yet.
		  
		  OldSelStart = SelStart + 1
		  OldSelLength = 0
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AcquireFocus()
		  SetFocus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddText(TheText As String, TheLocation As Integer, TheLength As Integer)
		   SelStart = TheLocation //Selection is 0-based
		  SelLength = TheLength
		  SelText = TheText
		  UpdateSelStartLength
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  AddToUndoQueue New DeleteTextUndoAction(UndoWindow(Window).TheUndoQueue, Me, SelStart, SelText)
		  OldSelStart = SelStart
		  OldSelLength = 0
		  SelText = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyIt()
		  //Intended to be invoked by menu item
		  AddToUndoQueue New CopyUndoAction(Me, SelStart, SelText, GetMyUndoQueue())
		  Copy
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CutIt()
		  //Intended to be invoked by menu item
		  AddToUndoQueue New CutUndoAction(Me, SelStart, SelText, GetMyUndoQueue())
		  DisableMyUndoQueue
		  Copy
		  OldSelLength = 0
		  SelText = ""
		  EnableMyUndoQueue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteText(TheLocation As Integer, TheLength As Integer)
		  SelStart = TheLocation
		  SelLength = TheLength
		  SelText = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisableMyUndoQueue()
		  GetMyUndoQueue.DisableUndo
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnableMyUndoQueue()
		  GetMyUndoQueue.EnableUndo
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMyUndoQueue() As UndoQueue
		  Return UndoWindow(Window).TheUndoQueue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSelLength() As Integer
		  Return SelLength
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSelStart() As Integer
		  Return SelStart
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PasteIt()
		  //Intended to be invoked by menu item
		  If Theclipboard.TextAvailable Then
		    AddToUndoQueue New PasteUndoAction(UndoWindow(Window).TheUndoQueue, Me, TheClipboard.Text, SelText, SelStart)
		    
		    //Need to update the OldSelStart so we can detect the selection changing for reasons
		    //  other than typing.
		    //Note: the current value of SelStart is still the *old* one, since the typing isn't displayed yet.
		    
		    //Turn off logging actions, so we don't see the selection change as an action
		    DisableMyUndoQueue
		    SelText = TheClipboard.Text
		    EnableMyUndoQueue
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectAll()
		  SetSelection(0, Len(Text))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetSelection(NewSelStart As Integer, NewSelLength As Integer)
		  SelStart = NewSelStart
		  SelLength = NewSelLength
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateSelStartLength()
		  OldSelStart = SelStart
		  OldSelLength = SelLength
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		CurrentUndo As UndoAction
	#tag EndProperty

	#tag Property, Flags = &h0
		OldSelLength As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		OldSelStart As Integer
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
			Name="OldSelStart"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="OldSelLength"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
