--assoc.js[
SELECT web_user.user_email, user_role.user_role_title, dive_location.location_name,  dive_log.dive_date
FROM web_user,user_role,dive_location,dive_log
WHERE web_user.user_role_id = user_role.user_role_id AND web_user.web_user_id = dive_log.web_user_id
AND dive_location.dive_location = dive_log.dive_location_id


--all fields
SELECT 
loc.location_name,
loc.city,
loc.state,
loc.type,
loc.access_via,
loc.average_depth,
loc.average_visibility,
loc.features,
log.dive_log_id,
log.dive_date,
log.number_dives,
log.minutes_per_dive,
log.air_type,
log.max_depth,
(select wu.user_email from web_user wu where wu.web_user_id = log.dive_buddy) as dive_buddy,
log.notes,
wu.web_user_id,
wu.user_email,
wu.user_password,
wu.birthday,
wu.user_role_id,
ur.user_role_title
FROM dive_location loc, dive_log log, web_user wu,user_role ur
where loc.dive_location = log.dive_location_id  AND
wu.web_user_id = log.web_user_id AND ur.user_role_id = wu.user_role_id
ORDER BY wu.user_email




SELECT wu.user_email,ur.user_role_title,loc.location_name,loc.city,loc.state,log.dive_date,log.number_dives,log.minutes_per_dive,log.air_type,log.max_depth,(SELECT wu.user_email FROM web_user wu WHERE wu.web_user_id = log.dive_buddy) as dive_buddy,log.notes,FROM dive_location loc, dive_log log, web_user wu,user_role ur WHERE loc.dive_location = log.dive_location_id  AND wu.web_user_id = log.web_user_id AND ur.user_role_id = wu.user_role_id ORDER BY log.dive_date,wu.user_email

--oother.jsp  
SELECT`dive_location`.`dive_location`,
`dive_location`.`location_name`,
`dive_location`.`city`,
`dive_location`.`state`,
`dive_location`.`type`,
`dive_location`.`access_via`,
`dive_location`.`average_depth`,
`dive_location`.`average_visibility`,
`dive_location`.`features`
FROM `SP13_2308_tue65786`.`dive_location`;


SELECT
`dive_log`.`dive_log_id`,
`dive_log`.`dive_date`,
`dive_log`.`number_dives`,
`dive_log`.`minutes_per_dive`,
`dive_log`.`air_type`,
`dive_log`.`max_depth`,
`dive_log`.`dive_buddy`,
`dive_log`.`notes`,
`dive_log`.`dive_location_id`,
`dive_log`.`web_user_id`
FROM `SP13_2308_tue65786`.`dive_log`;


`web_user`.`web_user_id`,
`web_user`.`user_email`,
`web_user`.`user_password`,
`web_user`.`birthday`,
`web_user`.`membership_fee`,
`web_user`.`user_role_id`
FROM `web_user`;
