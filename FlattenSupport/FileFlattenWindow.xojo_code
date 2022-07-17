#tag Class
Protected Class FileFlattenWindow
Inherits UndoFlattenerWindow
Implements UndoQueueListener
	#tag Event
		Sub Close()
		  RemoveWindow(myIndex)
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  FileClose.Enable
		  If Dirty Then
		    If SaveFile = Nil Then
		      FIleSave.CommandKey = ""
		      FileSaveAs.CommandKey = "S"    // <-- CONVERTED
		    Else
		      FileSave.Enable
		      FileSave.CommandKey = "S"
		      FileSaveAs.CommandKey = "Shift-S"    // <-- CONVERTED
		    End If
		  End If
		  FileSaveAs.Enable    // <-- CONVERTED
		  
		  //We have a problem: the selChange event was getting fired on a selection change, after any UndoActions had entirely
		  //  finished processing. Thus, they had turned the undoQueue tracking off but back on again.
		  //Since this event fires *after* selChange, and we know that this is when user events are getting processed, we turn
		  //  undo tracking on here instead.
		  Self.TheUndoQueue.EnableUndo
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  TheUndoQueue.AddListener Me
		  Open
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub ClearDirty()
		  Dirty = False
		  SetDirtyIndicator False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(f As FolderItem)
		  Dim t As TextInputStream = f.OpenAsTextFile
		  
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub FileSave()
		  Dim t As BinaryStream
		  //Pre: SaveFile property is a valid FolderItem
		  //Post: The Flattened form of this window is written to SaveFile, overwriting SaveFile's contents
		  t = SaveFile.CreateBinaryFile("application/UnDoEdit")
		  
		  FlattenManager.Clear
		  FlattenManager.Add Me
		  
		  t.Write FlattenManager.GetTheFlattenedString
		  t.Close
		  
		  Title = SaveFile.Name
		  ClearDirty
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDirtyIndicator(b As Boolean)
		  #if Target68k then
		    // No 68k code
		  #else
		    
		    Dim osErr As Integer
		    dim v as variant
		    
		    #if TargetMacOS And Not TargetMachO then
		      #if TargetCarbon then
		        Declare Function SetWindowModified Lib "CarbonLib" (window As WindowPtr, modified As Integer) As Integer
		      #else
		        Declare Function SetWindowModified Lib "WindowsLib" (window As WindowPtr, modified As Integer) As Integer
		      #endif // TargetCarbon
		      
		      v=b
		      Call SetWindowModified(Me,v)
		    #endif // TargetMacOS
		    
		  #endif // Target68k
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UndoQueueChanged()
		  Dirty = True
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return IsDirty
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  IsDirty = True
			  SetDirtyIndicator True
			End Set
		#tag EndSetter
		Protected Dirty As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected IsDirty As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		MyIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected SaveFile As FolderItem
	#tag EndProperty


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
		#tag ViewProperty
			Name="MyIndex"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
