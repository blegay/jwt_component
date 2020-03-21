//%attributes = {"shared":true}

  //================================================================================
  //@xdoc-start : en
  //@name : JWT_signJson
  //@scope : public
  //@deprecated : no
  //@description : This function returns a signed json string using JWT
  //@parameter[0-OUT-token-TEXT] : token
  //@parameter[1-IN-json-TEXT] : json
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
C_TEXT:C284($1;$vt_json)
C_TEXT:C284($2;$vt_password)
C_BOOLEAN:C305($3;$vb_passwordIsBase64Encoded)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vt_json:=$1
	$vt_password:=$2
	
	Case of 
		: ($vl_nbParam=2)
			$vb_passwordIsBase64Encoded:=False:C215
		Else 
			$vb_passwordIsBase64Encoded:=$3
	End case 
	
	If (True:C214)
		C_TEXT:C284($vt_headerJson)
		$vt_headerJson:="{\"alg\":\"HS256\",\"typ\":\"JWT\"}"
	Else 
		  // create JWT sample header object
		C_OBJECT:C1216($vo_header)
		CLEAR VARIABLE:C89($vo_header)
		
		OB SET:C1220($vo_header;"alg";"HS256")
		OB SET:C1220($vo_header;"typ";"JWT")
		
		  // serialize the header object into json
		C_TEXT:C284($vt_headerJson)
		$vt_headerJson:=JSON Stringify:C1217($vo_header)
		CLEAR VARIABLE:C89($vo_header)
	End if 
	
	  // Build the string to sign
	C_TEXT:C284($vt_stringToSign)
	$vt_stringToSign:=JWT__base64urlEncode (->$vt_headerJson)+"."+JWT__base64urlEncode (->$vt_json)
	
	  // Sign the string
	$vt_token:=$vt_stringToSign+"."+JWT__sign ($vt_password;$vt_stringToSign;$vb_passwordIsBase64Encoded)
	
End if 
$0:=$vt_token
  //ASSERT($vt_token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ")

