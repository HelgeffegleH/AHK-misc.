_GuiCreate(p*){
	local
	return ctrl_gui(guiCreate(p*), p[3])
	; Nested function
	ctrl_gui(o, es := "") {
		; creates a Control or Gui object wrapper object
		; o - a Control or Gui object to wrap
		; es - gui event sink object, optional.
		w :=	{	; wrapper object
					base 		: { __call : func("__call"), base : o, __class : type(o) },	; setting the object being wrapped (o) as base enables
																							; all properties to work with out any extra code.
					__es__ 		: es,	; event sink
					__cbfns__	: [],	; callback functions (for onevent)
					__ctrls__ 	: [],	; the controls of the gui, for _NewEnum
				}
		w._newenum := type(o) == "Gui"	?  (this) =>	{	; enumerator object
															enum : this.__ctrls__._newenum(), 
															next : (this, byref k, byref v := "") 
																	=>	this.enum.next(,v) 
																		? (k:=v.hwnd,true) 
																		: false
														} 
										:	func("noenum")	; Only gui objects have _newenum
		return w

		;
		; nested functions
		;
		__call(this, fn, p*){
			; Handles all calls to the wrapper object (this), returning the wrapper object itself, or the new control in
			; case the the wrapper wraps a Gui object and the methods is addXXX(...) or add("XXX",...)
			;
			; this - the wrapper object.
			; fn - the method to call.
			; p - method parameters.
			local
			if type(this) == "Gui" && instr(fn, "add") == 1 {
				i := this.__ctrls__.push( ctrl_gui((this.base)[fn](p*), this.__es__) )	; save control for _newenum
				return this.__ctrls__[i] 	; return the new control wrapper
			} else if fn = "onevent" {		; Events require special handling, see createEventRouter()
				createEventRouter(this, this.__es__, p)
			} else {
				(this.base)[fn](p*)			; call the method
			}
			return this						; return the wrapper object to enable chaining
		}
		createEventRouter(this, es, p){	
			; this function does one of two things:
			; 1) creates a callback function which directs events to the udf callback function,
			; passing the wrapper object instead of the actual control / gui object.
			; 2) removes the callback.
			; In both cases, the wrapper object is returned
			local
			; this - the wrapper object
			; es - the gui's event sink (if exist)
			; p - onevent parameters
			if p.haskey(3) && !p[3] { ; remove callback function
				cbfn := this.__cbfns__.delete(p[2])
			} else {	; add callback function, creates a router function.
				cbfn := isobject(es) && type(p[2]) == "String"	?	(ctrlOrGui) => isobject(m:=es[p[2]]) ? m.call(es, this) : %p[2]%(this)	; event sink / function name
																:	(ctrlOrGui) => %p[2]%(this)												; function name / func/... obj.
				this.__cbfns__[p[2]] := cbfn
			}
			oep := [p[1], cbfn] 				; onevent parameters
			p.haskey(3) ? oep.push(p[3]) : ""	; only add last param if exist, passing a blank would mean "do not call the callback".
			this.base.onevent(oep*)				; this.base is the gui or control object, 
			return this			
		}
		noenum(p*){ ; For correct error message when using _newenum on a control.
			throw exception("Unknown method.", -1, "_NewEnum")
		}
	}
}

