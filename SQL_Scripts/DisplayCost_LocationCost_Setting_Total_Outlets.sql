select SUM(s.displaycost + coalesce(rd.locationcost, 0)) costSetting
from fcvplatform.psoutletmonthlyregisterdetail rd,
  fcvplatform.psoutletmonthlyregister r ,
  fcvplatform.psoutlet o,
  fcvplatform.psoutletmodelsetting s,
  fcvplatform.psoutletmodelsettingsegment sm
WHERE rd.outletmodelId = s.outletModelId and r.month = %THANG AND r.year = %NAM and sm.psoutletmodelsettingsegmentid = s.psoutletmodelsettingsegmentid
      and r.status = 100
      and r.outletId = o.outletId
      and rd.psoutletmonthlyregisterid = r.psoutletmonthlyregisterid and o.code in (%MA_CH)
      and sm.name = 'DEFAULT';