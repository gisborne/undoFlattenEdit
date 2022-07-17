#tag Window
Begin FlattenSupport.FileFlattenWindow DocWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   BalloonHelp     =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   HasFullScreenButton=   False
   Height          =   710
   ImplicitInstance=   True
   LiveResize      =   "False"
   MacProcID       =   0
   MaxHeight       =   300
   MaximizeButton  =   True
   MaxWidth        =   300
   MenuBar         =   -1193685874
   MenuBarVisible  =   True
   MinHeight       =   300
   MinimizeButton  =   True
   MinWidth        =   300
   Placement       =   4
   Resizeable      =   True
   Title           =   "Untitled"
   Visible         =   False
   Width           =   592
   Begin Kontrols.FlattenEditField EditField1
      Index           =   -2147483648
      InitialParent   =   ""
      LockedInPosition=   False
      Scope           =   0
      TabPanelIndex   =   "0"
   End
   Begin Kontrols.RedoMenu TheRedoMenu
      Index           =   -2147483648
      InitialParent   =   ""
      LockedInPosition=   False
      Scope           =   0
      TabPanelIndex   =   "0"
   End
   Begin Kontrols.UndoMenu TheRedoMenu1
      Index           =   -2147483648
      InitialParent   =   ""
      LockedInPosition=   False
      Scope           =   0
      TabPanelIndex   =   "0"
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  Dim f As FolderItem
		  If Dirty Then
		    DontSaveCancelSave.Display("Save changes to " + Chr(34) + Title + Chr(34) + " before closing?")
		    Select Case DontSaveCancelSave.ButtonPushed
		    Case "Cancel"
		      Return True
		    Case "Save"
		      If SaveFile = Nil Then
		        f = GetSaveFolderItem("text/UndoEdit", "")
		        If f = Nil Then
		          Return True
		        Else
		          Self.FileSave
		        End If
		      End If
		    End Select
		  End If
		  
		  Finally
		    DontSaveCancelSave.Close
		End Function
	#tag EndEvent

	#tag Event
		Function Identifier() As String
		  //A unique identifier for the class, stored with flattened instances, so we know where to go for the code to unflatten it.
		  Return "DocWIndow"
		End Function
	#tag EndEvent

	#tag Event
		Function NewThisWindowType() As FlattenerWindow
		  //The constructor is not getting called, so we have to go around the block like this.
		  
		  Return New DocWindow
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			Self.Close
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSave() As Boolean Handles FileSave.Action
			Self.FileSave
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSaveAs() As Boolean Handles FileSaveAs.Action
			Dim f As FolderItem
			
			f = GetSaveFolderItem("text/UndoEdit", "")
			
			If f <> Nil Then
			SaveFile = f
			
			Self.FileSave
			End If
		End Function
	#tag EndMenuHandler


	#tag Property, Flags = &h0
		TheUndoQueue As UndoSupport
	#tag EndProperty


#tag EndWindowCode

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
