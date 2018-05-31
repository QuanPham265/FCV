-- return list outletcode example: '337375C00253256', '337375C00253257', '337375C00253258' display as column

SELECT distinct o.code
FROM fcvplatform.psoutletmonthlyregisterdetail rd,
  fcvplatform.psoutletmonthlyregister r,
  fcvplatform.psoutlet o,
  fcvplatform.subdistributor sd,
  fcvplatform.outletmodelgroup omg
WHERE r.month = %THANG AND year = %NAM
      AND r.psoutletmonthlyregisterid = rd.psoutletmonthlyregisterid
      AND rd.outletmodelgroupId = omg.outletmodelgroupId
      AND r.outletid = o.outletid
      AND o.sub_distributorid = sd.distributorid
      AND sd.code = '%MA_NPP'
      AND omg.name = '%MUC_TRUNG_BAY'
