select absorber,contact,materials,count(*) from temp_voconjtheo
join mirror_vsamples on mirror_vsamples.sample_id= temp_voconjtheo.sample_id
where (max_j_CW_LED<3 and IQE_percent >5)
group by absorber,contact,materials;

select  * from temp_voconjtheo