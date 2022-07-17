#tag Module
Protected Module MultipleDocuments
	#tag Method, Flags = &h0
		Sub RemoveWindow(index as integer)
		  //This method removes a window from the
		  //OpenWindows() array that keeps track of those
		  //windows that are open.
		  //It also removes its name from the menu list as well.
		  //Code by David Grogono,  dave@realsoftware.com
		  
		  Dim i,j As Integer
		  
		  j = Ubound(OpenWindows)
		  
		  If j > -1 Then
		    //Don't try to remove the proxy window, since it wasn't added to all this in the first place.
		    For i = index To j-1
		      OpenWindows(i) = OpenWindows(i+1)
		      OpenWindows(i).myIndex = i
		      WindowItem(i).text = WindowItem(i+1).text
		    Next
		    
		    If j <> 0 Then  //don't close the 
		      WindowItem(j).close
		    Else
		      WindowItem(j).text = "None Open"
		    End If
		    
		    OpenWindows.remove j
		    
		    enableMenuItems
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		OpenWindows(0) As DocWindow
	#tag EndProperty

	#tag Property, Flags = &h0
		WinNum As integer
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
			Name="WinNum"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
