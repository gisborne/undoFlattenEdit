#tag Class
Protected Class FlattenManager
	#tag Event
		Sub Open()
		  Constructor//Bug: Constructor not called.
		  Open
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(f As Flattener)
		  //Objects added through this call will be explicitly unflattened.
		  //All such objects must attach themselves to the application directly.
		  //All other objects must be referenced by Main Objects. It is presumed that all the remaining
		  //  objects will be requested in the process of recursively rebuilding the Main objects.
		  
		  //The simple-looking KeyFromObject recursively adds all references of the object, along with
		  //  the object itself, before returning its identifier
		  MainObjects.AddInteger KeyFromObject(f)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddBeforeUnflatten(f As Flattener, i As Integer)
		  //Store an object before it's been unflattened.
		  //A proxy should create the object and return it, then call its RestoreStateFromString.
		  //Since all objects will be registered by ID *before* they are unflattened, recursive references will work just fine.
		  TheFlatteners.Add(f, i)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  //Clears residue from last flatten or unflatten operation.
		  //Doesn't remove proxies.
		  ObjectNumToLocation = New ObjectNum_SpanRelation
		  ObjectNumToTypeNum = New Int_IntRelation
		  TheFlatteners = New Flatten_KeyRelation
		  MainObjects = New DataString
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Dim Counter As Integer
		  Dim CurrentFlattener As Flattener
		  
		  Clear//Sets most of the properties to new
		  
		  //These store the proxies, so don't need to be reset in Clear
		  TypeList = New String_IntRelation
		  TheProxies = New Flatten_KeyRelation
		  
		  //Register the classes in the window
		  For Counter = 0 To ControlCount - 1
		    If Control(Counter) IsA Flattener Then
		      RegisterProxy Flattener(Control(Counter))
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTheFlattenedString() As String
		  //Packs the information in the reverse of the order in which we unpack it. See Me.Unflatten.
		  Dim TheString As MultiString
		  
		  TheString = New MultiString
		  
		  TheString.Add TheObjectsString
		  TheString.Add ObjectNumToLocation.Flatten(Me)
		  TheString.Add ObjectNumToTypeNum.Flatten(Me)
		  TheString.Add TypeList.Flatten(Me)
		  TheString.Add MainObjects.Result
		  
		  Return TheString.TheString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function KeyFromObject(TheObject As Object) As Integer
		  //This ensures that f has been flattened, and returns its identifying integer.
		  Dim f As Flattener
		  Dim ObjectIdentifier, StartingPosition, Length As Integer
		  Dim TheFlattenedObject As String
		  Dim c As Control
		  
		  //Objects to be flattened must support the flattener interface, or be Kontrols. Controls are handled below.
		  If TheObject IsA Flattener Then
		    f = Flattener(TheObject)
		    
		    //Store the object, along with any objects to which it refers
		    If Not TheFlatteners.Contains(f) Then
		      //We just allocate identifiers sequentially
		      ObjectIdentifier = ObjectNumToTypeNum.UBound + 1
		      
		      //Then we map the identifier to the identifier for the type (a number, which maps to the class proxy)
		      ObjectNumToTypeNum.Add ObjectIdentifier, TypeList.IntFromString(f.Identification)
		      
		      //And we map the object to its identifier
		      TheFlatteners.Add f, ObjectIdentifier
		      
		      //Now, we ask it to flatten itself. It will call Add on any objects it has references to, which call this
		      TheFlattenedObject = f.Flatten(Me)
		      //We don't just add it straight onto TheObjectsString, because it might recursively add other objects,
		      //  which screws up working out which part of the string is this object
		      StartingPosition = Len(TheObjectsString) + 1
		      TheObjectsString = TheObjectsString + TheFlattenedObject
		      Length = Len(TheObjectsString) - StartingPosition + 1
		      
		      //Now we know exactly which part of the string is this object, we map its identifier to this information
		      ObjectNumToLocation.Add ObjectIdentifier, StartingPosition, Length
		    Else
		      Return TheFlatteners.KeyFromFlatten(f)
		    End If
		    
		    Return ObjectIdentifier
		    
		    //RectControls are handled separately, since we can't just instantiate them, but we must instead restore their state into a thing already
		    //  in existence, in a window
		  ElseIf TheObject IsA RectControl Then
		    //We use a single, negative integer to represent a control in a window.
		    //The value returned is -(the window's identifier, multiplied by 1 million, plus the control number within the window)
		    Return ControlIdentifier(RectControl(TheObject), Me)
		  Else
		    Raise New NotAFlattenerException(TheObject)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectFromKey(i As Integer) As Object
		  Dim TypeName As String
		  Dim WindowNum, ControlNum As Integer
		  Dim ObjectStart As Integer//Where i is within TheObjectsString
		  //Retrieve the object whose key is i from the Dictionary.
		  //If there is no such object, fetch it from the string.
		  If i >= 0 Then//Controls have negative IDs
		    If TheFlatteners.Contains(i) Then
		      Return TheFlatteners.FlattenFromKey(i)
		    Else
		      //Unflatten the object
		      //Find the type name from the number
		      TypeName = TypeList.StringFromInt(ObjectNumToTypeNum.Key2FromKey1(i))
		      //Unflatten the object from within TheObjectsString
		      ObjectStart = ObjectNumToLocation.NthStart(i)
		      If i = ObjectNumToLocation.UBound Then//If the object is at the end of the string
		        ObjectProxyFromTypeName(TypeName).UnFlatten(Mid(TheObjectsString, ObjectStart), Me, i)
		        Return TheFlatteners.FlattenFromKey(i)
		      Else
		        ObjectProxyFromTypeName(TypeName).UnFlatten(Mid(TheObjectsString, ObjectStart, ObjectNumToLocation.NthLength(i)), Me, i)
		        Return TheFlatteners.FlattenFromKey(i)
		      End If
		    End If
		  Else
		    //Extract window ID and control number from i
		    WindowNum = (-i) \ ControlModulus
		    ControlNum = (-i) Mod ControlModulus - 1//We subtracted 1 to make sure it was negative.
		    Return FlattenerWindow(ObjectFromKey(WindowNum)).Control(ControlNum)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ObjectProxyFromTypeName(s As String) As Flattener
		  //We don't go direct to the objects on the form in case the control enumeration changes.
		  //Instead, we use the names.
		  Return TheProxies.FlattenFromKey(TypeList.IntFromString(s))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectStringFromKey(k As Integer) As String
		  //We need this, because we can't create controls from a proxy; we have to already have the control, and get it to unflatten its
		  //  state. So we flatten it regularly, then unflatten it from its string once we've unflattened its window.
		  Dim ObjectStart As Integer
		  
		  ObjectStart = ObjectNumToLocation.NthStart(k)
		  Return Mid(TheObjectsString, ObjectStart, ObjectNumToLocation.NthLength(k))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RegisterProxy(ParamArray fs() As Flattener)
		  For Each f As Flattener In fs
		    Me.RegisterProxy f
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RegisterProxy(f As Flattener)
		  //Call this to register a proxy, so that the proxy's type can be flattened/unflattened
		  Dim Key As Integer
		  
		  Key = TypeList.UBound + 1
		  TypeList.Add f.Identification, Key
		  TheProxies.Add f, Key
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unflatten(s As String)
		  Dim MainObjects As DataString
		  Dim TheString As MultiString
		  Dim Counter, ObjectsUBound As Integer
		  Dim Dummy, RTProxy As Flattener
		  Dim FTTypeName As String
		  Dim FTTypeNum, NextObjectNum As Integer
		  Dim v As Object
		  Dim x As String
		  
		  TheString = New MultiString
		  TheString.SetString s
		  
		  //UnFlatten the various bits
		  TheString.BeginReading
		  MainObjects = New DataString(TheString.NextString)
		  
		  //MainObjects is a list of the "top-level" objects, which need to be explicitly unpacked.
		  //All other objects are referenced by them.
		  RTTypeList = New String_IntRelation(TheString.NextString, Me)//Object Type Name-Type Number list
		  ObjectNumToTypeNum = New Int_IntRelation(TheString.NextString, Me)
		  ObjectNumToLocation = New ObjectNum_SpanRelation(TheString.NextString, Me)
		  TheObjectsString = TheString.NextString
		  ObjectsUBound = ObjectNumToTypeNum.UBound
		  
		  //Build RT_FT type relation
		  RTProxy_FTKeyRelation = New Flatten_KeyRelation
		  For Counter = 0 To TypeList.UBound
		    FTTypeNum = RTTypeList.IntValue(Counter)
		    FTTypeName = RTTypeList.StringValue(Counter)
		    //Look up the RT equivalent
		    RTProxy = TheProxies.FlattenFromKey(TypeList.IntFromString(FTTypeName))
		    RTProxy_FTKeyRelation.Add RTProxy, FTTypeNum
		  Next
		  
		  While Not MainObjects.DoneFetching
		    NextObjectNum = MainObjects.FetchInteger
		    RTProxy_FTKeyRelation.FlattenFromKey(ObjectNumToTypeNum.Key2FromKey1(NextObjectNum)).UnFlatten(Mid(TheObjectsString, ObjectNumToLocation.NthStart(NextObjectNum), ObjectNumToLocation.NthLength(NextObjectNum)), Me, NextObjectNum)
		  Wend
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h1
		Protected MainObjects As DataString
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected ObjectNumToLocation As ObjectNum_SpanRelation
	#tag EndProperty

	#tag Property, Flags = &h0
		ObjectNumToTypeNum As Int_IntRelation
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected RTProxy_FTKeyRelation As Flatten_KeyRelation
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected RTTypeList As String_IntRelation
	#tag EndProperty

	#tag Property, Flags = &h0
		TheFlatteners As Flatten_KeyRelation
	#tag EndProperty

	#tag Property, Flags = &h0
		TheObjectsString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TheProxies As Flatten_KeyRelation
	#tag EndProperty

	#tag Property, Flags = &h0
		TypeList As String_IntRelation
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
			Name="TheObjectsString"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
