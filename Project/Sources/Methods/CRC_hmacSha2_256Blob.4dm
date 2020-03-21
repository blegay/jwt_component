//%attributes = {"invisible":true}

  //================================================================================
  //@xdoc-start : en
  //@name : CRC_hmacSha2_256Blob
  //@scope : public
  //@deprecated : no
  //@description : This function returns a hmac-sha2-256 digest in a binary form (blob) 
  //@parameter[0-OUT-hmacDigest-BLOB] : hmac-sha2-256 digest
  //@parameter[1-IN-keyBlobPtr-POINTER] : key blob pointer (not modified)
  //@parameter[2-IN-dataBlobPtr-POINTER] : data blob pointer (not modified)
  //@notes :
  //@example : $vx_hmacDigest:=CRC_hmacSha2_256Blob (->$vx_key;->$vx_data) 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 03/08/2009, 12:40:46 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BLOB:C604($0;$vx_hmacSha256DigestBlob)  //hmacDigest
C_POINTER:C301($1;$vp_keyBlobPtr)  //key blob pointer
C_POINTER:C301($2;$vp_msgBlobPtr)  //data blob pointer

SET BLOB SIZE:C606($vx_hmacSha256DigestBlob;0)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vp_keyBlobPtr:=$1
	$vp_msgBlobPtr:=$2
	
	C_LONGINT:C283($vl_blocSize)
	
	$vl_blocSize:=64  //bloc size in bytes 
	
	  //C_ENTIER LONG($vl_ms)
	  //$vl_ms:=Nombre de millisecondes
	
	ASSERT:C1129(Type:C295($vp_keyBlobPtr->)=Is BLOB:K8:12;"keyBlobPtr/$1 should be a blob pointer")
	ASSERT:C1129(Type:C295($vp_msgBlobPtr->)=Is BLOB:K8:12;"msgBlobPtr/$2 should be a blob pointer")
	
	  //Si ((Type($vp_keyBlobPtr->)=Est un BLOB) & (Type($vp_msgBlobPtr->)=Est un BLOB))
	
	C_BLOB:C604($vx_keyBlob)
	$vx_keyBlob:=$vp_keyBlobPtr->
	
	
	  //opad=[0x5c*blocksize] >> Where blocksize is that of the underlying hash function
	C_BLOB:C604($vx_opad)
	SET BLOB SIZE:C606($vx_opad;$vl_blocSize;0x005C)
	
	  //ipad=[0x36*blocksize]
	C_BLOB:C604($vx_ipad)
	SET BLOB SIZE:C606($vx_ipad;$vl_blocSize;0x0036)
	
	
	  //if(length(key)>blocksize)then
	  //key=hash(key) // keys longer than blocksize are shortened
	  //end if
	If (BLOB size:C605($vx_keyBlob)>$vl_blocSize)
		
		$vx_keyBlob:=CRC_sha2_256Blob (->$vx_keyBlob)
		
	End if 
	
	
	  //for i from 0 to length(key)-1 step 1
	  //ipad[i]=ipad[i] ? key[i] >> Where ? is exclusive or(XOR)
	  //opad[i]=opad[i] ? key[i]
	  //end for
	C_LONGINT:C283($i)
	For ($i;0;BLOB size:C605($vx_keyBlob)-1)
		$vx_ipad{$i}:=$vx_keyBlob{$i} ^| $vx_ipad{$i}
		$vx_opad{$i}:=$vx_keyBlob{$i} ^| $vx_opad{$i}
	End for 
	
	
	  //return hash(opad ++ hash(ipad ++ message)) // Where ++ is concatenation
	
	C_BLOB:C604($vx_tmp)
	$vx_tmp:=$vp_msgBlobPtr->
	
	  //concaténation de ipad ++ message
	  //on insère le blob ipad au début du blob tmp
	INSERT IN BLOB:C559($vx_tmp;0;BLOB size:C605($vx_ipad))
	COPY BLOB:C558($vx_ipad;$vx_tmp;0;0;BLOB size:C605($vx_ipad))
	
	  //calcul du hash(ipad ++ message)
	$vx_tmp:=CRC_sha2_256Blob (->$vx_tmp)
	
	
	  //concaténation de opad ++ hash(ipad ++ message)
	  //on insère le blob opad au début du blob tmp
	INSERT IN BLOB:C559($vx_tmp;0;BLOB size:C605($vx_opad))
	COPY BLOB:C558($vx_opad;$vx_tmp;0;0;BLOB size:C605($vx_opad))
	
	  //calcul du hash(opad ++ hash(ipad ++ message))
	$vx_hmacSha256DigestBlob:=CRC_sha2_256Blob (->$vx_tmp)
	
	SET BLOB SIZE:C606($vx_keyBlob;0)
	SET BLOB SIZE:C606($vx_opad;0)
	SET BLOB SIZE:C606($vx_ipad;0)
	SET BLOB SIZE:C606($vx_tmp;0)
	
	  //Fin de si 
	
	  //$vl_ms:=LONG_durationDifference($vl_ms;Nombre de millisecondes)
	  //AWS__log(Nom methode courante+" key size : "+Chaine(Taille BLOB($vp_keyBlobPtr->))+" byte(s), message size : "+Chaine(Taille BLOB($vp_msgBlobPtr->))+" byte(s), "+UTL_throughput(Taille BLOB($vp_keyBlobPtr->)+Taille BLOB($vp_msgBlobPtr->);$vl_ms))
	
End if 

$0:=$vx_hmacSha256DigestBlob