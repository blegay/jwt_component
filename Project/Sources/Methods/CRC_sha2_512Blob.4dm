//%attributes = {"shared":false,"invisible":true}

  //================================================================================
  //@xdoc-start : en
  //@name : CRC_sha2_512Blob
  //@scope : public
  //@deprecated : no
  //@description : This function generates a sha2-512 hash for data from a blob
  //@parameter[0-OUT-sha2_512Binary-BLOB] : sha2-512 hash in binary format
  //@parameter[1-IN-blobPtr-POINTER] : blob pointer (not modified)
  //@notes :
  //  http://en.wikipedia.org/wiki/SHA
  //@example : CRC_sha2_512Blob 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2015
  //@history : CREATION : Bruno LEGAY (BLE) - 26/12/2015, 15:29:52 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BLOB:C604($0;$vx_sha512)
C_POINTER:C301($1;$vp_dataPtr)

ASSERT:C1129(Count parameters:C259>0)
$vp_dataPtr:=$1

ASSERT:C1129(Type:C295($vp_dataPtr->)=Is BLOB:K8:12;"expecting $1 to be a blob pointer")


If (ENV_v17orAbove )  //  4D v16 R5+
	
	C_TEXT:C284($vt_sha512Hex)
	$vt_sha512Hex:=Generate digest:C1147($vp_dataPtr->;SHA512 digest:K66:5)  // Digest SHA512 (4)
	HEX_hexTextToBlob ($vt_sha512Hex;->$vx_sha512)
	
