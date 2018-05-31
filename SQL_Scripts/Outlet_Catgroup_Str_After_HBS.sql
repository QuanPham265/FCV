SELECT array_agg(distinct  quote_literal(o.code)) AS actor_list
FROM fcvplatform.psoutletmonthlyregisterdetail rd,
  fcvplatform.psoutletmonthlyregister r,
  fcvplatform.psoutlet o,
  fcvplatform.subdistributor sd,
  fcvplatform.outletmodel om,
  fcvplatform.catgroup cat
WHERE r.month = %THANG AND year = %NAM
      AND r.psoutletmonthlyregisterid = rd.psoutletmonthlyregisterid
      AND rd.outletmodelid = om.outletmodelid
      AND om.catgroupid = cat.catgroupid
      AND r.outletid = o.outletid
      AND o.sub_distributorid = sd.distributorid
      AND sd.code = '%MA_NPP'
      AND cat.name = '%NGANH_HANG'  --DBB/IFT
GROUP BY cat.catgroupid;