-- Total Invoice value all outlet with full modelgroup,products

with rs as (
    select p.code from fcvplatform.product p
    WHERE exists(
        SELECT 1
        FROM fcvplatform.outletmodeldetail omd
        WHERE p.code = ANY(string_to_array(referencevalue, ',')::VARCHAR[])
              AND omd.outletmodelid in (289,297,304,327,362,377,391)
        -- U Ke DBB:289, SCM: 297, NGUYENKEM: 304, FRISO: 327, U IFT: 362, FINO: 377, FRISTI: 391
    )
)
select sum(s.saleamount)
from fcvplatform.%DOANHSO_NAM s, fcvplatform.psoutlet pso
where s.psoutletid = pso.outletid
      and s.yyyymm >= %NAM%THANG_BEGIN and s.yyyymm <= %NAM%THANG_END
      and s.productcode in (select code from rs)
      and (s.mergestatus = false or s.mergestatus is null)
      AND pso.code in (%MA_CH);

