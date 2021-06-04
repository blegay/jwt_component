//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}

  //================================================================================
  //@xdoc-start : en
  //@name : JWT__sign
  //@scope : public
  //@deprecated : no
  //@description : This function returns returns a JWT signature
  //@parameter[0-OUT-signed-TEXT] : signature
  //@parameter[1-IN-key-TEXT] : key
  //@parameter[2-IN-stringToSign-TEXT] : string to sign
  //@parameter[3-IN-passwordIsBase64Encoded-BOOLEAN] : TRUE if the password is base64 encoded, FALSE otherwise
  //@notes :
  //@example : JWT__sign 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 21/03/2020, 08:56:11 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_signed)
C_TEXT:C284($1;$vt_key)
C_TEXT:C284($2;$vt_stringToSign)
C_BOOLEAN:C305($3;$vb_passwordIsBase64Encoded)

$vt_signed:=""

$vt_key:=$1
$vt_stringToSign:=$2
$vb_passwordIsBase64Encoded:=$3

C_BLOB:C604($vx_data)
SET BLOB SIZE:C606($vx_data;0)
CONVERT FROM TEXT:C1011($vt_stringToSign;"UTF-8";$vx_data)

C_BLOB:C604($vx_key)
SET BLOB SIZE:C606($vx_key;0)
If ($vb_passwordIsBase64Encoded)
	BASE64 DECODE:C896($vt_key;$vx_key)
Else 
	CONVERT FROM TEXT:C1011($vt_key;"UTF-8";$vx_key)
End if 

C_BLOB:C604($vx_hmac)
SET BLOB SIZE:C606($vx_hmac;0)

$vx_hmac:=CRC_hmacSha2_256Blob (->$vx_key;->$vx_data)
SET BLOB SIZE:C606($vx_key;0)
SET BLOB SIZE:C606($vx_data;0)

$vt_signed:=JWT__base64urlEncode (->$vx_hmac)
SET BLOB SIZE:C606($vx_hmac;0)

  //C_TEXTE($vt_hmacBase64)
  //ENCODER BASE64($vx_hmac;$vt_hmacBase64)

  //FIXER TAILLE BLOB($vx_hmac;0)

  //TXT_base64Clean (->$vt_hmacBase64)
  //$vt_signed:=Remplacer chaine($vt_hmacBase64;"=";"";*)

$0:=$vt_signed