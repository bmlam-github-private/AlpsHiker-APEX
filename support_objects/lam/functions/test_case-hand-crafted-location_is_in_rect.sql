PROMPT on minus-minus quadrant , expect 2 
SELECT location_is_in_rect( loc_lon=> -3, loc_lat=> -2, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> -3, rect_b_lat=> -3 ) AS result FROM dual;

PROMPT on minus-minus quadrant , expect 0
SELECT location_is_in_rect( loc_lon=>  0, loc_lat=>  0, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> -3, rect_b_lat=> -3 ) AS result FROM dual;
 loc_lat=>  -1, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;

--
PROMPT rect on all quadrants ,  expect 2
SELECT location_is_in_rect( loc_lon=>  0, loc_lat=>   0, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;

PROMPT rect on all quadrants ,  expect 1
SELECT location_is_in_rect( loc_lon=>  1, loc_lat=>   0, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;

PROMPT rect on all quadrants ,  expect 0
SELECT location_is_in_rect( loc_lon=> -2, loc_lat=>   3, rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;


PROMPT rect on plus plus quadrants ,  expect 2
SELECT location_is_in_rect( loc_lon=> .5, loc_lat=> .5, rect_a_lon=>  0, rect_a_lat=>  0, rect_b_lon=>  1, rect_b_lat=> 1 ) AS result FROM dual;

PROMPT rect on plus plus quadrants ,  expect 0
SELECT location_is_in_rect( loc_lon=> 15, loc_lat=> 15, rect_a_lon=>  0, rect_a_lat=>  0, rect_b_lon=>  1, rect_b_lat=> 1 ) AS result FROM dual;


PROMPT rect is line on x axis ,  expect 1
SELECT location_is_in_rect( loc_lon=> nn, loc_lat=>  0, rect_a_lon=>  0, rect_a_lat=>  0, rect_b_lon=> 1, rect_b_lat=>  0 ) AS result FROM dual;
