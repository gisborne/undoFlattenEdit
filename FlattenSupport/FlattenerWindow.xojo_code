#tag Class
Protected Class FlattenerWindow
Inherits UndoWindow
Implements Flattener
	#tag Method, Flags = &h0
		Function Flatten(f As FlattenManager) As String
		  Dim Counter As Integer
		  Dim PropertyList As DataString
		  
		  //Save state of window
		  //We assume this is a pretty regular window, so we don't try to save, say, the Backdrop.
		  //But an event is called that provides for saving extra information if required.
		  PropertyList = New DataString
		  
		  PropertyList.AddColor BackColor
		  PropertyList.AddString FloaterProcess
		  PropertyList.AddInteger Height
		  PropertyList.AddInteger Left
		  PropertyList.AddString Title
		  PropertyList.AddInteger Top
		  PropertyList.AddBoolean Visible
		  PropertyList.AddInteger Width
		  PropertyList.AddString FlattenOther(f)
		  
		  //Save state of all dynamic controls
		  For Counter = 0 To ControlCount - 1
		    If Control(Counter) IsA FlattenerControl Then
		      PropertyList.AddInteger Counter
		      PropertyList.AddString FlattenerControl(Control(Counter)).Flatten(f)
		    End If
		  Next
		  
		  Return PropertyList.Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identification() As String
		  Return RaiseEvent Identifier//Ask Subclass
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RestoreStateFromString(s As String, f As FlattenManager)
		  Dim CurrentName As String
		  Dim PropertyList As DataString
		  Dim c As Object
		  
		  //Save state of window
		  //We assume this is a pretty regular window, so we don't try to save, say, the Backdrop.
		  //But an event is called that provides for saving extra information if required.
		  PropertyList = New DataString(s)
		  
		  //Restore Window State
		  BackColor = PropertyList.FetchColor
		  FloaterProcess = PropertyList.FetchString
		  Height = PropertyList.FetchInteger
		  Left = PropertyList.FetchInteger
		  Title = PropertyList.FetchString
		  Top = PropertyList.FetchInteger
		  Visible = PropertyList.FetchBoolean
		  Width = PropertyList.FetchInteger
		  
		  //Provide an opportunity for subclasses to unflatten more stuff
		  UnFlattenOther PropertyList.FetchString, f
		  
		  //Restore state of all dynamic controls
		  While Not PropertyList.DoneFetching
		    FlattenerControl(Control(PropertyList.FetchInteger)).UnFlatten PropertyList.FetchString, f
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unflatten(s As String, f As FlattenManager, i As Integer)
		  Dim w As FlattenerWindow
		  w = NewThisWindowType
		  f.AddBeforeUnflatten w, i
		  w.RestoreStateFromString s, f
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event FlattenOther(f As FlattenManager) As String
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Identifier() As String
	#tag EndHook

	#tag Hook, Flags = &h0
		Event NewThisWindowType() As FlattenerWindow
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UnFlattenOther(s As String, f As FlattenManager)
	#tag EndHook


	#tag Note, Name = Why a window?
		The original thought was to make it easier to instantiate the proxy objects -- which represent their class, and handle flattening instances of themselves --
		by letting the user just drag them into the window. They would then be instantiated, and we could then just loop over the controls in the window when
		we wanted to get at the proxies.
		
		But they aren't controls, so that didn't work.
		
		But there was still a minor advantage, and since we didn't need any other super, we stuck with it: having Window as your Super effectively gives us a
		singleton (class of which there can only be one instance, and where that instance is automatically instantiated on application startup). Well, we don't block
		creation of new instances, but we do get instantiation for free.
		
		Also, we need to track controls separately from other flattenable things, because controls don't need to be instantiated, they just need their state restored.
		So it works pretty well to read them from controls in the window.
	#tag EndNote


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
	#tag EndViewBehavior
End Class
#tag EndClass
