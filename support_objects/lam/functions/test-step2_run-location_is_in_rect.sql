set echo on
col result format 99

SELECT location_is_in_rect( loc_lon=>3, loc_lat=>3, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>1, loc_lat=>3, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>0, loc_lat=>3, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>-1, loc_lat=>3, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>-2, loc_lat=>3, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>3, loc_lat=>1, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>1, loc_lat=>1, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>0, loc_lat=>1, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>-1, loc_lat=>1, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>-2, loc_lat=>1, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>3, loc_lat=>0, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>1, loc_lat=>0, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>0, loc_lat=>0, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>-1, loc_lat=>0, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>-2, loc_lat=>0, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>3, loc_lat=>-1, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>1, loc_lat=>-1, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>0, loc_lat=>-1, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>-1, loc_lat=>-1, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>-2, loc_lat=>-1, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>3, loc_lat=>-2, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>1, loc_lat=>-2, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>0, loc_lat=>-2, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>-1, loc_lat=>-2, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
SELECT location_is_in_rect( loc_lon=>-2, loc_lat=>-2, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;
