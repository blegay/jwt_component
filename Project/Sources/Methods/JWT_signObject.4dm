//%attributes = {"shared":true}

  //================================================================================
  //@xdoc-start : en
  //@name : JWT_signObject
  //@scope : public
  //@deprecated : no
  //@description : This function returns a signed object using JWT
  //@parameter[0-OUT-token-TEXT] : token
  //@parameter[1-IN-object-OBJECT] : object (not modified)
  //@parameter[2-IN-password-TEXT] : password
  //@parameter[3-IN-passwordIsBase64Encoded-BOOLEAN] : password is base64 encoded (optional, default FALSE)
  //@notes :
  //@example : JWT_signObject 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 03/05/2016, 19:09:47 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_token)
C_OBJECT:C1216($1;$vo_object)
C_TEXT:C284($2;$vt_password)
C_BOOLEAN:C305($3;$vb_passwordIsBase64Encoded)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vo_object:=$1
	$vt_password:=$2
	
	Case of 
		: ($vl_nbParam=2)
			$vb_passwordIsBase64Encoded:=False:C215
		Else 
			$vb_passwordIsBase64Encoded:=$3
	End case 
	
	
	$vt_token:=JWT_signJson (JSON Stringify:C1217($vo_object);$vt_password;$vb_passwordIsBase64Encoded)
End if 

$0:=$vt_token

