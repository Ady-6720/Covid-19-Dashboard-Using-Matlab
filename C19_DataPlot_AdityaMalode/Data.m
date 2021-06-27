%% Organising Reference Data obtained from (John Hopkins University)
classdef Data
     properties 
        covidData % covid 19 Data from John Hopkins University Reference
        Date % Date
        CountriesName % Countries Name for first list box
        StateOrRegion % States/Regions Name for second list box
        CountriesIndexing % Organising Countries name Indexing containing "Global" as first
        StateOrRegionIndexing % Organising States/Regions name Indexing containing "All" as first
     end
    methods 
        %% 
        function obj=Data(in)
            load covid_data.mat covid_data
            obj.covidData=covid_data;
            obj.CountriesName=covid_data(:,1);
            obj.Date=covid_data(1,3:end);
            obj.CountriesName{1}='Global';
            [~,n]=ismember(obj.CountriesName,in);
            [~,obj.CountriesIndexing]=max(n);
            obj.StateOrRegionIndexing=obj.CountriesIndexing:(obj.CountriesIndexing+sum(n)-1);%%%%%%%%
            obj.StateOrRegion=covid_data(obj.StateOrRegionIndexing,2);
            obj.StateOrRegion{1}='All'; 
        end
        %%
        function obj =DeathsVector(obj,ind)
            Deaths=zeros(1,length(obj.Date));
            for ii=3:length(obj.Date)+2
                Deaths(ii-2)=obj.covidData{ind,ii}(1,2);
            end
            obj=Deaths; 
        end
        function obj=CasesVector(obj,inc)
            Cases=zeros(1,length(obj.Date));%%vec
            for ii=3:length(obj.Date)+2
                Cases(ii-2)=obj.covidData{inc,ii}(1,1);
            end
            obj=Cases;
            
        end
        %%
        function obj =BothGlobalCasesAndDeaths(obj)
            statesorregions=obj.covidData(:,2);
            All=zeros(1,length(statesorregions));
            GlobalCases=zeros(length(statesorregions),length(obj.Date));
            GlobalDeaths=zeros(length(statesorregions), length(obj.Date));
            for i=1:length(statesorregions)
                if isempty(statesorregions{i})
                    All(i)=i;
                end
            end
            for ii=length(statesorregions)      
            if All(ii)==0
                continue;
            else
                for jj=3:length(obj.Date)+2
                    GlobalCases(ii,jj-2)=obj.covidData{ii,jj}(1,1);
                end
                for kk=3:length(obj.Date)+2
                    GlobalDeaths(ii,kk-2)=obj.covidData{ii,kk}(1,2);
                end
                end
                end
            obj=[sum(GlobalCases); sum(GlobalDeaths)];
        end
    end
end