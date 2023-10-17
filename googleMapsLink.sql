CREATE OR REPLACE FUNCTION `project.dataset.getGoogleMapUrlFromGeopoints`(geopoints ARRAY<GEOGRAPHY>) AS (
(
/*
-- example directions link from Washington DC to New York City, to Bangor Maine

select `project.dataset.getGoogleMapUrlFromGeopoints`([
  st_geogpoint(-77.03538148994886,38.89652148353945)
  ,st_geogpoint(-74.00907684873216,40.715271877844074)
  ,st_geogpoint(-68.77329497639016,44.79992605294776 )
])
*/

select
  "https://www.google.com/maps/dir/"
    || array_to_string(
        array_agg(
          cast(st_y(geopoint) as string) 
          || ',' 
          || cast(st_x(geopoint) as string)
          order by ix
          )
          ,'/'
        )
    as google_map_url
from unnest(geopoints) as geopoint
with offset as ix
)
);