
program puzzle(input,output)

LET	ANDTHEN=AND;
DEFINE !='COMMENT';

IFCR TRUE THENC
let	vector=array, matrix=array, 
	function=procedure, !procedure=procedure; 
ELSEC
define	VECTOR='safe ARRAY', MATRIX='safe ARRAY',
	FUNCTION='simple PROCEDURE', !PROCEDURE='simple PROCEDURE';
ENDC

simple integer procedure readtime; call(0,'MSTIME');

integer savedTime;

procedure settime; 
	savedTime_ readtime;

procedure timeReport(string name);
	print(crlf, name, ': ', readtime-savedTime );

 define size=511,classMax=3, typeMax=12, d=8;

let pieceClass=integer;	define pieceClass!range='0:classMax';
let pieceType=integer;	define pieceType!range='0:typeMax';
let position=integer;	define position!range='0:size';

integer vector pieceCount[pieceClass!range];	! of 0 .. 13;
pieceClass vector class[pieceType!range];
position vector pieceMax[pieceType!range];
boolean vector puzzle[position!range];
boolean matrix p[pieceType!range,position!range];
position m,n;
integer i,j,k;	! 0 .. 13;
integer kount;	! literally 'integer';
 boolean function fit( pieceType i; position j );
begin
	position k;
!	position plim;
! plim_ pieceMax[i];
! for k_ 0 upto plim 
; for k_ pieceMax[i] downto 0
   do if p[i,k] andThen puzzle[j+k]
	then return(false);
return(true);
end;
 position function place( pieceType i; position j );
begin
	position k;
!	position plim;
! plim_ pieceMax[i];
! for k_ 0 upto plim 
; for k_ pieceMax[i] downto 0
   do if p[i,k] then puzzle[j+k]_ true;
pieceCount[class[i]]_ pieceCount[class[i]] - 1;
for k_ j upto size
   do if not puzzle[k] then return(k);
print(crlf& 'Puzzle filled');
return(0);
end;
 !procedure remove( pieceType i; position j );
begin
	position k;
!	position plim;
! plim_ pieceMax[i];
! for k_ 0 upto plim 
; for k_ pieceMax[i] downto 0
   do if p[i,k] then puzzle[j+k]_ false;
pieceCount[class[i]]_ pieceCount[class[i]] + 1;
end;
 boolean recursive procedure trial( position j );
begin
	pieceType i;
	position k;
kount_ kount+1;	! code motion ** (was just before exit);
for i_ 0 upto typeMax
   do if pieceCount[class[i]] ! neq 0;
	andThen fit(i,j)
	 then begin
		k_ place(i,j);
		if ! trial(k) or k=0; k=0 or trial(k)
		 then begin
			print(crlf& 'Piece', i+1, ' at', k+1 );
			return(true);
		      end
		 else remove(i,j);
	      end;
return(false);
end;
 setprint(null,'B');
settime;
arrclr(puzzle,true);
for i_ 1 upto 5 do for j_ 1 upto 5 do for k_ 1 upto 5
   do puzzle[i+d*(j+d*k)]_ false;
arrclr(p,false);


	for i_ 0 upto 3 do for j_ 0 upto 1 do for k_ 0 upto 0
	   do p[0,i+d*(j+d*k)]_ true;
	class[0]_ 0;
	pieceMax[0]_ 3+ d*1 + d*d*0;

	for i_ 0 upto 1 do for j_ 0 upto 0 do for k_ 0 upto 3
	   do p[1,i+d*(j+d*k)]_ true;
	class[1]_ 0;
	pieceMax[1]_ 1+ d*0 + d*d*3;

	for i_ 0 upto 0 do for j_ 0 upto 3 do for k_ 0 upto 1
	   do p[2,i+d*(j+d*k)]_ true;
	class[2]_ 0;
	pieceMax[2]_ 0+ d*3 + d*d*1;

	for i_ 0 upto 1 do for j_ 0 upto 3 do for k_ 0 upto 0
	   do p[3,i+d*(j+d*k)]_ true;
	class[3]_ 0;
	pieceMax[3]_ 1+ d*3 + d*d*0;

	for i_ 0 upto 3 do for j_ 0 upto 0 do for k_ 0 upto 1
	   do p[4,i+d*(j+d*k)]_ true;
	class[4]_ 0;
	pieceMax[4]_ 3+ d*0 + d*d*1;

	for i_ 0 upto 0 do for j_ 0 upto 1 do for k_ 0 upto 3
	   do p[5,i+d*(j+d*k)]_ true;
	class[5]_ 0;
	pieceMax[5]_ 0+ d*1 + d*d*3;


	for i_ 0 upto 2 do for j_ 0 upto 0 do for k_ 0 upto 0
	   do p[6,i+d*(j+d*k)]_ true;
	class[6]_ 1;
	pieceMax[6]_ 2+ d*0 + d*d*0;

	for i_ 0 upto 0 do for j_ 0 upto 2 do for k_ 0 upto 0
	   do p[7,i+d*(j+d*k)]_ true;
	class[7]_ 1;
	pieceMax[7]_ 0+ d*2 + d*d*0;

	for i_ 0 upto 0 do for j_ 0 upto 0 do for k_ 0 upto 2
	   do p[8,i+d*(j+d*k)]_ true;
	class[8]_ 1;
	pieceMax[8]_ 0+ d*0 + d*d*2;


	for i_ 0 upto 1 do for j_ 0 upto 1 do for k_ 0 upto 0
	   do p[9,i+d*(j+d*k)]_ true;
	class[9]_ 2;
	pieceMax[9]_ 1+ d*1 + d*d*0;

	for i_ 0 upto 1 do for j_ 0 upto 0 do for k_ 0 upto 1
	   do p[10,i+d*(j+d*k)]_ true;
	class[10]_ 2;
	pieceMax[10]_ 1+ d*0 + d*d*1;

	for i_ 0 upto 0 do for j_ 0 upto 1 do for k_ 0 upto 1
	   do p[11,i+d*(j+d*k)]_ true;
	class[11]_ 2;
	pieceMax[11]_ 0+ d*1 + d*d*1;


	for i_ 0 upto 1 do for j_ 0 upto 1 do for k_ 0 upto 1
	   do p[12,i+d*(j+d*k)]_ true;
	class[12]_ 3;
	pieceMax[12]_ 1+ d*1 + d*d*1;

pieceCount[0]_ 13;
pieceCount[1]_ 3;
pieceCount[2]_ 1;
pieceCount[3]_ 1;
m_ 1+d*(1+d*1);
kount_0;
timeReport('Initialization');
if fit(0,m) then n_ place(0,m) else print(crlf& 'Error 1');
if trial(n) then print(crlf& 'Success in ', kount, ' trials')
 else print(crlf, 'Failure');
timeReport('Completion');
end;
 