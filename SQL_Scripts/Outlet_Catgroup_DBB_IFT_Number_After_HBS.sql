SELECT distinct o.code
FROM fcvplatform.psoutletmonthlyregister r,
  fcvplatform.psoutlet o,
  fcvplatform.subdistributor sd
WHERE r.month = %THANG AND year = %NAM
      AND r.outletid = o.outletid
      AND o.sub_distributorid = sd.distributorid
      AND sd.code = '%MA_NPP'
AND r.psoutletmonthlyregisterid IN (
  SELECT psoutletmonthlyregisterid
  FROM fcvplatform.psoutletmonthlyregisterdetail rd,
    fcvplatform.outletmodel om,
    fcvplatform.catgroup cat
  WHERE rd.outletmodelid = om.outletmodelid
      AND om.catgroupid = cat.catgroupid
      AND cat.name IN ('DBB')
)
AND r.psoutletmonthlyregisterid IN (
  SELECT psoutletmonthlyregisterid
  FROM fcvplatform.psoutletmonthlyregisterdetail rd,
    fcvplatform.outletmodel om,
    fcvplatform.catgroup cat
  WHERE rd.outletmodelid = om.outletmodelid
        AND om.catgroupid = cat.catgroupid
        AND cat.name IN ('IFT'));