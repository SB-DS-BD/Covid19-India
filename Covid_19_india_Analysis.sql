create database COVID19_India;
/*1*/
Select * from agegroupdetails order by TotalCases desc limit 3;
/*2*/
select state, sum(Confirmed) as TotalConfirmedCases,sum(Cured) as TotalCured, 
sum(Deaths) as TotalDeaths from covid_19_india group by State order by 2 desc;
/*3*/
select str_to_date(Date,'%d-%m-%Y') as Date, sum(Confirmed) as TotalConfirmedCases,
sum(Cured) as TotalCured, sum(Deaths) as TotalDeaths from covid_19_india group by 
str_to_date(Date,'%d-%m-%Y') order by 2 desc;
/*4*/
select State, TotalPublicHealthFacilities_HMIS+NumRuralHospitals_NHP18+ 
NumUrbanHospitals_NHP18 as TotalHospitals, NumPublicBeds_HMIS+NumRuralBeds_NHP18+
NumUrbanBeds_NHP18 as TotalBeds from hospitalbedsindia order by 3 desc;
/*5*/
select temp1.state,totalhospitals,totalbeds,TotalConfirmedCases,TotalCured,
TotalDeaths from
(select State, TotalPublicHealthFacilities_HMIS+NumRuralHospitals_NHP18+ 
NumUrbanHospitals_NHP18 as TotalHospitals, NumPublicBeds_HMIS+NumRuralBeds_NHP18+
NumUrbanBeds_NHP18 as TotalBeds from hospitalbedsindia) as Temp1,
(select state, sum(Confirmed) as TotalConfirmedCases,sum(Cured) as TotalCured, 
sum(Deaths) as TotalDeaths from covid_19_india group by State) as 
Temp2 where temp1.State=temp2.State order by TotalConfirmedCases desc;
/*6*/
Select state, TotalConfirmedCases-(TotalCured+TotalDeaths) as UnderTreatment from
(select state, sum(Confirmed) as TotalConfirmedCases,sum(Cured) as TotalCured, 
sum(Deaths) as TotalDeaths from covid_19_india group by State) as Temp order by 2;
/*7*/
select left(DateTime,10) as Date, TotalPositiveCases,TotalSamplesTested-TotalIndividualsTested as TotalPullTest, 
TotalSamplesTested-TotalPositiveCases as TotalNegTest, concat(round((TotalPositiveCases*100)/TotalIndividualsTested,2),'%') 
as PositiveCasePercentage from icmrtestingdetails order by cast(TotalPositiveCases as signed) desc;
/*8*/
select count(id) as NumberofEff, gender, age from individualdetails where age>40
group by gender,age
order by 1 desc;
/*9*/
select nationality, count(id) as NumberofEff from individualdetails where nationality 
<> 'India' group by nationality order by 2 desc;
/*10*/
select current_status, count(id) as NumberofEff from individualdetails group 
by current_status;
/*11*/
select id, detected_state,detected_city,current_status,datediff(str_to_date(left(status_change_date,
10),'%d-%m-%Y'),str_to_date(left(diagnosed_date,10),'%d-%m-%Y')) as Days
from individualdetails where current_status='Recovered' order by 5 desc;
/*12*/
select StateUnionTerritory,round(TotalConfirmedCases/Population,5) as Ratio from
(select StateUnionTerritory,Population from population_india_census2011) as temp1,
(select state, sum(Confirmed) as TotalConfirmedCases from covid_19_india group by 
State) as temp2 where temp1.StateUnionTerritory=temp2.state order by 2 desc;
/*13*/
select State,NumRuralBeds_NHP18/RuralPopulation as RurPopBedRatio,
NumUrbanBeds_NHP18/UrbanPopulation as UrbPopBedRatio from
(select State,RuralPopulation,NumRuralHospitals_NHP18,NumRuralBeds_NHP18,
UrbanPopulation,NumUrbanHospitals_NHP18,NumUrbanBeds_NHP18 from
(select StateUnionTerritory,RuralPopulation,UrbanPopulation from 
population_india_census2011) as temp1,
(select State,NumRuralHospitals_NHP18,NumRuralBeds_NHP18,NumUrbanHospitals_NHP18,
NumUrbanBeds_NHP18 from hospitalbedsindia) as temp2 where temp1.StateUnionTerritory
=temp2.state) as temp3 order by 2;
/*14*/
select State, sum(TotalSamples) as TotalSamp, sum(Negative) as TotalNeg, 
sum(Positive) as TotalPos, if(sum(TotalSamples)-sum(Negative)-sum(Positive)<0,
(CONCAT(sum(TotalSamples)-sum(Negative)-sum(Positive)*-1,'  ','Extra Data')),
(CONCAT(sum(TotalSamples)-sum(Negative)-sum(Positive),'  ','Missing Data'))) as 
MisingRecStatus from statewisetestingdetails group by State order by 2 desc;
/*15*/
select str_to_date(Date,'%d-%m-%Y') as Date,sum(TotalSamples) as TotalSamp, sum(Negative) as TotalNeg, 
sum(Positive) as TotalPos, if(sum(TotalSamples)-sum(Negative)-sum(Positive)<0,
(CONCAT(sum(TotalSamples)-sum(Negative)-sum(Positive)*-1,'  ','Extra Data')),
(CONCAT(sum(TotalSamples)-sum(Negative)-sum(Positive),'  ','Missing Data'))) as 
MisingRecStatus from statewisetestingdetails group by str_to_date(Date,'%d-%m-%Y') 
order by 2 desc;