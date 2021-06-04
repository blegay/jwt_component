//%attributes = {"invisible":true,"preemptive":"incapable","shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : JWT__signObjectTest
  //@scope : public
  //@deprecated : no
  //@description : Unit test method
  //@notes :
  //@example : JWT__signObjectTest 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 21/03/2020, 08:58:43 - v1.00.00
  //@xdoc-end
  //================================================================================

SET ASSERT ENABLED:C1131(True:C214)

  // create JWT sample payload object
C_OBJECT:C1216($vo_payload)
CLEAR VARIABLE:C89($vo_payload)

OB SET:C1220($vo_payload;"sub";"1234567890")
OB SET:C1220($vo_payload;"name";"John Doe")
OB SET:C1220($vo_payload;"admin";True:C214)

SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vo_payload))



ASSERT:C1129(JWT_signObject ($vo_payload;"secret")="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ")
ASSERT:C1129(JWT_signJson (JSON Stringify:C1217($vo_payload);"secret")="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ")



ASSERT:C1129(JWT_signObject ($vo_payload;"c2VjcmV0";True:C214)="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ")
ASSERT:C1129(JWT_signJson (JSON Stringify:C1217($vo_payload);"c2VjcmV0";True:C214)="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ")



CLEAR VARIABLE:C89($vo_payload)

OB SET:C1220($vo_payload;"sub";"1234567890")
OB SET:C1220($vo_payload;"name";"John Doe/")
OB SET:C1220($vo_payload;"admin";True:C214)

ASSERT:C1129(JWT_signObject ($vo_payload;"secret")="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lLyIsImFkbWluIjp0cnVlfQ.Aj4hKn4sL0EqjjB2ulAQvYWsLxksRB0uTFl7oIFLVI8")
ASSERT:C1129(JWT_signJson (JSON Stringify:C1217($vo_payload);"secret")="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lLyIsImFkbWluIjp0cnVlfQ.Aj4hKn4sL0EqjjB2ulAQvYWsLxksRB0uTFl7oIFLVI8")


CLEAR VARIABLE:C89($vo_payload)

OB SET:C1220($vo_payload;"sub";"1234567890")
OB SET:C1220($vo_payload;"name";"John Doe//")
OB SET:C1220($vo_payload;"admin";True:C214)

ASSERT:C1129(JWT_signObject ($vo_payload;"secret")="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lLy8iLCJhZG1pbiI6dHJ1ZX0.aSgNFGmrs2wjc_robjy0H-mmNWDTvrMoxuc8UTWd5GY")
ASSERT:C1129(JWT_signJson (JSON Stringify:C1217($vo_payload);"secret")="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lLy8iLCJhZG1pbiI6dHJ1ZX0.aSgNFGmrs2wjc_robjy0H-mmNWDTvrMoxuc8UTWd5GY")

