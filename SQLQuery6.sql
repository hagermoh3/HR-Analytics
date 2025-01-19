-----create join:

select * FROM [HRwork].[dbo].[Absenteeism_at_work$] a
left join [HRwork].[dbo].[compensation] b 
on a.ID=b.ID
left join [HRwork].[dbo].[Reasons] r
on a.[Reason for absence]=r.Number;

-----finding healthiest:

select * FROM [HRwork].[dbo].[Absenteeism_at_work$]
where [Social drinker]=0 and [Social smoker]=0
and [Body mass index] < 25 and
[Absenteeism time in hours] < (select AVG([Absenteeism time in hours]) FROM [HRwork].[dbo].[Absenteeism_at_work$]);

------compensation rate increase for non-smokers / budget $983221 so 0.68 increase per hour/ $1,414.4 increase per year

select count(*) as nonsmokers FROM [HRwork].[dbo].[Absenteeism_at_work$]
where [Social smoker]=0

-------optimize query

select 
a.ID,r.Reason,
[Month of absence],
[Body mass index],
case when [Body mass index] < 18.5 then 'UnderWeight'
	 when [Body mass index] between 18.5 and 25 then 'Healthy'
	 when [Body mass index] between 25 and 30 then 'OverWeight'
	 when [Body mass index] > 18.5 then 'Obese'
	 else 'Unknown' end as BMI_Category
,case when [Month of absence] in (12,1,2) then 'Winter'
	 when [Month of absence] in (3,4,5) then 'Spring'
	 when [Month of absence] in (6,7,8) then 'Summer'
	 when [Month of absence] in (9,10,11) then 'Fall'
	 else 'UnKnown' end as Seasons_Names
     ,[Day of the week]
      ,[Seasons]
      ,[Transportation expense]
      ,[Distance from Residence to Work]
      ,[Service time]
      ,[Age]
      ,[Work load Average/day ]
      ,[Hit target]
      ,[Disciplinary failure]
      ,[Education]
      ,[Son]
      ,[Social drinker]
      ,[Social smoker]
      ,[Pet]
      ,[Weight]
      ,[Height]
      ,[Body mass index]
      ,[Absenteeism time in hours]
FROM [HRwork].[dbo].[Absenteeism_at_work$] a
left join [HRwork].[dbo].[compensation] b 
on a.ID=b.ID
left join [HRwork].[dbo].[Reasons] r
on a.[Reason for absence]=r.Number;

