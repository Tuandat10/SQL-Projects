select * 
from PortfolioProject.dbo.covid_death

-- Fill blank value with null value
UPDATE PortfolioProject.dbo.covid_death SET continent = NULL WHERE continent = ''


-- Change the data type of some columns
alter table PortfolioProject.dbo.covid_death
alter column total_cases Decimal(20,0)
alter table PortfolioProject.dbo.covid_death
alter column new_cases Decimal(20,0)
alter table PortfolioProject.dbo.covid_death
alter column total_deaths Decimal(20,0)
alter table PortfolioProject.dbo.covid_death
alter column population BIGINT
alter table PortfolioProject.dbo.covid_death
alter column date date


-- Select the data that we need to EDA

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject.dbo.covid_death
where continent is not null 
order by location, date

-- I want to know the percentage of total_deaths and total_cases in Vietnam

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deaht_percentage 
from PortfolioProject.dbo.covid_death
where location = 'Vietnam'
order by PortfolioProject.dbo.covid_death.date
 -- We can see that overall, the number of total_cases increase by the time, but death_percentage seems to increase but they also begin decreassing around 2021.

 -- I want to know the percentage of total_case by total population in Vietnam
 select date, location, total_cases, population, (total_cases/population)*100 as Percent_Population_infected
 from PortfolioProject.dbo.covid_death
 where location ='Vietnam'
 order by date
 -- The percent_population_infected increase over the period

 -- Showing all the countries with the highest infection rate compared to population
 select location, max(total_cases) as countries_maximum_cases, max((total_cases/population)*100) as maximum_percentage_infected
 from PortfolioProject.dbo.covid_death
 where population <> 0 and continent is not null
 Group by Location
 order by maximum_percentage_infected asc
 -- Suprisingly England and Scotland are ones of the countries that do not have any infected case, which is very weird. Cyprus is the country that have the largest number of infected case in a day.
 -- Showing all the countries with the highest death_rates compared to population
 select location, max(total_deaths) as countries_maximums_deaths, max((total_deaths/population)*100) as maximum_percentage_deaths
 from PortfolioProject.dbo.covid_death
 where population <> 0 and continent is not null
 group by location
 order by maximum_percentage_deaths
 -- Peru is the country that have the highest percentage of deaths rate per population. There are several countries do not have any death, especially England and Scotland.


 -- I want to know which continent has the highest death count
 select continent, max(total_deaths) as death_count
 from PortfolioProject.dbo.covid_death
 where continent is not null
 group by continent
 order by death_count desc
-- North America is the continent that has the highest number of death_count, next to it is South America, Asia, and so on


-- Showing the total number of cases, death and the percentage of deaths and cases globalisation
select sum(new_cases) as total_cases, sum(total_deaths) as total_deaths
from PortfolioProject.dbo.covid_death
where continent is not null


-- Join death table and vacination table
select a.continent, a.location, a.date, a.population, b.new_vaccinations,sum(cast(b.new_vaccinations as BIGINT)) over (partition by a.location) as Rolling_people_vaccinated
from PortfolioProject.dbo.covid_death as a
join PortfolioProject.dbo.covid_vacination as b
on a.location = b.location