# US Household Income Exploratory Data Analysis

SELECT * FROM Household_sql.ushouseholdincome_statistics;

SELECT * FROM Household_sql.ushouseholdincome;

#Let's select the column I want to work with
SELECT State_name, Aland, Awater
FROM Household_sql.ushouseholdincome;

#Total size of each state & order it from smallest to largest
SELECT State_name,  SUM(Aland), SUM(Awater)
FROM Household_sql.ushouseholdincome
GROUP BY State_name
ORDER BY 2;

#I wanted to check the top 10 largest States by land
SELECT State_name,  SUM(Aland), SUM(Awater)
FROM Household_sql.ushouseholdincome
GROUP BY State_name
ORDER BY 2
LIMIT 10;

#Now let's do the same, but for water - these will be states that have a lot of lakes or rivers
SELECT State_name,  SUM(Aland), SUM(Awater)
FROM Household_sql.ushouseholdincome
GROUP BY State_name
ORDER BY 3
LIMIT 10;

#Join tables together
SELECT *
FROM Household_sql.ushouseholdincome ui
JOIN Household_sql.ushouseholdincome_statistics us
	ON ui.id = us.id;

#Found some zero values by just looking at the data    
SELECT *
FROM Household_sql.ushouseholdincome ui
JOIN Household_sql.ushouseholdincome_statistics us
	ON ui.id = us.id
WHERE Mean <> 0;

#Now start filtering on the columns I want
SELECT ui.State_Name
FROM Household_sql.ushouseholdincome ui
JOIN Household_sql.ushouseholdincome_statistics us
	ON ui.id = us.id
    WHERE Mean <> 0
GROUP BY ui.State_Name
ORDER BY 2
LIMIT 5;

#First, let's look at just the state lever the avg mean & median. These are the lowest paid or at least have the lowest income in the US.
SELECT ui.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM Household_sql.ushouseholdincome ui
JOIN Household_sql.ushouseholdincome_statistics us
	ON ui.id = us.id
WHERE Mean <> 0
GROUP BY ui.State_Name
ORDER BY 2
LIMIT 5;

#Now, let's filter it by type
SELECT Type, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM Household_sql.ushouseholdincome ui
JOIN Household_sql.ushouseholdincome_statistics us
	ON ui.id = us.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 3;
#CDP type is dramatically higher

#Let's do Ccount of type
SELECT Type, COUNT(TYPE), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM Household_sql.ushouseholdincome ui
JOIN Household_sql.ushouseholdincome_statistics us
	ON ui.id = us.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 4;
#Municipality is high, but only has 1 row in the entire dataset, so that's skewed

#Iwant to see which type has more than 100 rows of data
SELECT Type, COUNT(TYPE), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM Household_sql.ushouseholdincome ui
JOIN Household_sql.ushouseholdincome_statistics us
	ON ui.id = us.id
WHERE Mean <> 0
GROUP BY Type
HAVING COUNT(TYPE) >100
ORDER BY 1
LIMIT 20;

#I wanted to filter on comunity because it was showing very low income and I wanted to see what state that is and it was Puerto Rico
SELECT *
FROM Household_sql.ushouseholdincome
WHERE Type = 'community';

#Last I wanted to filter it on the city, so i can see which city makes the lowest/highest income
SELECT ui.state_name, city, ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM Household_sql.ushouseholdincome ui
JOIN Household_sql.ushouseholdincome_statistics us
	ON ui.id = us.id
GROUP BY ui.state_name, city
ORDER BY ROUND(AVG(mean),1) DESC;
 

