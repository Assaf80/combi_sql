/*insert into bad_QE_identifiers (identifier,ts,reason,owner)  
select identifier,
    curdate() as ts,
    'not the last possible absorber layer' as reason,
    13 as owner from
    (*/
select absorber,contact,materials,identifier,count(*) from temp_voconjtheo
join mirror_vsamples on mirror_vsamples.sample_id= temp_voconjtheo.sample_id

where 
#locate('CH3NH3',materials)=0
absorber='TiO2'
#and (max_j_CW_LED<7 and IQE_percent >10)
and identifier not in (select identifier from bad_qe_identifiers)
group by absorber,contact,materials,identifier;
/*) aa
;

drop table bad_qe_identifiers;

select 
    *
from
    bad_qe_identifiers