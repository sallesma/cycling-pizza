-- Extract the statuses of all stations for the previous day

SELECT
  s.id,
  s.latitude,
  s.longitude,
  ss.last_update_at AS update_at,
  ss.available_bikes,
  ss.stands,
  ss.available_bikes::decimal / ss.stands AS occupation
FROM
  stations s
  INNER JOIN station_statuses ss ON ss.station_id = s.id
WHERE
  ss.last_update_at >= '2017-03-01'
  AND ss.last_update_at < '2017-03-02'
;
