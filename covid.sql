select *
from portfolio..CovidDeaths
order by 3,4

----select *
----from portfolio..CovidVaccinations
----order by 3,4

SELECT Location, date, total_cases, new_cases, total_deaths, population
from portfolio..CovidDeaths
order by 1,2

-- Looking at total cases per million vs total death
-- Shows likelihood of dying if you contract covid in your county
SELECT Location, date, total_cases, total_deaths, (total_cases_per_million/total_deaths)*100 as DeathPercentage
from portfolio..CovidDeaths
where location like '%states%'
order by 1,2

-- Looking at the total_cases per million vs population
-- Shows what percentage of population got covid

SELECT Location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
from portfolio..CovidDeaths
--where location like '%states%'
order by 1,2


-- looking at the countries with the highest infection rate compared to the population

SELECT Location, population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population)*100 as PercentPopulationInfected
from portfolio..CovidDeaths
--where location like '%states%'
Group  By location, population
order by PercentPopulationInfected desc

-- showing countries with highest death count per population

SELECT Location, MAX(cast(total_deaths as int)) as TotalDeathCount
from portfolio..CovidDeaths
--where location like '%states%'
where continent is not null
Group  By Location
order by TotalDeathCount desc


-- Lets break things down by continent


-- showing continent with the highest death count per population

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from portfolio..CovidDeaths
--where location like '%states%'
where continent is not null
Group  By continent
order by TotalDeathCount desc



--global numbers

select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM
(new_cases)*100 as DeathPercentage
from portfolio..CovidDeaths
--where location like'%states%'
where continent is not null
group by date
order by 1,2

--looking at total population vs vaccinations


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,	SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from portfolio..CovidDeaths dea
join portfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	order by 2,3

	--use cte

	with popvsvac (continent, location, date, population,new_vaccinations, RollingPeopleVaccinated)
	as
	(
	select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,	SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from portfolio..CovidDeaths dea
join portfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
--	order by 2,3
	)

select *, (RollingPeopleVaccinated/population)*100
from popvsvac




-- temp table

create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,	SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from portfolio..CovidDeaths dea
join portfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
--	order by 2,3


select *, (RollingPeopleVaccinated/population)*100
from #PercentPopulationVaccinated

--creating views to stroe data for later visualizations

create view PercentPopulationVaccinated as 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,	SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from portfolio..CovidDeaths dea
join portfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
--	order by 2,3


select *
from PercentPopulationVaccinated
