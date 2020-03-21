//%attributes = {"invisible":true}

  //================================================================================
  //@xdoc-start : en
  //@name : ENV_v17orAbove
  //@scope : public
  //@deprecated : no
  //@description : This function returns TRUE if 4D is v14 or above 
  //@parameter[0-OUT-v15orAbove-TEXT] : returns True if 4D is v15 or above, False otherwise.
  //@notes :
  //@example : ENV_v17orAbove 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 29/12/2011, 14:25:15 - v1.00.00
  //@4xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_is4Dv17orAbove)  // is4Dv15orAbove

C_TEXT:C284($vt_appVers)
$vt_appVers:=Application version:C493

  //$vb_is4Dv17orAbove:=(Num(Sous chaine($vt_appVers;1;2))>=13)

C_TEXT:C284($va_appVersMajeur)
$va_appVersMajeur:=Substring:C12($vt_appVers;1;2)

Case of 
	: ($va_appVersMajeur="06")  //4D v6
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="07")  //4D v2003
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="08")  //4D v2004 
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="11")  //4Dv11
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="12")  //4Dv12
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="13")  //4Dv13
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="14")  //4Dv14
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="15")  //4Dv16
		$vb_is4Dv17orAbove:=False:C215
		
	: ($va_appVersMajeur="16")  //4Dv16
		$vb_is4Dv17orAbove:=False:C215
		
	Else 
		
		  //: ($va_appVersMajeur="17")  `4Dv17
		$vb_is4Dv17orAbove:=True:C214
		
End case 

$0:=$vb_is4Dv17orAbove