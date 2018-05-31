SELECT c.outletmodelgroupid, d.name, c.displaylocationid, c.locationcost
FROM fcvplatform.psoutlet a,
  fcvplatform.psoutletmonthlyregister b,
  fcvplatform.psoutletmonthlyregisterdetail c,
  fcvplatform.outletmodel d
WHERE a.outletid = b.outletid
AND   b.psoutletmonthlyregisterid = c.psoutletmonthlyregisterid
AND   c.outletmodelgroupid = d.outletmodelgroupid
AND   c.outletmodelid = d.outletmodelid
AND   a.code = %MA_CH
AND   b.month = %THANG and b.year = %NAM;