USE usersprogressdb;

-- 1. Analyse the data
-- Hint: use a SELECT statement via a JOIN to sample the data
-- ****************************************************************
SELECT u.*, p.learn_cpp, p.learn_sql, p.learn_html, p.learn_javascript, p.learn_java
FROM users u JOIN progress p ON u.user_id = p.user_id;

-- 2. What are the Top 25 schools (.edu domains)?
-- Hint: use an aggregate function to COUNT() schools with most students
-- ****************************************************************
SELECT email_domain, COUNT(*) AS 'student_count'
FROM users
WHERE email_domain LIKE '%.edu'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 25;

-- 3. How many .edu learners are located in New York?
-- Hint: use an aggregate function to COUNT() students in New York
-- ****************************************************************
SELECT COUNT(*) AS ny_edu_learners
FROM users
WHERE email_domain LIKE '%.edu'
  AND city = 'New York';

-- 4. The mobile_app column contains either mobile-user or NULL. 
-- How many of these learners are using the mobile app?
-- Hint: COUNT()...WHERE...IN()...GROUP BY...
-- Hint: Alternate answers are accepted.
-- ****************************************************************
SELECT mobile_app, COUNT(*) FROM users
WHERE mobile_app = 'mobile-user'
GROUP BY mobile_app;

-- 5. Query for the sign up counts for each hour.
-- Hint: https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_date-format 
-- ****************************************************************
SELECT DATE_FORMAT(sign_up_at, '%H') AS hour, COUNT(*) AS signups
FROM users
GROUP BY hour
ORDER BY hour;

-- 6. What courses are the New Yorker Students taking?
-- Hint: SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking C++"
-- ****************************************************************
SELECT 
    SUM(CASE WHEN learn_cpp != '' THEN 1 ELSE 0 END) AS "NY Students taking C++",
    SUM(CASE WHEN learn_sql != '' THEN 1 ELSE 0 END) AS "NY Students taking SQL",
    SUM(CASE WHEN learn_html != '' THEN 1 ELSE 0 END) AS "NY Students taking HTML",
    SUM(CASE WHEN learn_javascript != '' THEN 1 ELSE 0 END) AS "NY Students taking JavaScript",
    SUM(CASE WHEN learn_java != '' THEN 1 ELSE 0 END) AS "NY Students taking Java"
FROM users u
JOIN progress p ON u.user_id = p.user_id
WHERE u.city = 'New York';

-- 7. What courses are the Chicago Students taking?
-- Hint: SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking C++"
-- ****************************************************************
SELECT 
    SUM(CASE WHEN learn_cpp != '' THEN 1 ELSE 0 END) AS "Chicago Students taking C++",
    SUM(CASE WHEN learn_sql != '' THEN 1 ELSE 0 END) AS "Chicago Students taking SQL",
    SUM(CASE WHEN learn_html != '' THEN 1 ELSE 0 END) AS "Chicago Students taking HTML",
    SUM(CASE WHEN learn_javascript != '' THEN 1 ELSE 0 END) AS "Chicago Students taking JavaScript",
    SUM(CASE WHEN learn_java != '' THEN 1 ELSE 0 END) AS "Chicago Students taking Java"
FROM users u
JOIN progress p ON u.user_id = p.user_id
WHERE u.city = 'Chicago';
