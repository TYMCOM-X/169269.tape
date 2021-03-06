0001?	 maxPoints=36
    0002?	
  0003?	REM procedure allocate;
    0004?	DIM cubic( 1, maxPoints, 3 )
    0005?	DIM w( maxPoints+1 )
  0006?	DIM inv( maxPoints+1, maxPoints+1 )
  0007?	DIM points( maxPoints+1, 1 )
    0008?	RETURN
 0009?	
  0010?	
  0011?	REM numeric procedure doCubic( integer xOrY, i; numeric time );
    0012?	 y= (cubic(xOrY,i,3) * time + cubic(xOrY,i,2))
 0013?	 y=y	    * time + cubic(xOrY,i,1)) * time + cubic(xOrY,i,0)
   0014?	RETURN
 0015?	
  0016?	
  0017?	REM procedure useSpline(integer numPoints, ignore; procedure plot);
0018?	 timeInc = 1.0 / ((numPoints div segs) + 1)
                   0019?	for i_ 1 step 1 until segs	! for each segment of the curve;
   0020?	  for time_ tMin step timeInc until tMax
  0021?		xOrY = 0
   0022?		 GOSUB doCubic
  0023?		  x = y
    0024?		xOrY = 1
   0025?		 GOSUB doCubic
  0026?		GOSUB plotXY
    0027?	      next time
  0028?	  next i
    0029?	RETURN
 0030?	
  0031?	
  0032?	REM procedure nCoefficients( integer xOrY );
   0033?	u= segs+2
   0034?	for row_ 0 step 1 until u
  0035?		temp= 0
    0036?		for col_ 0 step 1 until u 
0037?		   temp= temp + inv(row,col) * points(col,xOrY)
    0038?		   next col
0039?		w(row)= temp
    0040?	      next row
             0041?	for row_ 1 step 1 until segs
    0042?	    cubic(xOrY,row,3)= (- w(row-1) +3 * w(row) -3 *w(row+1)+w(row+2))/6
 0043?	    cubic(xOrY,row,2)= (3*w(row-1) -6 * w(row) +3 * w(row+1))/6
    0044?	    cubic(xOrY,row,1)=(-3*w(row-1)	       +3 * w(row+1))/6
    0045?	    cubic(xOrY,row,0)=(   w(row-1) +4 * w(row)  +   w(row+1))/6
    0046?	    next row
0047?	RETURN
 0048?	
  0049?	
  0050?	REM procedure nMatrix;
0051?	nPoints= segs+1
  0052?	for line_ 0 step 1 until nPoints+1
   0053?	    for i_ 0 step 1 until nPoints+1
  0054?		inv(line,i)= 0
  0055?		next i
0056?	    next line
                                       0057?	for i_ nPoints step -1 until 2
  0058?	    inv(i,i)= 6
  0059?	    next i
  0060?	inv(0,0)= 2 / segs
    0061?	inv(nPoints+1, nPoints+1)= 2 / segs
  0062?	inv(1,1)= 3 
0063?	inv(1,0)= 1 / segs 
   0064?	w(1)= 2
0065?	mult= 1 / 2
 0066?	for line_ 2 step 1 until nPoints
0067?	    otherLine= line - 1
    0068?	    for i_nPoints+1 step -1 until 0
  0069?		inv(line,i)= inv(line,i) - mult * inv(otherLine,i)
 0070?		next i
0071?	    mult= 1 / (w(line)_ 4 - mult)
    0072?	    next line
    0073?	
  0074?	 line= nPoints+1
 0075?	mult= 1 / w(segs)
0076?	mult2= mult / w(nPoints) 
  0077?	mult3= 1 / (1 - mult2)
     0078?	for i_nPoints+1 step -1 until 0
 0079?	  inv(line,i)=(inv(line,i)+inv(segs,i)*mult-mult2*inv(nPoints,i))*mult3
 0080?	  next i
    0081?	for line_ nPoints step -1 until 1
    0082?	    otherLine= line + 1
    0083?	    mult= 1 / w(line)
 0084?	    for i_ nPoints+1 step -1 until 0
 0085?		inv(line,i)= (inv(line,i) - inv(otherLine,i)) * mult
    0086?		next i
0087?	    next line
    0088?	
  0089?	for i_ nPoints+1 step -1 until 0
0090?	    inv(0,i)= inv(2,i) - inv(0,i)
    0091?	    next i
  0092?	RETURN
 0093?	
  0094?	
  0095?	REM internal procedure makeSpline( integer nPoints );
                             0096?	segs= nPoints-1
  0097?	for i_ 0,1 
 0098?	    points(0,i)= (points(2,i) - points(1,i)) / segs
 0099?	    points(nPoints+1,i)= (points(nPoints,i) - points(segs,i)) / segs
    0100?	    next i
  0101?	
  0102?	GOSUB nMatrix
    0103?	xOrY=0
 0104?	 GOSUB nCoefficients
  0105?	xOrY=1
 0106?	 GOSUB nCoefficients
  0107?	
  0108?	RETURN
 0109?	
  0110?	
  0111?	END
    