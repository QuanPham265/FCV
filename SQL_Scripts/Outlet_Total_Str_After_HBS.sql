-- return string combine outletcode. example: '337375C00253256', '337375C00253257', '337375C00253258'...
SELECT array_agg(distinct  quote_literal(o.code)) AS actor_list
FROM fcvplatform.psoutletmonthlyregister r, fcvplatform.psoutlet o, fcvplatform.subdistributor sd
WHERE r.month = %THANG AND year = %NAM
      AND r.outletid = o.outletid
      AND o.sub_distributorid = sd.distributorid
      AND sd.code = '%MA_NPP';
