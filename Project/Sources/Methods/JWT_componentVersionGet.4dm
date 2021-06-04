//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}

  //================================================================================
  //@xdoc-start : en
  //@name : JWT_componentVersionGet
  //@scope : public
  //@deprecated : no
  //@description : This function returns the component version 
  //@parameter[0-OUT-componentVersion-TEXT] : component version (e.g. "2.00.00")
  //@notes :
  //@example : JWT_componentVersionGet 
  //@see : 
  //@version : 2.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : 
  // CREATION : Bruno LEGAY (BLE) - 03/05/2016, 19:29:05 - v1.00.00
  // MODIFICATION : Bruno LEGAY (BLE) - 28/02/2017, 06:37:49 - v1.00.04
  //  - improved comments/documentation
  // MODIFICATION : Bruno LEGAY (BLE) - 19/01/2020, 11:51:05 - v1.00.05
  //  - added support for native sha2 256 (from 4D v17+)
  // MODIFICATION : Bruno LEGAY (BLE) - 21/03/2020, 16:08:02 - v2.00.00
  //  - 4D v18 / project mode / 4D v14 backward compatible
  // MODIFICATION : Bruno LEGAY (BLE) - 04/06/2021, 15:12:20 - v2.00.01
  //  - clean-up, generated documentation in Markdown
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_componentVersion)

  //<Modif> Bruno LEGAY (BLE) (04/06/2021)
  // clean-up, generated documentation in Markdown
$vt_componentVersion:="2.00.01"
  //<Modif>

If (False:C215)
	
	  //<Modif> Bruno LEGAY (BLE) (21/03/2020)
	  // 4D v18 / project mode / 4D v14 backward compatible
	  // $vt_componentVersion:="2.00.00"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (19/01/2020)
	  // added support for native sha2 256 (from 4D v17+)
	  // $vt_componentVersion:="1.00.05"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (28/02/2017)
	  // improved comments/documentation
	  // $vt_componentVersion:="1.0.4"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (03/05/2016)
	  // added option to have password base64 encoded
	  // fixed a bug in JWT base64urlEncode (replace "+" => "-", "/" => "_")
	  // $vt_componentVersion:="1.0.3"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (03/05/2016)
	  // fixed bug (hard coded password)
	  // $vt_componentVersion:="1.0.2"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (03/05/2016)
	  // added JWT_componentVersionGet and JWT_signObject
	  // $vt_componentVersion:="1.0.1"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (03/05/2016)
	  // $vt_componentVersion:="1.0.0"
	  //<Modif>
	
End if 

$0:=$vt_componentVersion