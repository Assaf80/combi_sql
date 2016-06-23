/*insert into bad_QE_identifiers (identifier,ts,reason,owner)  
select identifier,
    curdate() as ts,
    'not the last possible absorber layer' as reason,
    13 as owner from
    (*/
select absorber,contact,materials,Materials_no_BC ,identifier,max(temp_voconjtheo.max_j_CW_LED) ,count(*) from temp_voconjtheo
join mirror_vsamples on mirror_vsamples.sample_id= temp_voconjtheo.sample_id
join materials_per_sample_nobc on materials_per_sample_nobc.sample_id = temp_voconjtheo.sample_id
where 
#locate('CH3NH3',materials)=0
#absorber='SrTiO3'
#and 
(max_j_CW_LED<3.7 and IQE_percent >2.5)
and 
absorber <> Materials_no_BC
and identifier not in (select identifier from bad_qe_identifiers)
and  in (select o)
group by absorber,contact,materials,identifier;
) aa
;

drop table bad_qe_identifiers;

select 
    *
from
    bad_qe_identifiers