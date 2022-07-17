#tag Module
Protected Module FlattenNotes
	#tag Note, Name = How to implement flattening in your application
		There are two steps to implementing flattening:
		
		1. Find a natural starting point. This will be an object that isn't referred to by another (such as a window),
		or if you're flattening a subgraph, you can start from an object in the subgraph you wish to attach to
		an existing object. The important thing is that all the objects you need to flatten can be reached from the
		object(s) you start from, by traversing the object reference graph.
		
		In the example application, we start from a window. The whole thing is kicked off in FileFlattenWindow.FileSave
		
		2. For each non-abstract class whose instances will be flattened, implement the Flattener or the
		FlattenerControl interface.
		
		The Identificiation() call should return a string that is unique to the class. Almost certainly, just use the name
		of the class.
		
		In the Flatten() function, return a string representation of the object's state. You can do this however you
		wish, as long as you flatten object references by calling f.KeyFromObject, but you will probably use a
		DataString (which supports reading back a sequence of scalars in the same order they were written).
		Although there is no example of it in this application, you may find the MultiString useful. It only stores
		strings.
		
		The Unflatten method is called on the proxy. Note that carefully. It should create an instance of your class
		and pass it to f.AddBeforeUnflatten. It can then immediately invoke RestoreStateFromString on the new
		instance.
		
		RestoreStateFromString will then reverse the process of Flatten(). If you used a DataString, just read
		the same scalars out in the same order, and convert object IDs back into object references by calling
		f.ObjectFromKey.
		
		
		A good example of doing this is the UndoQueue class.
		
		Note that it doesn't need to do anything fancy. It stores an array, for example, by writing an integer
		(the array's length), followed by that many object reference IDs.
	#tag EndNote

	#tag Note, Name = On flattening shared properties and modules
		The flatten framework was written before REALbasic supported shared properties, and currently has no
		explicit support for these. And it never explicitly supported flattening modules.
		
		Honestly, there isn't a whole lot the framework can do to make it easier to flatten these things, because
		they aren't first class objects, and we have no introspection, so there is no way to generalize about them.
		
		If you need to flatten such things, though, it wouldn't be hard; it just has to be custom-written for your
		particular use.
		
		What you would do is to store the results of GetTheFlattenedString to flatten your data structure, then
		include *that* string as part of a larger string that also includes this other state you want to save.
		
		If you need to store object references as part of that, you would use KeyFromObject as normal, just
		make sure you do that before you do GetTheFlattenedString.
	#tag EndNote

	#tag Note, Name = Overview of flattening
		Handled by the FlattenManager
		
		Some issues we deal with:
		
		- reading a file into a later version of the program, which supports more or different classes (so each object in the file can be mapped to a class
		*name*, based solely on information in the file)
		- multiple references to the same object
		- we can't just flatten rectControl objects in windows, because we don't create new instances of these objects -- we just have to restore their state
		- scalars require special handling
		- most objects are just referred to by other objects, so will be created when those objects are unflattened, but certain objects just *are* (eg Windows)
		- while unflattening, we need to build complex structures, going back and providing references to objects that we hadn't yet unserialized, once we have
		them
		
		
		Overview of flattening
		
		We start from some object, and ask it to flatten itself, through the flattener interface. It is expected to return a string representation of itself. It will
		build the string probably as a DataString (although it is free to do whatever is appropriate, assuming it respects the need to register object references),
		
		The object converts its object references to a numeric identifier by calling KeyFromObject, which will return a reference to an object, first asking it to
		flatten itself as needed. Thus, flattening is depth-first, but cached, thus avoiding being trapped by reference cycles and only storing each object once.
		
		Scalar values in the object are just added to the string through the object serialization calls in the FlattenSupport module.
		
		Note that as we go, we keep separate track of mappings of each object's identifier to:
		
		- its location (start and length) in the string representing the objects' state; and
		- its type number (which maps, in turn, to its proxy object)
		
		We also keep:
		
		- a mapping of type numbers to the proxy objects' names (which they provide as part of their interface)
		
		Thus, an object is eventually flattened and unflattened through its class name, part of the Flattener interface. So if we later add new classes, or modify existing ones,
		  we can still read old files if we provide proxy objects with the old class names.
		
		We build separate strings for:
		
		- the flattened objects (as a MultiString, which pulls out variable-length sub-strings one after another);
		- the mapping from object identifier to object location within the first string;
		- the mapping from object number to type number;
		- the mapping from type number to proxy name; and
		- the "main objects", which must be explicitly unflattened, because there is no explicit reference to them from
		  another object.
		
		We put all these together into a MultiString, so we can read them back out in the same order.
	#tag EndNote

	#tag Note, Name = Overview of unflattening
		The chief problem with unflattening is: as we create an object, how do we provide it with references to an object we
		haven't yet unflattened?
		
		Overview of unflattening
		
		Handled by the FlattenManager
		
		We begin by pulling out the main data objects we have:
		
		- the flattened objects (as a MultiString, which pulls out variable-length sub-strings one after another);
		- the mapping from object identifier to object location within the first string;
		- the mapping from object number to type number;
		- the mapping from type number to proxy name; and
		- the "main objects", which must be explicitly unflattened, because there is no explicit reference to them from
		another object.
		
		The mappings are unflattened by the constructors for the relations we used.
		
		Then, we just cycle thorugh our list of "main objects", unflattening them, by calling unflatten on their proxies.
		
		In order to handle the aforementioned problem, the proxy is expected to unflatten the object in two stages:
		
		1. Create the object, but don't restore its state, and register it via FlattenManager.AddBeforeUnflatten
		2. Call the object's RestoreStateFromString, passing it the string it originally provided when flattening itself.
		
		In step 2, the object will obtain references to objects by passing their reference numbers to
		  FlattenManager.ObjectFromKey, which fetches the object reference from the cache if available, otherwise it recursively
		  rebuilds the object from its location in the string.
		
		Note how having the proxy store the object in the cache *before* unflattening its state lets us rebuild our object
		  reference by a depth-first traversal of the graph. We have a reference to Object A, and we obtain references to A, along
		  with all the objects A refers to, before we restore A's references themselves.
	#tag EndNote


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
End Module
#tag EndModule
