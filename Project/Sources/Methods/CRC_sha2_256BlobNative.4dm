//%attributes = {"invisible":true}

  //================================================================================
  //@xdoc-start : en
  //@name : CRC_sha2_256Blob
  //@scope : public
  //@deprecated : no
  //@description : This function generates a sha2-256 hash for data from a blob 
  //@parameter[0-OUT-sha2_256Binary-BLOB] : sha2-256 hash in binary format
  //@parameter[1-IN-blobPtr-POINTER] : blob pointer (not modified)
  //@notes :
  //  http://en.wikipedia.org/wiki/SHA
  //@example : CRC_sha2_256Blob
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 04/08/2009, 10:25:22 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BLOB:C604($0;$vx_sha256ResBlob)  //*$0 <-- SHA2-256 checksum
C_POINTER:C301($1;$vp_dataPtr)  //*$1 --> Data pointer

ASSERT:C1129(Count parameters:C259>0;"should have 1 parameter")
ASSERT:C1129(Type:C295($1->)=Is BLOB:K8:12;"dataPtr/$1 should be a blob pointer")

$vp_dataPtr:=$1

  //C_ENTIER LONG($vl_ms)
  //$vl_ms:=Nombre de millisecondes

  //Initialize variables
  //(first 32 bits of the fractional parts of the square roots of the first 8 primes 2..19) :
C_LONGINT:C283($vl_h0;$vl_h1;$vl_h2;$vl_h3;$vl_h4;$vl_h5;$vl_h6;$vl_h7)
$vl_h0:=0x6A09E667
$vl_h1:=0xBB67AE85
$vl_h2:=0x3C6EF372
$vl_h3:=0xA54FF53A
$vl_h4:=0x510E527F
$vl_h5:=0x9B05688C
$vl_h6:=0x1F83D9AB
$vl_h7:=0x5BE0CD19

  //Initialize table of round constants
  //(first 32 bits of the fractional parts of the cube roots of the first 64 primes 2..311) :
