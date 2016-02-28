select * from 
(select 
	count(sample) cnt,
	owners.name,
round(avg(
#filled(rastering_angle_from-rastering_angle_to) +
filled(repetition_rate) +
filled(beam_scanner) +
#filled(rastering_vel) +
filled(ts_distance) +
filled(pulses)
),1) as score,
if(		
#filled(rastering_angle_from-rastering_angle_to) +
filled(repetition_rate) +
filled(beam_scanner) +
#filled(rastering_vel) +
filled(ts_distance) +
filled(pulses) 
=0,'Not recorded',if(
#filled(rastering_angle_from-rastering_angle_to) +
filled(repetition_rate) +
filled(beam_scanner) +
#filled(rastering_vel) +
filled(ts_distance) +
filled(pulses)
=8,'Seems ok','Check Record')) state,
substring(group_concat(distinct samples.name order by samples.name desc separator ',' ) from 1 for 128) samples
from sub_layers
left join pld on pld.sub_layer = sub_layers.sub_layer_id
join layers on layers.layer_id = sub_layers.layer
join owners on owners.id = layers.owner
join samples on samples.sample_id = layers.sample
join sample_states on (sample_states.id=samples.sample_state)
where synthesis_method=0
and samples.sample_state<>4
and owners.active=1
group by owners.name,state
order by state asc,cnt desc, owners.name asc
) aa
where state = "Not recorded";
