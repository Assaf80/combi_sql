select absorber,contact,count(*) from temp_voconjtheo
where (max_j_CW_LED<3 and IQE_percent >5)
group by absorber,contact;