ARRAY LONGINT:C221($tl_arrayTable;64)
$tl_arrayTable{1}:=0x428A2F98
$tl_arrayTable{2}:=0x71374491
$tl_arrayTable{3}:=0xB5C0FBCF
$tl_arrayTable{4}:=0xE9B5DBA5
$tl_arrayTable{5}:=0x3956C25B
$tl_arrayTable{6}:=0x59F111F1
$tl_arrayTable{7}:=0x923F82A4
$tl_arrayTable{8}:=0xAB1C5ED5
$tl_arrayTable{9}:=0xD807AA98
$tl_arrayTable{10}:=0x12835B01
$tl_arrayTable{11}:=0x243185BE
$tl_arrayTable{12}:=0x550C7DC3
$tl_arrayTable{13}:=0x72BE5D74
$tl_arrayTable{14}:=0x80DEB1FE
$tl_arrayTable{15}:=0x9BDC06A7
$tl_arrayTable{16}:=0xC19BF174
$tl_arrayTable{17}:=0xE49B69C1
$tl_arrayTable{18}:=0xEFBE4786
$tl_arrayTable{19}:=0x0FC19DC6
$tl_arrayTable{20}:=0x240CA1CC
$tl_arrayTable{21}:=0x2DE92C6F
$tl_arrayTable{22}:=0x4A7484AA
$tl_arrayTable{23}:=0x5CB0A9DC
$tl_arrayTable{24}:=0x76F988DA
$tl_arrayTable{25}:=0x983E5152
$tl_arrayTable{26}:=0xA831C66D
$tl_arrayTable{27}:=0xB00327C8
$tl_arrayTable{28}:=0xBF597FC7
$tl_arrayTable{29}:=0xC6E00BF3
$tl_arrayTable{30}:=0xD5A79147
$tl_arrayTable{31}:=0x06CA6351
$tl_arrayTable{32}:=0x14292967
$tl_arrayTable{33}:=0x27B70A85
$tl_arrayTable{34}:=0x2E1B2138
$tl_arrayTable{35}:=0x4D2C6DFC
$tl_arrayTable{36}:=0x53380D13
$tl_arrayTable{37}:=0x650A7354
$tl_arrayTable{38}:=0x766A0ABB
$tl_arrayTable{39}:=0x81C2C92E
$tl_arrayTable{40}:=0x92722C85
$tl_arrayTable{41}:=0xA2BFE8A1
$tl_arrayTable{42}:=0xA81A664B
$tl_arrayTable{43}:=0xC24B8B70
$tl_arrayTable{44}:=0xC76C51A3
$tl_arrayTable{45}:=0xD192E819
$tl_arrayTable{46}:=0xD6990624
$tl_arrayTable{47}:=0xF40E3585
$tl_arrayTable{48}:=0x106AA070
$tl_arrayTable{49}:=0x19A4C116
$tl_arrayTable{50}:=0x1E376C08
$tl_arrayTable{51}:=0x2748774C
$tl_arrayTable{52}:=0x34B0BCB5
$tl_arrayTable{53}:=0x391C0CB3
$tl_arrayTable{54}:=0x4ED8AA4A
$tl_arrayTable{55}:=0x5B9CCA4F
$tl_arrayTable{56}:=0x682E6FF3
$tl_arrayTable{57}:=0x748F82EE
$tl_arrayTable{58}:=0x78A5636F
$tl_arrayTable{59}:=0x84C87814
$tl_arrayTable{60}:=0x8CC70208
$tl_arrayTable{61}:=0x90BEFFFA
$tl_arrayTable{62}:=0xA4506CEB
$tl_arrayTable{63}:=0xBEF9A3F7
$tl_arrayTable{64}:=0xC67178F2

  //======================
  //>> Pre-processing:
  //append "1" bit to message

  //append k bits '0', where k is the minimum number>=0 such that the resulting message
  //   length (in bits) is congruent to 448 bits / 56 bytes (mod 512 bits / 64 bytes)

  //C.a.d la taille du block doit faire un multiple que le reste du module 64 octets est 56
  //en fait on garde 8 octets (64 bits) pour stocker la taille des données

  //append length of message (before pre-processing), in bits as 64-bit big-endian integer to message
  //======================

  //$vl_copySize:=$vl_dataSize%64

  //On obtient le nombre d'octet dans notre blob a crypter
C_LONGINT:C283($vl_dataSize;$vl_copySize)
$vl_dataSize:=BLOB size:C605($vp_dataPtr->)
$vl_copySize:=$vl_dataSize & 0x003F  //modulo 64 <=> 3F bit mask

C_LONGINT:C283($vl_srcOffset;$vl_dstOffset)
C_BLOB:C604($vx_lastBlock)
If ($vl_copySize>0)
	
	  //Copy the last n bytes  `($vl_dataSize%64)
	$vl_srcOffset:=$vl_dataSize-$vl_copySize
	$vl_dstOffset:=0
	COPY BLOB:C558($vp_dataPtr->;$vx_lastBlock;$vl_srcOffset;$vl_dstOffset;$vl_copySize)
	
	  //Append padding bytes to get 64 bytes total
	C_LONGINT:C283($vl_padSize)
	$vl_dstOffset:=$vl_copySize
	If ($vl_copySize<56)
		$vl_padSize:=(64-$vl_copySize)
	Else 
		$vl_padSize:=(128-$vl_copySize)
	End if 
	INSERT IN BLOB:C559($vx_lastBlock;$vl_dstOffset;$vl_padSize;0x0000)
	
Else 
	$vl_srcOffset:=$vl_dataSize
	SET BLOB SIZE:C606($vx_lastBlock;64;0x0000)
End if 

  //======================
  //>> Pre-processing:
  //append "1" bit to message
  //======================
  //Set the padding-end bit
$vx_lastBlock{$vl_copySize}:=0x0080

  //======================
  //>> Pre-processing:
  //append length of message (before pre-processing), in bits as 64-bit big-endian integer to message
  //======================

  //Set the data-size in bits
  //$vl_dataBitSize:=8*$vl_dataSize
