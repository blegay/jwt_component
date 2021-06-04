//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}

  //================================================================================
  //@xdoc-start : en
  //@name : CRC_sha2_256Blob
  //@scope : public
  //@deprecated : no
  //@description : This function generates a sha2-256 hash for data from a blob 
  //@parameter[0-OUT-sha2_256Binary-BLOB] : sha2-256 hash in binary format
  //@parameter[1-IN-blobPtr-POINTER] : blob pointer (not modified)
  //@notes : 
  //@example : CRC_sha2_256Blob
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 19/01/2020, 11:39:31 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BLOB:C604($0;$vx_sha256ResBlob)  //*$0 <-- SHA2-256 checksum
C_POINTER:C301($1;$vp_dataPtr)  //*$1 --> Data pointer

ASSERT:C1129(Count parameters:C259>0;"should have 1 parameter")
ASSERT:C1129(Type:C295($1->)=Is BLOB:K8:12;"dataPtr/$1 should be a blob pointer")

SET BLOB SIZE:C606($vx_sha256ResBlob;0)
$vp_dataPtr:=$1

If (ENV_v17orAbove )
	
	C_TEXT:C284($vt_sha256Hex)
	$vt_sha256Hex:=Generate digest:C1147($vp_dataPtr->;3)  //3 = SHA-256 digest, 4 = SHA-512 digest : 4D v16 R5+, 
	
	HEX_hexTextToBlob ($vt_sha256Hex;->$vx_sha256ResBlob)
	
Else 
	$vx_sha256ResBlob:=CRC_sha2_256BlobNative ($vp_dataPtr)
End if 

$0:=$vx_sha256ResBlob
SET BLOB SIZE:C606($vx_sha256ResBlob;0)