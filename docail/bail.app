
   
   		Black Artist's Appendix
   
   	Producing and maintaining languages and compilers for 
   production use is still a form of witchcraft.  The following are
    offered for the edification of future black artists.
 
   	Execution-time objects whose representation requires more
than one word of memory must have a one-word "handle".  The handle
  contains a pointer to the object and may contain flag bits or counts,
    etc.  Indirection through the handle should be valid and should
produce meaningful results.
                                                                                                          
   	In SAIL, strings are represented by two words:
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          a word with character count and garbage collector mark
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        bits, followed by a PDP-10 byte pointer.  However, there is no
 handle. This has caused numerous problems and makes the implementation
   inelegant.  There is a separate register dedicated at runtime to the
maintenance of a string stack.  String operations are expensive
in space, since two words must be moved around for each string.
Many compiler bugs had (have) their origin in the fact that a 
 string itemvar, a string, an integer itemvar, and an integer are
    in four distinct classes, rather than two (itemvar or non-itemvar).
                                                                                                A better representation for strings is

       handle:  BYTE (13)length (23)@bytepointer.
  
   Then the length, byte pinter, and first character of the string are
 all accessible in one instruction once the handle is known.
    [The accesses are LDB AC,[POINT 13,HANDLE,12]; MOVE AC,@HANDLE;
and ILDB AC,@HANDLE.]  The garbage collector can use the left
  half of the byte pointer for marking, since there is redundant
 information which can be temporarily destroyed and later reconstructed.
  
   	SAIL does use handles for arrays.  Each array has an allocation
                                                                cell which points to the array descriptor.  However array descriptors
    are contiguous to the array data.  Thus it is impossilbe to pass
    subarrays or array slices as arguments.  Moral: array descriptors
   should be separate from array data.  A good representation is
  
       handle:  @descriptor
    
       descriptor:  @data
 		 flags,,total size
   		 dimension number, bounds, multipliers, offset

       data:  BLOCK total size
 
   Then	MOVE	AC,HANDLE	gets the address of the descriptor
    	MOVEI	AC,@HANDLE	gets the address of the first data word
 
   
                                                     	SAIL code for expression evaluation is not very good.  This is due
 to strict one-pass compilation.  A very messy (and buggy) part of the
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   compiler has to do with generating code "on the fly" for boolean expressions.
 To retain the speed advantage of one pass but generate much better code,
 the solution is to adopt one-and-a-half-pass compilation.  The parser
    should construct parse trees until an assignment expression is detected,
 and then code for the assignment should be generated.  This would easily
 allow compilations such as
  
   	I_I+1;			AOS  AC,I
                                                                                                                                                                                                            
   	I_I+J;			MOVE  AC,J
   				ADDB  AC,I
    
   	I_IF B THEN K ELSE J	MOVE  AC,K
 				SKIPN  B
 				MOVE  AC,J
    				MOVEM  AC,I
   
   rather than the longer, straight-forward way they are now compiled.
                                                                                                                                                                                                                                                                                                                                                                                                                                     Similarly, doubled-up skips and redundant subscripting could be
improved.  The effect would be substantially getter code, for
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                a very modest increase in compilation time.

   
   
   
   
   
   
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
   
   
   
   
   
   
   
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
   
   
   
   
   
   
   
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           