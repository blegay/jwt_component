//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}

  //================================================================================
  //@xdoc-start : en
  //@name : HEX_hexByteStrToByteInteger
  //@scope : private
  //@deprecated : no
  //@description : This function converts a byte in hex format ("00" - "FF") to an integer byte value 0-255 
  //@parameter[0-OUT-byteValue-TEXT] : byte value (0-255)
  //@parameter[1-IN-byteHex-STRING 2] : byte in hex representation ("00" to "FF") 
  //@notes :
  //@example : 
  //  ALERT(String(HEX_hexByteStrToByteInteger ("00")))
  //  ALERT(String(HEX_hexByteStrToByteInteger ("10")))
  //  ALERT(String(HEX_hexByteStrToByteInteger ("FF"))) 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 20/11/2012, 12:10:27 - v1.00.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($0;$ve_byte)  //octet correspondant
C_TEXT:C284($1;$va_hex)  //Valeur hexadécimale stockées dans une chaine

$ve_byte:=0
If (Count parameters:C259>0)
	$va_hex:=$1
	
	If (Length:C16($va_hex)>1)
		
		$ve_byte:=(HEX_hexCharToInt ($va_hex[[1]]) << 4) | HEX_hexCharToInt ($va_hex[[2]])
		
	End if 
	
End if 
$0:=$ve_byte