C_LONGINT:C283($vl_dataBitSize)
$vl_dataBitSize:=$vl_dataSize << 3  //Multiplying by 8 <=> 3 left bit shift
If ($vl_copySize<56)
	$vx_lastBlock{56}:=0x0000
	$vx_lastBlock{57}:=0x0000
	$vx_lastBlock{58}:=0x0000
	$vx_lastBlock{59}:=($vl_dataSize & 0x60000000) >> 29
	$vx_lastBlock{60}:=($vl_dataBitSize & 0xFF000000) >> 24
	$vx_lastBlock{61}:=($vl_dataBitSize & 0x00FF0000) >> 16
	$vx_lastBlock{62}:=($vl_dataBitSize & 0xFF00) >> 8
	$vx_lastBlock{63}:=($vl_dataBitSize & 0x00FF)
Else 
	$vx_lastBlock{120}:=0x0000
	$vx_lastBlock{121}:=0x0000
	$vx_lastBlock{122}:=0x0000
	$vx_lastBlock{123}:=($vl_dataSize & 0x60000000) >> 29
	$vx_lastBlock{124}:=($vl_dataBitSize & 0xFF000000) >> 24
	$vx_lastBlock{125}:=($vl_dataBitSize & 0x00FF0000) >> 16
	$vx_lastBlock{126}:=($vl_dataBitSize & 0xFF00) >> 8
	$vx_lastBlock{127}:=($vl_dataBitSize & 0x00FF)
End if 

ARRAY LONGINT:C221($tl_w;64)

  //### Setting Execution Control OFF  -  Bruno LEGAY 2007.05.24
  //% R-
  //### 

  //Process the message in successive 512-bit chunks:
  //break message into 512-bit chunks
  //for each chunk
