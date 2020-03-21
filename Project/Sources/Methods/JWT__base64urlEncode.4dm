//%attributes = {"invisible":true}

  //================================================================================
  //@xdoc-start : en
  //@name : JWT__base64urlEncode
  //@scope : public
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-base64-TEXT] : url base64 encoded
  //@parameter[1-IN-dataPtr-TEXT] : data pointer (text or blob)
  //@notes :
  //@example : JWT__base64urlEncode 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 21/03/2020, 08:54:02 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_base64)
C_POINTER:C301($1;$vp_dataPtr)

$vt_base64:=""
$vp_dataPtr:=$1

C_LONGINT:C283($vl_type)
$vl_type:=Type:C295($vp_dataPtr->)
Case of 
	: ($vl_type=Is text:K8:3)
		
		C_BLOB:C604($vx_blob)
		SET BLOB SIZE:C606($vx_blob;0)
		CONVERT FROM TEXT:C1011($vp_dataPtr->;"UTF-8";$vx_blob)
		$vt_base64:=JWT__base64urlEncode (->$vx_blob)
		SET BLOB SIZE:C606($vx_blob;0)
		
	: ($vl_type=Is BLOB:K8:12)
		
		BASE64 ENCODE:C895($vp_dataPtr->;$vt_base64)
		TXT_base64Clean (->$vt_base64)
		$vt_base64:=Replace string:C233($vt_base64;"=";"";*)
		$vt_base64:=Replace string:C233($vt_base64;"+";"-";*)
		$vt_base64:=Replace string:C233($vt_base64;"/";"_";*)
		
End case 

$0:=$vt_base64