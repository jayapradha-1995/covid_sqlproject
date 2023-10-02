-- *************** --
-- START --
-- *************** --

-- EXPLORATION OF COVID DATA --
  select * from covid_data;
  
-- ************* 
-- SLIDE 2
-- SPREAD ACROSS WORLD
-- ************* 
select  location, max(total_cases) as spread from covid_data where continent<>'0' group by 1 order by 2 desc;

-- *************
-- SLIDE 3 
-- TOTAL CASES,TOTAL DEATHS AND TOTAL VACCINATION
-- *************
SELECT  max(total_cases) as SPREADS,max(total_deaths) as DEATHS,max(people_vaccinated) as total_vaccination from covid_data where location='world';

-- *************
-- SLIDE 4 
-- NEW CASES,NEW DEATHS AND TOTAL_VACCINATION ON DAILY BASIS
-- *************
-- NEW CASES
select date2,new_cases as cases from covid_data where continent<>'0' order by 1;
-- NEW DEATHS
select date2,new_deaths as deaths from covid_data where continent<>'0' order by 1;
-- TOTAL_VACCINATION 
select date(date2), max(total_vaccinations) as vaccinations from covid_data where continent<>'0' group by 1 order by 1;

-- ************* --
-- SLIDE 5 --
-- ************* --
-- SPREAD BY CONTINENT  --
select continent,sum(maxxx) as spreads from( select continent,location,max(total_cases) as maxxx from covid_data  
 group by 1,2 ) as m group by 1 having continent!='0' order by 2 desc;
 
 -- DEATHS BY CONTINENT --
 select continent,sum(maxxx) as deaths from( select continent,location,max(total_deaths) as maxxx from covid_data 
 group by 1,2 ) as m group by 1 having continent!='0' order by 2 desc;

-- ************** --
-- SLIDE 6  --
-- DAILY MONITORING OF SPREADS AND DEATHS
-- ************* --
SELECT date(date2) as daily_basis,new_cases from covid_data where location='world' order by 1;
SELECT date(date2) as daily_basis,new_deaths from covid_data where location='world' order by 1;

-- ************* --
-- CALCULATIONS 
-- SPREAD_PERCENT = TOTAL_CASES/POPULATION*100
-- DEATH_PERCENT = TOTAL_DEATHS/POPULATION*100
-- VACCINATED_PERCENT = PEOPLE_VACCINATED/POPULATION*100
-- ************* --

-- ************** --
-- SLIDE 7 --
-- SPREAD,DEATH,VACCINATION PERCENTAGE
-- ************** --

-- SPREAD
select location,population,max(total_cases)/population*100 as spread_percent from covid_data 
where continent!='0' and population>100000000
group by 1,2 order by 3  desc;

-- DEATH
select location,population,max(total_deaths)/population*100 as death_percent from covid_data 
where continent!='0' and population>100000000
group by 1,2 order by 3  desc;

-- VACCINATION
select location,population,max(people_vaccinated)/population*100 as vaccinated_percent from covid_data 
where continent!='0' and population>100000000
group by 1,2 order by 3  desc;

-- ************* --
-- CALCULATIONS
-- SURVIVALS = (TOTAL_CASES)-(TOTAL_DEATHS)
-- SURVIVAL_RATE = SURVIVALS/TOTAL_CASES *100

-- ************* --
 -- SLIDE 8 
 --  WORLD'S SURVIVALS AND SURVIVAL RATE FROM COVID 
 -- ************ --
 
 -- SURVIVALS
select location,max(total_cases)-max(total_deaths) as survivals from covid_data
 where  location='world' group by 1  order by 2 desc;
 
-- SURVIVALS_RATE
 select location, max(survival_rate) as survivalrate from ( select location,
 case
 when (total_cases-total_deaths)>0 then ((total_cases-total_deaths)/total_cases)*100 
 else 0 end as survival_rate
from covid_data where location='world' ) as temp group by 1 order by 2 desc;
   
 
-- ************* --
 -- SLIDE 8.1 
 --  INDIA'S SURVIVALS AND SURVIVAL RATE FROM COVID 
 -- ************ --
  -- SURVIVALS
select location,max(total_cases)-max(total_deaths) as survivals from covid_data
 where  location='INDIA' group by 1  order by 2 desc;
 -- SURVIVALS_RATE
 select location, max(survival_rate) as survivalrate from (select location,
 case
 when (total_cases-total_deaths)>0 then ((total_cases-total_deaths)/total_cases)*100 
 else 0 end as survival_rate
from covid_data where location='india' and date2='2022-10-05') as temp group by 1 order by 2 desc;
   
 -- *********** --
 -- SLIDE 9 
 -- SPREADS BY INCOME LEVEL
 -- ************* --
 SELECT location as income_level, max(total_cases)/max(population)*100 as spread from covid_data where 
 location in ('High income','Low income','Lower middle income','Upper middle income') group by 1
  order by 2 desc;
 
-- ************* -- 
-- SLIDE 10 --
-- GDP VS SPREAD
-- ************* --
select location,max(total_cases)/max(population)*100 as spread ,max(gdp_per_capita) as 	gdp_per_capita
from covid_data where continent<>'0' group by 1 ;

-- ************* -- 
-- SLIDE 11 --
-- GDP VS DEATHS
-- ************* --
select location,max(total_deaths)/max(population)*100 as Deaths ,max(gdp_per_capita) as 	gdp_per_capita
from covid_data where continent<>'0' group by 1 ;

-- **********  --
 -- end --
-- ********** --