C_BLOB:C604($vx_currentBlock)
C_LONGINT:C283($vl_offset;$vl_bitRol)
For ($vl_offset;0;$vl_srcOffset+BLOB size:C605($vx_lastBlock)-1;64)
	
	  //Isolating the 64 bytes block of data we are going to work on
	Case of 
		: ($vl_offset<$vl_srcOffset)
			COPY BLOB:C558($vp_dataPtr->;$vx_currentBlock;$vl_offset;0;64)
			
		: ($vl_offset=($vl_srcOffset))
			  //If we are on the last chunk...
			COPY BLOB:C558($vx_lastBlock;$vx_currentBlock;0;0;64)  //00..63
			
		Else 
			  //: ($vl_offset=($vl_srcOffset+64))
			COPY BLOB:C558($vx_lastBlock;$vx_currentBlock;64;0;64)  //64..127
			
	End case 
	
	  //break chunk into sixteen 32-bit big-endian words w(i), 0 ≤ i ≤ 15
	$tl_w{1}:=($vx_currentBlock{0} << 24) | ($vx_currentBlock{1} << 16) | ($vx_currentBlock{2} << 8) | ($vx_currentBlock{3})
	$tl_w{2}:=($vx_currentBlock{4} << 24) | ($vx_currentBlock{5} << 16) | ($vx_currentBlock{6} << 8) | ($vx_currentBlock{7})
	$tl_w{3}:=($vx_currentBlock{8} << 24) | ($vx_currentBlock{9} << 16) | ($vx_currentBlock{10} << 8) | ($vx_currentBlock{11})
	$tl_w{4}:=($vx_currentBlock{12} << 24) | ($vx_currentBlock{13} << 16) | ($vx_currentBlock{14} << 8) | ($vx_currentBlock{15})
	$tl_w{5}:=($vx_currentBlock{16} << 24) | ($vx_currentBlock{17} << 16) | ($vx_currentBlock{18} << 8) | ($vx_currentBlock{19})
	$tl_w{6}:=($vx_currentBlock{20} << 24) | ($vx_currentBlock{21} << 16) | ($vx_currentBlock{22} << 8) | ($vx_currentBlock{23})
	$tl_w{7}:=($vx_currentBlock{24} << 24) | ($vx_currentBlock{25} << 16) | ($vx_currentBlock{26} << 8) | ($vx_currentBlock{27})
	$tl_w{8}:=($vx_currentBlock{28} << 24) | ($vx_currentBlock{29} << 16) | ($vx_currentBlock{30} << 8) | ($vx_currentBlock{31})
	$tl_w{9}:=($vx_currentBlock{32} << 24) | ($vx_currentBlock{33} << 16) | ($vx_currentBlock{34} << 8) | ($vx_currentBlock{35})
	$tl_w{10}:=($vx_currentBlock{36} << 24) | ($vx_currentBlock{37} << 16) | ($vx_currentBlock{38} << 8) | ($vx_currentBlock{39})
	$tl_w{11}:=($vx_currentBlock{40} << 24) | ($vx_currentBlock{41} << 16) | ($vx_currentBlock{42} << 8) | ($vx_currentBlock{43})
	$tl_w{12}:=($vx_currentBlock{44} << 24) | ($vx_currentBlock{45} << 16) | ($vx_currentBlock{46} << 8) | ($vx_currentBlock{47})
	$tl_w{13}:=($vx_currentBlock{48} << 24) | ($vx_currentBlock{49} << 16) | ($vx_currentBlock{50} << 8) | ($vx_currentBlock{51})
	$tl_w{14}:=($vx_currentBlock{52} << 24) | ($vx_currentBlock{53} << 16) | ($vx_currentBlock{54} << 8) | ($vx_currentBlock{55})
	$tl_w{15}:=($vx_currentBlock{56} << 24) | ($vx_currentBlock{57} << 16) | ($vx_currentBlock{58} << 8) | ($vx_currentBlock{59})
	$tl_w{16}:=($vx_currentBlock{60} << 24) | ($vx_currentBlock{61} << 16) | ($vx_currentBlock{62} << 8) | ($vx_currentBlock{63})
	
	  //>> Extend the sixteen 32-bit words into sixty-four 32-bit words:
	  //    for i from 16 to 63
	C_LONGINT:C283($i)
	C_LONGINT:C283($vl_a;$vl_b;$vl_c;$vl_d;$vl_e;$vl_f;$vl_g;$vl_h)
	C_LONGINT:C283($vl_s0;$vl_s1)
	For ($i;17;64)
		  //        s0 := (w(i-15) rightrotate 7) xor (w(i-15) rightrotate 18) xor (w(i-15) rightshift 3)
		  //        s1 := (w(i-2) rightrotate 17) xor (w(i-2) rightrotate 19) xor (w(i-2) rightshift 10)
		  //        w(i) := w(i-16) + s0 + w(i-7) + s1
		
		$vl_bitRol:=$tl_w{$i-15}
		$vl_s0:=((($vl_bitRol << 25) | ($vl_bitRol >> 7)) ^| (($vl_bitRol << 14) | ($vl_bitRol >> 18))) ^| ($vl_bitRol >> 3)
		
		$vl_bitRol:=$tl_w{$i-2}
		$vl_s1:=((($vl_bitRol << 15) | ($vl_bitRol >> 17)) ^| (($vl_bitRol << 13) | ($vl_bitRol >> 19))) ^| ($vl_bitRol >> 10)
		
		$tl_w{$i}:=$tl_w{$i-16}+$vl_s0+$tl_w{$i-7}+$vl_s1
	End for 
	
	  //    //Initialize hash value for this chunk:
	  //    a := h0
	  //    b := h1
	  //    c := h2
	  //    d := h3
	  //    e := h4
	  //    f := h5
	  //    g := h6
	  //    h := h7
	$vl_a:=$vl_h0
	$vl_b:=$vl_h1
	$vl_c:=$vl_h2
	$vl_d:=$vl_h3
	$vl_e:=$vl_h4
	$vl_f:=$vl_h5
	$vl_g:=$vl_h6
	$vl_h:=$vl_h7
	
	  //    //Main loop:
	  //    for i from 0 to 63
	  //DBG_Debug ("<table border=\"1\"> "+Caractere(ASCII CR ))
	  //DBG_Debug ("<tr><td>"+txt_implode ("</th> <th>";"Loop index";"t1";"t2";"0";"a";"b";"c";"d";"e";"f";"g";"h")+"</th></tr>"+Caractere(ASCII CR ))
	
	C_LONGINT:C283($vl_maj;$vl_ch;$vl_t1;$vl_t2)
	For ($i;1;64)
		  //        s0 := (a rightrotate 2) xor (a rightrotate 13) xor (a rightrotate 22)
		  //        maj := (a and b) xor (a and c) xor (b and c)
		  //        t2 := s0 + maj
		  //        s1 := (e rightrotate 6) xor (e rightrotate 11) xor (e rightrotate 25)
		  //        ch := (e and f) xor ((not e) and g)
		  //        t1 := h + s1 + ch + k(i) + w(i)
		$vl_s0:=(($vl_a << 30) | ($vl_a >> 2)) ^| (($vl_a << 19) | ($vl_a >> 13)) ^| (($vl_a << 10) | ($vl_a >> 22))
		$vl_maj:=(($vl_a & $vl_b) ^| ($vl_a & $vl_c)) ^| ($vl_b & $vl_c)
		$vl_t2:=$vl_s0+$vl_maj
		$vl_s1:=(($vl_e << 26) ^| ($vl_e >> 6)) ^| (($vl_e << 21) | ($vl_e >> 11)) ^| (($vl_e << 7) | ($vl_e >> 25))
		$vl_ch:=($vl_e & $vl_f) ^| (($vl_e ^| 0xFFFFFFFF) & $vl_g)  //`BIT_Not ($vl_e)
		$vl_t1:=$vl_h+$vl_s1+$vl_ch+$tl_arrayTable{$i}+$tl_w{$i}
		
		  //        h := g
		  //        g := f
		  //        f := e
		  //        e := d + t1
		  //        d := c
		  //        c := b
		  //        b := a
		  //        a := t1 + t2
		  //DBG_Debug ("<tr><td>"+txt_implode ("</td> <td>";HEX_Long_To_Hex ($i);HEX_Long_To_Hex ($vl_t1);HEX_Long_To_Hex ($vl_t2);"0";HEX_Long_To_Hex ($vl_a);HEX_Long_To_Hex ($vl_b);HEX_Long_To_Hex ($vl_c);HEX_Long_To_Hex ($vl_d);HEX_Long_To_Hex ($vl_e);HEX_Long_To_Hex ($vl_f);HEX_Long_To_Hex ($vl_g);HEX_Long_To_Hex ($vl_h))+"</td></tr>"+Caractere(ASCII CR ))
		
		$vl_h:=$vl_g
		$vl_g:=$vl_f
		$vl_f:=$vl_e
		$vl_e:=$vl_d+$vl_t1
		$vl_d:=$vl_c
		$vl_c:=$vl_b
		$vl_b:=$vl_a
		$vl_a:=$vl_t1+$vl_t2
		
	End for 
	
	  //DBG_Debug ("</table>"+Caractere(ASCII CR )+"<br>"+Caractere(ASCII CR ))
	  //DBG_Debug (txt_implode ("<br>"+Caractere(ASCII CR );"a : "+HEX_Long_To_Hex ($vl_a);"b : "+HEX_Long_To_Hex ($vl_b);"c : "+HEX_Long_To_Hex ($vl_c);"d : "+HEX_Long_To_Hex ($vl_d);"e : "+HEX_Long_To_Hex ($vl_e);"f : "+HEX_Long_To_Hex ($vl_f);"g : "+HEX_Long_To_Hex ($vl_g);"h : "+HEX_Long_To_Hex ($vl_h))+"<br><br>"+Caractere(ASCII CR ))
	
	  // //Add this chunk's hash to result so far:
	  //    h0 := h0 + a
	  //    h1 := h1 + b 
	  //    h2 := h2 + c
	  //    h3 := h3 + d
	  //    h4 := h4 + e
	  //    h5 := h5 + f
	  //    h6 := h6 + g 
	  //    h7 := h7 + h
	  //DBG_Debug (txt_implode ("<br>"+Caractere(ASCII CR );"h0 : "+HEX_Long_To_Hex ($vl_h0);"h1 : "+HEX_Long_To_Hex ($vl_h1);"h2 : "+HEX_Long_To_Hex ($vl_h2);"h3 : "+HEX_Long_To_Hex ($vl_h3);"h4 : "+HEX_Long_To_Hex ($vl_h4);"h5 : "+HEX_Long_To_Hex ($vl_h5);"h6 : "+HEX_Long_To_Hex ($vl_h6);"h7 : "+HEX_Long_To_Hex ($vl_h7))+"<br><br>"+Caractere(ASCII CR ))
	
	$vl_h0:=$vl_h0+$vl_a
	$vl_h1:=$vl_h1+$vl_b
	$vl_h2:=$vl_h2+$vl_c
	$vl_h3:=$vl_h3+$vl_d
	$vl_h4:=$vl_h4+$vl_e
	$vl_h5:=$vl_h5+$vl_f
	$vl_h6:=$vl_h6+$vl_g
	$vl_h7:=$vl_h7+$vl_h
	
	  //DBG_Debug (txt_implode ("<br>"+Caractere(ASCII CR );"h0 : "+HEX_Long_To_Hex ($vl_h0);"h1 : "+HEX_Long_To_Hex ($vl_h1);"h2 : "+HEX_Long_To_Hex ($vl_h2);"h3 : "+HEX_Long_To_Hex ($vl_h3);"h4 : "+HEX_Long_To_Hex ($vl_h4);"h5 : "+HEX_Long_To_Hex ($vl_h5);"h6 : "+HEX_Long_To_Hex ($vl_h6);"h7 : "+HEX_Long_To_Hex ($vl_h7))+"<br><br>"+Caractere(ASCII CR ))
	
