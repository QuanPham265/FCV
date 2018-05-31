
SELECT count(*)
FROM fcvplatform.psoutlet o, fcvplatform.subdistributor sd
WHERE o.sub_distributorid = sd.distributorid AND sd.code = '%MA_NPP';