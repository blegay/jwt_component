//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}

  //================================================================================
  //@xdoc-start : en
  //@name : HEX_hexCharToInt
  //@scope : private
  //@deprecated : no
  //@description : This function converts an hex char "0-F" into a number 0-15 
  //@parameter[0-OUT-hexValue-INTEGER] : value (0-15)
  //@parameter[1-IN-hexChar-STRING 1] : hex character ("0-F" uppercase or lowercase)
  //@notes :
  //@example : HEX_hexCharToInt ("F")
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 20/11/2012, 12:06:24 - v1.00.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($0;$ve_nibble)  //nibble
C_TEXT:C284($1;$va_hex)  //hex char

If (Count parameters:C259>0)
	$va_hex:=$1
	
	If (Length:C16($va_hex)>0)
		
		C_LONGINT:C283($vl_hexAscii)
		$vl_hexAscii:=Character code:C91($va_hex[[1]])
		
		Case of 
			: (($vl_hexAscii>=0x0030) & ($vl_hexAscii<=0x0039))  //0 => 9
				$ve_nibble:=$vl_hexAscii-0x0030  //0 => 9
				
			: (($vl_hexAscii>=0x0041) & ($vl_hexAscii<=0x0046))  //A => F
				$ve_nibble:=$vl_hexAscii-0x0037  //10 => 15
				
			: (($vl_hexAscii>=0x0061) & ($vl_hexAscii<=0x0066))  //a => f
				$ve_nibble:=$vl_hexAscii-0x0057  //10 => 15
				
			Else 
				$ve_nibble:=0
		End case 
		
	Else 
		$ve_nibble:=0
	End if 
	
End if 
$0:=$ve_nibble