End for 


  //### Setting Execution Control ON  -  Bruno LEGAY 2007.05.24
  //% R+
  //### 

  // //Output the final hash value (big-endian):
  //digest = hash = h0 append h1 append h2 append h3 append h4 append h5 append h6 append h7

  //$vx_sha256ResBlob:=CRC__SHA2_Res ($vl_h0;$vl_h1;$vl_h2;$vl_h3;$vl_h4;$vl_h5;$vl_h6;$vl_h7;$vt_resultFormat)

  //FIXER TAILLE BLOB($vx_sha256ResBlob;0)
SET BLOB SIZE:C606($vx_sha256ResBlob;32)
$vx_sha256ResBlob{0x0000}:=($vl_h0 & 0xFF000000) >> 24
$vx_sha256ResBlob{0x0001}:=($vl_h0 & 0x00FF0000) >> 16
$vx_sha256ResBlob{0x0002}:=($vl_h0 & 0xFF00) >> 8
$vx_sha256ResBlob{0x0003}:=($vl_h0 & 0x00FF)

$vx_sha256ResBlob{0x0004}:=($vl_h1 & 0xFF000000) >> 24
$vx_sha256ResBlob{0x0005}:=($vl_h1 & 0x00FF0000) >> 16
$vx_sha256ResBlob{0x0006}:=($vl_h1 & 0xFF00) >> 8
$vx_sha256ResBlob{0x0007}:=($vl_h1 & 0x00FF)

