with rs as (
    select p.code from fcvplatform.product p
    WHERE exists(
        SELECT 1
        FROM fcvplatform.outletmodeldetail omd
        WHERE p.code = ANY(string_to_array(referencevalue, ',')::VARCHAR[])
              AND omd.outletmodelid in (%MODELGROUP)
                  -- U Ke DBB:289, SCM: 297, NGUYENKEM: 304, FRISO: 327, U IFT: 362, FINO: 377, FRISTI: 391
    )
)
select sum(s.saleamount) from fcvplatform.%DOANHSO_NAM s
where s.psoutletid IN (select pso.outletid from fcvplatform.psoutlet pso, fcvplatform.subdistributor sd
                      where pso.sub_distributorid = sd.distributorid AND sd.code = '%MA_NPP')
      and s.yyyymm >= %NAM%THANG_BEGIN and s.yyyymm <= %NAM%THANG_END
      and s.productcode in (select code from rs)
      and (s.mergestatus = false or s.mergestatus is null)
group by s.distributorid;