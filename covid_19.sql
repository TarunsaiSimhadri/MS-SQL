USE covid_19;
GO

--fetching data from all the tables
SELECT * FROM country_wise_latest;

SELECT * FROM covid_19_clean_complete;

SELECT * FROM covid_19_india;

SELECT * FROM covid_vaccine_statewise;

SELECT * FROM day_wise;

SELECT * FROM full_grouped;

SELECT * FROM StatewiseTestingDetails;

SELECT * FROM usa_county_wise;

SELECT * FROM worldometer_data;

SELECT * FROM worldometer_data WHERE Country_Region = 'India';


--To find out the death percentage locally and globally

--globally
SELECT ROUND(100*(SUM(CAST(Deaths as float))/SUM(CAST(Confirmed as float))),2) as death_percentage FROM covid_19_clean_complete;
--locally
SELECT 100*(SUM(CAST(Deaths as float))/SUM(CAST(Confirmed as float))) as death_percentage FROM covid_19_clean_complete WHERE Country_Region = 'India';
 

--To find out the infected population percentage locally and globally

--globally
SELECT 100*SUM(CAST(CAST(TotalCases as bigint)as float))/SUM(CAST(CAST(Population as bigint) as float)) FROM worldometer_data;
--or
SELECT 100*SUM(CAST(TotalCases as float))/SUM(CAST(Population as float)) FROM worldometer_data;
--locally
SELECT 100*SUM(CAST(TotalCases as float))/SUM(CAST(Population as float)) FROM worldometer_data WHERE Country_Region = 'India';


--To find out the countries with the highest infection rates
SELECT TOP 10 Country_Region, (CAST(TotalCases AS float) / CAST(Population as float)) * 100 AS infection_rate
FROM worldometer_data
ORDER BY infection_rate DESC;


--To find out the countries and continents with the highest death counts
SELECT Country_Region
FROM worldometer_data
ORDER BY TotalDeaths DESC;


--Average number of deaths by day (Continents and Countries)
SELECT AVG(Deaths) AS Average_Deaths
FROM day_wise;


--Average of cases divided by the number of population of each country (TOP 10)
SELECT AVG(CAST(TotalCases as float))/Population AS avg_cases
FROM worldometer_data
GROUP BY Population; 


--Considering the highest value of total cases, which countries have the highest rate of infection in relation to population?
SELECT TOP 10 Country_Region, (CAST(TotalCases AS float) / CAST(Population as float)) * 100 AS infection_rate 
FROM worldometer_data 
ORDER BY infection_rate DESC,TotalCases DESC;


--Using JOINS to combine the covid_deaths and covid_vaccine tables :

--To find out the population vs the number of people vaccinated
SELECT wd.Population, cvs.Total_Doses_Administered, cvs.State
FROM worldometer_data as wd cross join covid_vaccine_statewise as cvs
WHERE wd.Country_Region = 'India';

SELECT Population,(SELECT SUM(Total_Doses_Administered) FROM covid_vaccine_statewise) AS Total_Doses FROM worldometer_data WHERE Country_Region = 'India';


--To find out the percentage of different vaccine taken by people in a country
SELECT 100 * SUM(CAST(Population AS float))/(SELECT SUM(Covaxin_Doses_Administered) FROM covid_vaccine_statewise)  AS Covaxin_people_percentage FROM worldometer_data WHERE Country_Region = 'India';

SELECT 100 * SUM(CAST(Population AS float))/(SELECT SUM(CoviShield_Doses_Administered) FROM covid_vaccine_statewise)  AS CoviSheild_people_percentage FROM worldometer_data WHERE Country_Region = 'India';

SELECT 100 * SUM(CAST(Population AS float))/(SELECT SUM(Sputnik_V_Doses_Administered) FROM covid_vaccine_statewise)  AS putnik_V_Doses_people_percentage FROM worldometer_data WHERE Country_Region = 'India';


--To find out percentage of people who took both the doses
SELECT 100 * SUM(CAST(Population AS float))/(SELECT SUM(Total_Doses_Administered) FROM  covid_vaccine_statewise) AS percentange_people_taken_both_doses FROM worldometer_data WHERE Country_Region = 'India';
