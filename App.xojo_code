#tag Class
Protected Class App
Inherits DesktopApplication
	#tag Event
		Sub DocumentCreated()
		  OpenNewDoc//Optional if you don't want DocWindow to open automatically
		End Sub
	#tag EndEvent

	#tag Event
		Sub DocumentOpened(item As FolderItem)
		  Dim w As DocWindow
		  Dim i As Integer
		  Dim m As menuItem
		  Dim t As String
		  
		  w = New DocWindow
		  
		  OpenWindows.append w
		  
		  i = OpenWindows.UBound
		  w.myIndex = i
		  
		  t = "Untitled "+Str(winNum+1)
		  w.title = t
		  
		  If i = 0 Then
		    WindowItem(0).text = t
		  Else
		    m = New WindowItem
		    m.text = t
		  End If
		  
		  winNum = winNum + 1
		End Sub
	#tag EndEvent

	#tag Event
		Sub MenuBarSelected()
		  dim i as integer
		  
		  AppleAbout.Enable
		  FileNew.enable
		  FileOpen.Enable
		  
		  if Ubound(OpenWindows)>-1 then
		    for i = 0 to Ubound(OpenWindows)
		      if WindowItem(i)<> nil then
		        WindowItem(i).enable
		      end if
		    next
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  //Initialize the undo and flatten framework
		  UndoSupport.InitialiseUndo
		  UndoSupport.InitialiseFlattenSupport
		  
		  //Initialize the multiple documents framework
		  //Code by David Grogono,  dave@realsoftware.com
		  
		  Redim OpenWindows(-1)
		  
		  EnableMenuItems
		  
		  Me.RegisterFlattenClasses
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function AppleAbout() As Boolean Handles AppleAbout.Action
			AboutWIndow.ShowModal
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileNew() As Boolean Handles FileNew.Action
			OpenNewDoc
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileOpen() As Boolean Handles FileOpen.Action
			Dim f As FolderItem
			Dim t As BinaryStream
			
			f = GetOpenFolderItem("application/UndoEdit")
			
			If f <> Nil Then
			t = f.OpenAsBinaryFile(False)
			
			FlattenSupport.FlattenManager.Clear
			FlattenSupport.FlattenManager.Unflatten t.Read(t.Length)
			
			t.Close
			End If
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function WindowItem(index as Integer) As Boolean Handles WindowItem.Action
			OpenWindows(index).show
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub OpenNewDoc()
		  Dim w As DocWindow
		  Dim i As Integer
		  Dim m As menuItem
		  Dim t As String
		  
		  w = New DocWindow
		  OpenWindows.append w
		  
		  i = Ubound(OpenWindows)
		  w.myIndex = i
		  
		  t = "Untitled "+Str(winNum+1)
		  w.title = t
		  
		  If i = 0 Then
		    WindowItem(0).text = t
		  Else
		    m = New WindowItem
		    m.text = t
		  End If
		  
		  winNum = winNum + 1
		  w.Visible = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RegisterFlattenClasses()
		  FlattenManager.RegisterProxy _
		  New Kontrols.FlattenEditField, _
		  New FlattenSupport.FlattenUndoRedoMenu
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoQuit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowHiDPI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BugVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Copyright"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastWindowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MajorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NonReleaseVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RegionCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_CurrentEventTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