Else 
	
	ASSERT:C1129(False:C215;"unimplemented")
	
	  //C_BLOB($vx_currentBlock)
	
	  //  // Initialize initial values (64 bytes <=> 8 x 8 bytes <=> 8 x 64 bits words)
	  //C_BLOB($vx_blobInitialValues)
	  //$vx_blobInitialValues:=CRC__sha2_512_blob_initial
	
	  //  // Initialize the lookup table (640 bytes <=> 80 x 8 bytes <=> 80 x 64 bits words)
	  //C_BLOB($vx_tableBlob)
	  //$vx_tableBlob:=CRC__sha2_512_blob_table
	
	  //  // prepare the last block padding
	  //If (True)
	  //C_LONGINT($vl_dataSize;$vl_copySize;$vl_srcOffset;$vl_dstOffset;$vl_padSize)
	  //$vl_dataSize:=BLOB size($vp_dataPtr->)
	  //$vl_copySize:=$vl_dataSize & 0x007F  //modulo 128 <=> 7F bit mask => valeur 0..127
	
	  //If ($vl_copySize>0)
	
	  //  //Copy the last n bytes  `($vl_dataSize%128)
	  //$vl_srcOffset:=$vl_dataSize-$vl_copySize
	  //$vl_dstOffset:=0
	  //COPY BLOB($vp_dataPtr->;$vx_lastBlock;$vl_srcOffset;$vl_dstOffset;$vl_copySize)
	
	  //  //Append padding bytes to get 128 bytes total
	  //$vl_dstOffset:=$vl_copySize
	  //If ($vl_copySize<112)
	  //$vl_padSize:=(128-$vl_copySize)
	  //Else 
	  //$vl_padSize:=(256-$vl_copySize)
	  //End if 
	  //INSERT IN BLOB($vx_lastBlock;$vl_dstOffset;$vl_padSize;0x0000)
	
	  //Else 
	  //$vl_srcOffset:=$vl_dataSize
	  //SET BLOB SIZE($vx_lastBlock;128;0x0000)
	  //End if 
	
	  //End if 
	
	
	  //  //======================
	  //  //>> Pre-processing:
	  //  //append "1" bit to message
	  //  //======================
	  //  //Set the padding-end bit
	  //$vx_lastBlock{$vl_copySize}:=0x0080  // append "1000000"
	
	  //  //======================
	  //  //>> Pre-processing:
	  //  //append length of message (before pre-processing), in bits as 64-bit big-endian integer to message
	  //  //======================
	
	  //  //Set the data-size in bits
	  //  //$vl_dataBitSize:=8*$vl_dataSize
	  //C_LONGINT($vl_dataBitSize)
	  //$vl_dataBitSize:=$vl_dataSize << 3  //Multiplying by 8 <=> 3 left bit shift
	  //If ($vl_copySize<112)
	  //$vx_lastBlock{120}:=0x0000
	  //$vx_lastBlock{121}:=0x0000
	  //$vx_lastBlock{122}:=0x0000
	  //$vx_lastBlock{123}:=($vl_dataSize & 0x60000000) >> 29
	  //$vx_lastBlock{124}:=($vl_dataBitSize & 0xFF000000) >> 24
	  //$vx_lastBlock{125}:=($vl_dataBitSize & 0x00FF0000) >> 16
	  //$vx_lastBlock{126}:=($vl_dataBitSize & 0xFF00) >> 8
	  //$vx_lastBlock{127}:=($vl_dataBitSize & 0x00FF)
	  //Else 
	  //$vx_lastBlock{248}:=0x0000
	  //$vx_lastBlock{249}:=0x0000
	  //$vx_lastBlock{250}:=0x0000
	  //$vx_lastBlock{251}:=($vl_dataSize & 0x60000000) >> 29
	  //$vx_lastBlock{252}:=($vl_dataBitSize & 0xFF000000) >> 24
	  //$vx_lastBlock{253}:=($vl_dataBitSize & 0x00FF0000) >> 16
	  //$vx_lastBlock{254}:=($vl_dataBitSize & 0xFF00) >> 8
	  //$vx_lastBlock{255}:=($vl_dataBitSize & 0x00FF)
	  //End if 
	
	  //  //### Setting Execution Control OFF  -  Bruno LEGAY 13/12/2015
	  //  //% R-
	  //  //### 
	
	  //C_BLOB($vx_h0;$vx_h1;$vx_h2;$vx_h3;$vx_h4;$vx_h5;$vx_h6;$vx_h7)
	
	  //COPY BLOB($vx_blobInitialValues;$vx_h0;0;0;8)
	  //COPY BLOB($vx_blobInitialValues;$vx_h1;8;0;8)
	  //COPY BLOB($vx_blobInitialValues;$vx_h2;16;0;8)
	  //COPY BLOB($vx_blobInitialValues;$vx_h3;24;0;8)
	  //COPY BLOB($vx_blobInitialValues;$vx_h4;32;0;8)
	  //COPY BLOB($vx_blobInitialValues;$vx_h5;40;0;8)
	  //COPY BLOB($vx_blobInitialValues;$vx_h6;48;0;8)
	  //COPY BLOB($vx_blobInitialValues;$vx_h7;56;0;8)
	
	  //C_LONGINT($vl_offsetCopy)
	  //SET BLOB SIZE($vx_bitRol;8;0x0000)
	
	  //  //Process the message in successive 512-bit chunks:
	  //  //break message into 512-bit chunks
	  //  //for each chunk
	  //C_LONGINT($vl_offset)
	  //For ($vl_offset;0;$vl_srcOffset+BLOB size($vx_lastBlock)-1;128)
	
	  //  //Isolating the 64 bytes block of data we are going to work on
	  //Case of 
	  //: ($vl_offset<$vl_srcOffset)
	  //COPY BLOB($vp_dataPtr->;$vx_currentBlock;$vl_offset;0;128)
	
	  //: ($vl_offset=($vl_srcOffset))
	  //  //If we are on the last chunk...
	  //COPY BLOB($vx_lastBlock;$vx_currentBlock;0;0;128)  //00..63
	
	  //Else 
	  //  //: ($vl_offset=($vl_srcOffset+64))
	  //COPY BLOB($vx_lastBlock;$vx_currentBlock;128;0;128)  //64..127
	
	  //End case 
	
	  //C_BLOB($vx_w)
	  //$vx_w:=$vx_currentBlock  // original bloc is 128 bytes, 1024 bits (16 words of 64 bits)
	
	
	  //C_BLOB($vx_s0;$vx_s1;$vx_bitRol;$vx_addition)
	  //SET BLOB SIZE($vx_w;80*8;0x0000)  // 80 64 bits words, 80 x 8 bytes = 640 bits
	
	
	  //  // Extend the sixteen 64-bit words into 80 64-bit words (5120 bits) :
	  //  //    for i from 16 to 79
	  //C_LONGINT($i)
	  //For ($i;16;79)  // move from word 16 to word 79
	  //  //         s0   := (w[i-15] rightrotate  1) xor (w[i-15] rightrotate  8) xor (w[i-15] rightshift 7)
	  //  //         s1   := (w[i-2]  rightrotate 19) xor (w[i-2]  rightrotate 61) xor (w[i-2]  rightshift 6)
	  //  //         w[i] := w[i-16] + s0 + w[i-7] + s1
	
	  //  //COPIER BLOB($vx_w;$vx_bitRol;($i-15) << 3;0;8)
	  //$vl_offsetCopy:=(($i-15) << 3)
	  //$vx_bitRol{0}:=$vx_w{$vl_offsetCopy}
	  //$vx_bitRol{1}:=$vx_w{$vl_offsetCopy+1}
	  //$vx_bitRol{2}:=$vx_w{$vl_offsetCopy+2}
	  //$vx_bitRol{3}:=$vx_w{$vl_offsetCopy+3}
	  //$vx_bitRol{4}:=$vx_w{$vl_offsetCopy+4}
	  //$vx_bitRol{5}:=$vx_w{$vl_offsetCopy+5}
	  //$vx_bitRol{6}:=$vx_w{$vl_offsetCopy+6}
	  //$vx_bitRol{7}:=$vx_w{$vl_offsetCopy+7}
	
	  //$vx_s0:=BIT_64_xor(BIT_64_xor(BIT_64_rotr($vx_bitRol;1);BIT_64_rotr($vx_bitRol;8));BIT_64_shr($vx_bitRol;7))
	
	  //  //COPIER BLOB($vx_w;$vx_bitRol;($i-2) << 3;0;8)
	  //$vl_offsetCopy:=(($i-2) << 3)
	  //$vx_bitRol{0}:=$vx_w{$vl_offsetCopy}
	  //$vx_bitRol{1}:=$vx_w{$vl_offsetCopy+1}
	  //$vx_bitRol{2}:=$vx_w{$vl_offsetCopy+2}
	  //$vx_bitRol{3}:=$vx_w{$vl_offsetCopy+3}
	  //$vx_bitRol{4}:=$vx_w{$vl_offsetCopy+4}
	  //$vx_bitRol{5}:=$vx_w{$vl_offsetCopy+5}
	  //$vx_bitRol{6}:=$vx_w{$vl_offsetCopy+6}
	  //$vx_bitRol{7}:=$vx_w{$vl_offsetCopy+7}
	
	  //$vx_s1:=BIT_64_xor(BIT_64_xor(BIT_64_rotr($vx_bitRol;19);BIT_64_rotr($vx_bitRol;61));BIT_64_shr($vx_bitRol;6))
	
	  //  //COPIER BLOB($vx_w;$vx_bitRol;($i-16) << 3;0;8)
	  //$vl_offsetCopy:=(($i-16) << 3)
	  //$vx_bitRol{0}:=$vx_w{$vl_offsetCopy}
	  //$vx_bitRol{1}:=$vx_w{$vl_offsetCopy+1}
	  //$vx_bitRol{2}:=$vx_w{$vl_offsetCopy+2}
	  //$vx_bitRol{3}:=$vx_w{$vl_offsetCopy+3}
	  //$vx_bitRol{4}:=$vx_w{$vl_offsetCopy+4}
	  //$vx_bitRol{5}:=$vx_w{$vl_offsetCopy+5}
	  //$vx_bitRol{6}:=$vx_w{$vl_offsetCopy+6}
	  //$vx_bitRol{7}:=$vx_w{$vl_offsetCopy+7}
	
	  //$vx_addition:=BIT_64_add($vx_bitRol;$vx_s0)
	
	  //  //COPIER BLOB($vx_w;$vx_bitRol;($i-7) << 3;0;8)
	  //$vl_offsetCopy:=(($i-7) << 3)
	  //$vx_bitRol{0}:=$vx_w{$vl_offsetCopy}
	  //$vx_bitRol{1}:=$vx_w{$vl_offsetCopy+1}
	  //$vx_bitRol{2}:=$vx_w{$vl_offsetCopy+2}
	  //$vx_bitRol{3}:=$vx_w{$vl_offsetCopy+3}
	  //$vx_bitRol{4}:=$vx_w{$vl_offsetCopy+4}
	  //$vx_bitRol{5}:=$vx_w{$vl_offsetCopy+5}
	  //$vx_bitRol{6}:=$vx_w{$vl_offsetCopy+6}
	  //$vx_bitRol{7}:=$vx_w{$vl_offsetCopy+7}
	
	  //$vx_addition:=BIT_64_add($vx_addition;BIT_64_add($vx_bitRol;$vx_s1))
	
	  //  //COPIER BLOB($vx_addition;$vx_w;0;$i << 3;8)
	  //$vl_offsetCopy:=$i << 3
	  //$vx_w{$vl_offsetCopy}:=$vx_addition{0}
	  //$vx_w{$vl_offsetCopy+1}:=$vx_addition{1}
	  //$vx_w{$vl_offsetCopy+2}:=$vx_addition{2}
	  //$vx_w{$vl_offsetCopy+3}:=$vx_addition{3}
	  //$vx_w{$vl_offsetCopy+4}:=$vx_addition{4}
	  //$vx_w{$vl_offsetCopy+5}:=$vx_addition{5}
	  //$vx_w{$vl_offsetCopy+6}:=$vx_addition{6}
	  //$vx_w{$vl_offsetCopy+7}:=$vx_addition{7}
	  //End for 
	
	  //  //    //Initialize hash value for this chunk:
	  //C_BLOB($vx_a;$vx_b;$vx_c;$vx_d;$vx_e;$vx_f;$vx_g;$vx_h)
	  //$vx_a:=$vx_h0
	  //$vx_b:=$vx_h1
	  //$vx_c:=$vx_h2
	  //$vx_d:=$vx_h3
	  //$vx_e:=$vx_h4
	  //$vx_f:=$vx_h5
	  //$vx_g:=$vx_h6
	  //$vx_h:=$vx_h7
	
	  //  //$vx_t1:=BIT_64_add ($vx_h;$vx_s1)
	
	  //C_BLOB($vx_maj;$vx_t1;$vx_t2;$vx_ch)
	  //For ($i;0;79)
	  //  //        S0 := (a rightrotate 28) xor (a rightrotate 34) xor (a rightrotate 39)
	  //  //        maj := (a and b) xor (a and c) xor (b and c)
	  //  //        t2 := s0 + maj
	
	  //  //        S1 := (e rightrotate 14) xor (e rightrotate 18) xor (e rightrotate 41)
	  //  //        ch := (e and f) xor ((not e) and g)
	  //  //        t1 := h + s1 + ch + k(i) + w(i)
	
	  //$vx_s0:=BIT_64_xor(BIT_64_xor(BIT_64_rotr($vx_a;28);BIT_64_rotr($vx_a;34));BIT_64_rotr($vx_a;39))
	  //$vx_maj:=BIT_64_xor(BIT_64_xor(BIT_64_and($vx_a;$vx_b);BIT_64_and($vx_a;$vx_c));BIT_64_and($vx_b;$vx_c))
	  //$vx_t2:=BIT_64_add($vx_s0;$vx_maj)
	
	  //$vx_s1:=BIT_64_xor(BIT_64_xor(BIT_64_rotr($vx_e;14);BIT_64_rotr($vx_e;18));BIT_64_rotr($vx_e;41))
	  //$vx_ch:=BIT_64_xor(BIT_64_and($vx_e;$vx_f);BIT_64_and(BIT_64_not($vx_e);$vx_g))
	
	  //$vx_t1:=BIT_64_add($vx_h;$vx_s1)
	  //$vx_t1:=BIT_64_add($vx_t1;$vx_ch)
	
	  //  //COPIER BLOB($vx_tableBlob;$vx_bitRol;$i << 3;0;8)
	  //$vl_offsetCopy:=$i << 3
	  //$vx_bitRol{0}:=$vx_tableBlob{$vl_offsetCopy}
	  //$vx_bitRol{1}:=$vx_tableBlob{$vl_offsetCopy+1}
	  //$vx_bitRol{2}:=$vx_tableBlob{$vl_offsetCopy+2}
	  //$vx_bitRol{3}:=$vx_tableBlob{$vl_offsetCopy+3}
	  //$vx_bitRol{4}:=$vx_tableBlob{$vl_offsetCopy+4}
	  //$vx_bitRol{5}:=$vx_tableBlob{$vl_offsetCopy+5}
	  //$vx_bitRol{6}:=$vx_tableBlob{$vl_offsetCopy+6}
	  //$vx_bitRol{7}:=$vx_tableBlob{$vl_offsetCopy+7}
	
	  //$vx_t1:=BIT_64_add($vx_t1;$vx_bitRol)
	
	  //  //COPIER BLOB($vx_w;$vx_bitRol;$i << 3;0;8)
	  //$vl_offsetCopy:=$i << 3
	  //$vx_bitRol{0}:=$vx_w{$vl_offsetCopy}
	  //$vx_bitRol{1}:=$vx_w{$vl_offsetCopy+1}
	  //$vx_bitRol{2}:=$vx_w{$vl_offsetCopy+2}
	  //$vx_bitRol{3}:=$vx_w{$vl_offsetCopy+3}
	  //$vx_bitRol{4}:=$vx_w{$vl_offsetCopy+4}
	  //$vx_bitRol{5}:=$vx_w{$vl_offsetCopy+5}
	  //$vx_bitRol{6}:=$vx_w{$vl_offsetCopy+6}
	  //$vx_bitRol{7}:=$vx_w{$vl_offsetCopy+7}
	
	  //$vx_t1:=BIT_64_add($vx_t1;$vx_bitRol)
	
	  //$vx_h:=$vx_g
	  //$vx_g:=$vx_f
	  //$vx_f:=$vx_e
	  //$vx_e:=BIT_64_add($vx_d;$vx_t1)
	  //$vx_d:=$vx_c
	  //$vx_c:=$vx_b
	  //$vx_b:=$vx_a
	  //$vx_a:=BIT_64_add($vx_t1;$vx_t2)
	
	  //End for 
	
	  //$vx_h0:=BIT_64_add($vx_h0;$vx_a)
	  //$vx_h1:=BIT_64_add($vx_h1;$vx_b)
	  //$vx_h2:=BIT_64_add($vx_h2;$vx_c)
	  //$vx_h3:=BIT_64_add($vx_h3;$vx_d)
	  //$vx_h4:=BIT_64_add($vx_h4;$vx_e)
	  //$vx_h5:=BIT_64_add($vx_h5;$vx_f)
	  //$vx_h6:=BIT_64_add($vx_h6;$vx_g)
	  //$vx_h7:=BIT_64_add($vx_h7;$vx_h)
	
	  //End for 
	  //  //### Setting Execution Control ON  -  Bruno LEGAY 13/12/2015
	  //  //% R+
	  //  //### 
	
	  //SET BLOB SIZE($vx_bitRol;0)
	
	  //SET BLOB SIZE($vx_sha512;64;0x0000)
	  //COPY BLOB($vx_h0;$vx_sha512;0;0;8)
	  //COPY BLOB($vx_h1;$vx_sha512;0;8;8)
	  //COPY BLOB($vx_h2;$vx_sha512;0;16;8)
	  //COPY BLOB($vx_h3;$vx_sha512;0;24;8)
	  //COPY BLOB($vx_h4;$vx_sha512;0;32;8)
	  //COPY BLOB($vx_h5;$vx_sha512;0;40;8)
	  //COPY BLOB($vx_h6;$vx_sha512;0;48;8)
	  //COPY BLOB($vx_h7;$vx_sha512;0;56;8)
	
	
	  //If (True)  //Cleaning the content of our variables form memory for security reasons
	  //C_BLOB($vx_clean)
	  //SET BLOB SIZE($vx_clean;64;0x0000)
	  //$vx_h0:=$vx_clean
	  //$vx_h1:=$vx_clean
	  //$vx_h2:=$vx_clean
	  //$vx_h3:=$vx_clean
	  //$vx_h4:=$vx_clean
	  //$vx_h5:=$vx_clean
	  //$vx_h6:=$vx_clean
	  //$vx_h7:=$vx_clean
	
	  //$vx_a:=$vx_clean
	  //$vx_b:=$vx_clean
	  //$vx_c:=$vx_clean
	  //$vx_d:=$vx_clean
	  //$vx_e:=$vx_clean
	  //$vx_f:=$vx_clean
	  //$vx_g:=$vx_clean
	  //$vx_h:=$vx_clean
	
	  //$vx_maj:=$vx_clean
	  //$vx_t1:=$vx_clean
	  //$vx_t2:=$vx_clean
	  //$vx_ch:=$vx_clean
	
	  //$vx_s0:=$vx_clean
	  //$vx_s1:=$vx_clean
	  //$vx_bitRol:=$vx_clean
	  //$vx_addition:=$vx_clean
	
	  //SET BLOB SIZE($vx_blobInitialValues;0)
	  //SET BLOB SIZE($vx_w;0)
	  //SET BLOB SIZE($vx_currentBlock;0)
	
	  //End if 
	
End if 

$0:=$vx_sha512
