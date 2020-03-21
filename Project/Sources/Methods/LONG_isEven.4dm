//%attributes = {"invisible":true}

  //================================================================================
  //@xdoc-start : en
  //@name : LONG_isEven
  //@scope : private
  //@deprecated : no
  //@description : This function returns True if number is even, False otherwise 
  //@parameter[0-OUT-isEven-BOOLEAN] : is even
  //@parameter[1-IN-number-LONGINT] : number to test
  //@notes :
  //@example : LONG_isEven 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 20/11/2012, 12:04:00 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_isEven)  //Renvoie Vrai si le nombre est pair 
C_LONGINT:C283($1;$vl_number)  //Nombre à tester

$vb_isEven:=False:C215

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>0)
	$vl_number:=$1
	
	$vb_isEven:=Not:C34($vl_number ?? 0)
	
	  // slower code :
	  //$vb_isEven:=(($vl_number%2)=0)
	
	  // slower code :
	  //$vb_isEven:=(($vl_number/2)=($vl_number\2))
	  //$vb_isEven:=(($vl_number%2)=0)
	
Else 
	ALERT:C41(Current method name:C684+" : Nombre de paramètres insuffisants.")
End if 
$0:=$vb_isEven