# ─── QUERY 1 ───
# Most recent values for every column in row student|007
get 'task2', 'student|007'

# ─── QUERY 2 ───
# Most recent values for every column in that specific submission row
get 'task2', 'submission|007|312|assignment|1'

# ─── QUERY 3 ───
# First name, last name, degree of all students
scan 'task2', {COLUMNS => ['STUDENT:fname', 'STUDENT:lname', 'STUDENT:degree']}

# ─── QUERY 4 ───
# All info for students whose last name = "Potter" (most recent per cell)
scan 'task2', {FILTER => "SingleColumnValueFilter('STUDENT','lname',=,'binary:Potter')"}

# ─── TASK 1 ───
alter 'task2', {NAME => 'FILES', METHOD => 'delete'}

# ─── TASK 2 ───
alter 'task2', {NAME => 'ENROLMENT', VERSIONS => 2}

# ─── TASK 3 ───
put 'task2', 'student|007', 'ENROLMENT:312', '2017-02-01'
put 'task2', 'student|007', 'ENROLMENT:312', '2018-02-01'
put 'task2', 'student|666', 'ENROLMENT:313', '2017-03-15'
put 'task2', 'student|666', 'ENROLMENT:313', '2018-03-15'

# ─── TASK 4 ───
scan 'task2', {COLUMNS => ['ENROLMENT'], VERSIONS => 2}

# ─── TASK 5 ───
alter 'task2', {NAME => 'ENROLMENT', VERSIONS => 5}

# ─── TASK 6 ───
disable 'task2'
drop 'task2'