$vx_sha256ResBlob{0x0008}:=($vl_h2 & 0xFF000000) >> 24
$vx_sha256ResBlob{0x0009}:=($vl_h2 & 0x00FF0000) >> 16
$vx_sha256ResBlob{0x000A}:=($vl_h2 & 0xFF00) >> 8
$vx_sha256ResBlob{0x000B}:=($vl_h2 & 0x00FF)

$vx_sha256ResBlob{0x000C}:=($vl_h3 & 0xFF000000) >> 24
$vx_sha256ResBlob{0x000D}:=($vl_h3 & 0x00FF0000) >> 16
$vx_sha256ResBlob{0x000E}:=($vl_h3 & 0xFF00) >> 8
$vx_sha256ResBlob{0x000F}:=($vl_h3 & 0x00FF)

$vx_sha256ResBlob{0x0010}:=($vl_h4 & 0xFF000000) >> 24
$vx_sha256ResBlob{0x0011}:=($vl_h4 & 0x00FF0000) >> 16
$vx_sha256ResBlob{0x0012}:=($vl_h4 & 0xFF00) >> 8
$vx_sha256ResBlob{0x0013}:=($vl_h4 & 0x00FF)

$vx_sha256ResBlob{0x0014}:=($vl_h5 & 0xFF000000) >> 24
$vx_sha256ResBlob{0x0015}:=($vl_h5 & 0x00FF0000) >> 16
$vx_sha256ResBlob{0x0016}:=($vl_h5 & 0xFF00) >> 8
$vx_sha256ResBlob{0x0017}:=($vl_h5 & 0x00FF)

