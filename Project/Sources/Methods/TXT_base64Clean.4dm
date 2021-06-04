//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}

  //================================================================================
  //@xdoc-start : en
  //@name : TXT_base64Clean
  //@scope : public
  //@deprecated : no
  //@description : This function cleans a base64 text (removes "\r" and "\n")
  //@parameter[1-IN-base64TextPtr-POINTER] : base 64 text pointer (modified)
  //@notes :
  //@example : TXT_base64Clean 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 15/12/2015, 10:11:35 - v1.00.00
  //@xdoc-end
  //================================================================================

C_POINTER:C301($1;$vp_base64TextPtr)

If (Count parameters:C259>0)
	$vp_base64TextPtr:=$1
	
	ASSERT:C1129(Type:C295($vp_base64TextPtr->)=Is text:K8:3)
	
	  //Si (Longueur($vp_base64TextPtr->)>60) // Optimisation ?
	
	  //<Modif> Bruno LEGAY (BLE) (25/07/2014)
	  // on mac os x 10.6 and windows 7, ENCODER BASE64, adds LF to make lines of 60 chars (4D v12.6, also 4D v13), a priori pas de CR
	  //Si (Longueur($vt_textBase64Encoded)>60)
	If (Position:C15("\n";$vp_base64TextPtr->;*)>0)
		$vp_base64TextPtr->:=Replace string:C233($vp_base64TextPtr->;"\n";"";*)
	End if 
	  //Fin de si 
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (15/12/2015)
	  // http://forums.4d.fr/NewPost/FR/16557295/17223699
	  // Koen VAN HOOREWEGHE noticed that 4D v15 does generate base 64 data with \n and \r (this is a new "feature") after 4000 characters
	If (Position:C15("\r";$vp_base64TextPtr->;*)>0)
		$vp_base64TextPtr->:=Replace string:C233($vp_base64TextPtr->;"\r";"";*)
	End if 
	  //<Modif>
	
	  //Fin de si 
End if 