$vx_sha256ResBlob{0x0018}:=($vl_h6 & 0xFF000000) >> 24
$vx_sha256ResBlob{0x0019}:=($vl_h6 & 0x00FF0000) >> 16
$vx_sha256ResBlob{0x001A}:=($vl_h6 & 0xFF00) >> 8
$vx_sha256ResBlob{0x001B}:=($vl_h6 & 0x00FF)

$vx_sha256ResBlob{0x001C}:=($vl_h7 & 0xFF000000) >> 24
$vx_sha256ResBlob{0x001D}:=($vl_h7 & 0x00FF0000) >> 16
$vx_sha256ResBlob{0x001E}:=($vl_h7 & 0xFF00) >> 8
$vx_sha256ResBlob{0x001F}:=($vl_h7 & 0x00FF)

If (True:C214)  //Cleaning the content of our variables form memory for security reasons
	  //This is made so we don't leave any data related to our algorithm
	  //hanging in memory
	
	$vl_h0:=0x0000
	$vl_h1:=0x0000
	$vl_h2:=0x0000
	$vl_h3:=0x0000
	$vl_h4:=0x0000
	$vl_h5:=0x0000
	$vl_h6:=0x0000
	$vl_h7:=0x0000
	
	$vl_a:=0x0000
	$vl_b:=0x0000
	$vl_c:=0x0000
	$vl_d:=0x0000
	$vl_e:=0x0000
	$vl_f:=0x0000
	$vl_g:=0x0000
	$vl_h:=0x0000
	
	$vl_s0:=0x0000
	$vl_maj:=0x0000
	$vl_s1:=0x0000
	$vl_t1:=0x0000
	
	$vl_t1:=0x0000
	$vl_t2:=0x0000
	
	$vl_bitRol:=0x0000
	
	For ($vl_offset;0;BLOB size:C605($vx_lastBlock)-1)
		$vx_lastBlock{$vl_offset}:=0x0000
	End for 
	SET BLOB SIZE:C606($vx_lastBlock;0)
	
	For ($vl_offset;0;BLOB size:C605($vx_currentBlock)-1)
		$vx_currentBlock{$vl_offset}:=0x0000
	End for 
	SET BLOB SIZE:C606($vx_currentBlock;0)
	
	For ($i;1;Size of array:C274($tl_w))
		$tl_w{$i}:=0x0000
	End for 
	ARRAY LONGINT:C221($tl_w;0)
	
End if 

ARRAY LONGINT:C221($tl_arrayTable;0)

  //$vl_ms:=LONG_durationDifference($vl_ms;Nombre de millisecondes)
  //AWS__log(Nom methode courante+" "+UTL_throughput($vl_dataSize;$vl_ms))

$0:=$vx_sha256ResBlob

