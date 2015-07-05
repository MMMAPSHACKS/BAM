clear

S = shaperead('color_lga.shp');

load lga-2009-2013_new.mat;


color_all_2009 = zeros(1,length(S));
color_entries_2009 = zeros(1,length(S));
color_exits_2009 = zeros(1,length(S));
for i = 1:length(S)
    for j = 1:length(YearLabels)
        if((YearLabels(j) == 2009) && strcmp(upper(LGA2013Labels(j)),S(i).ABBNAME))
            color_all_2009(i) = Total(j);
            color_entries_2009(i) = 100*Entries(j)/Total(j);
            color_exits_2009(i) =  100*Exists(j)/Total(j);
        end
    end
end


color_all_2010 = zeros(1,length(S));
color_entries_2010 = zeros(1,length(S));
color_exits_2010 = zeros(1,length(S));
for i = 1:length(S)
    for j = 1:length(YearLabels)
        if((YearLabels(j) == 2010) && strcmp(upper(LGA2013Labels(j)),S(i).ABBNAME))
            color_all_2010(i) = Total(j);
            color_entries_2010(i) = 100*Entries(j)/Total(j);
            color_exits_2010(i) =  100*Exists(j)/Total(j);
        end
    end
end


color_all_2011 = zeros(1,length(S));
color_entries_2011 = zeros(1,length(S));
color_exits_2011 = zeros(1,length(S));
for i = 1:length(S)
    for j = 1:length(YearLabels)
        if((YearLabels(j) == 2011) && strcmp(upper(LGA2013Labels(j)),S(i).ABBNAME))
            color_all_2011(i) = Total(j);
            color_entries_2011(i) = 100*Entries(j)/Total(j);
            color_exits_2011(i) =  100*Exists(j)/Total(j);
        end
    end
end


color_all_2012 = zeros(1,length(S));
color_entries_2012 = zeros(1,length(S));
color_exits_2012 = zeros(1,length(S));
for i = 1:length(S)
    for j = 1:length(YearLabels)
        if((YearLabels(j) == 2012) && strcmp(upper(LGA2013Labels(j)),S(i).ABBNAME))
            color_all_2012(i) = Total(j);
            color_entries_2012(i) = 100*Entries(j)/Total(j);
            color_exits_2012(i) =  100*Exists(j)/Total(j);
        end
    end
end

color_all_2013 = zeros(1,length(S));
color_entries_2013 = zeros(1,length(S));
color_exits_2013 = zeros(1,length(S));
for i = 1:length(S)
    for j = 1:length(YearLabels)
        if((YearLabels(j) == 2013) && strcmp(upper(LGA2013Labels(j)),S(i).ABBNAME))
            color_all_2013(i) = Total(j);
            color_entries_2013(i) = 100*Entries(j)/Total(j);
            color_exits_2013(i) =  100*Exists(j)/Total(j);
        end
    end
end

color_exits_2009 = 100*color_exits_2009/sum(color_exits_2009);
color_exits_2010 = 100*color_exits_2010/sum(color_exits_2010);
color_exits_2011 = 100*color_exits_2011/sum(color_exits_2011);
color_exits_2012 = 100*color_exits_2012/sum(color_exits_2012);
color_exits_2013 = 100*color_exits_2013/sum(color_exits_2013);

color_entries_2009 = 100*color_entries_2009/sum(color_entries_2009);
color_entries_2010 = 100*color_entries_2010/sum(color_entries_2010);
color_entries_2011 = 100*color_entries_2011/sum(color_entries_2011);
color_entries_2012 = 100*color_entries_2012/sum(color_entries_2012);
color_entries_2013 = 100*color_entries_2013/sum(color_entries_2013);

color_all_2009 = 100*color_all_2009/sum(color_all_2009);
color_all_2010 = 100*color_all_2010/sum(color_all_2010);
color_all_2011 = 100*color_all_2011/sum(color_all_2011);
color_all_2012 = 100*color_all_2012/sum(color_all_2012);
color_all_2013 = 100*color_all_2013/sum(color_all_2013);

dbfspec = makedbfspec(S);

dbfspec.color_1999 = [];
dbfspec.color_2000 = [];
dbfspec.color_2001 = [];
dbfspec.color_2002 = [];
dbfspec.color_2003 = [];
dbfspec.color_2004 = [];
dbfspec.color_2005 = [];
dbfspec.color_2006 = [];
dbfspec.color_2007 = [];
dbfspec.color_2008 = [];
dbfspec.color_2009 = [];
dbfspec.color_2010 = [];
dbfspec.color_2011 = [];
dbfspec.color_2012 = [];
dbfspec.color_2013 = [];
dbfspec.color_2014 = [];
dbfspec.color_2015 = [];

% attr_struct = struct('FieldName', {}, 'FieldType', {}, 'FieldLength', {}, 'FieldDecimalCount', {});
% 
% attr_struct(1).FieldName = 'color_2013'
% attr_struct(1).FieldType = 'int'
% attr_struct(1).FieldLength = 8
% attr_struct(1).FieldDecimalCount = 0
% dbfspec.color = attr_struct
% 
% for i = 1 : length(S)
%     S(i).color_2013 = color_all_2013(i)
% end
% 
% dbf_color = makedbfspec(S)
% shapewrite(S,'color_2013','DbfSpec',dbf_color)
% 
% s_color = shaperead('color_2013.shp')
% mapshow(s_color)


attr_struct = struct('FieldName', {}, 'FieldType', {}, 'FieldLength', {}, 'FieldDecimalCount', {});

attr_struct(1).FieldName = 'color_2009'
attr_struct(1).FieldType = 'int'
attr_struct(1).FieldLength = 8
attr_struct(1).FieldDecimalCount = 0
dbfspec.color = attr_struct

for i = 1 : length(S)
    S(i).color_2009 = color_entries_2009(i);
end

dbf_color = makedbfspec(S)
shapewrite(S,'color_entries_2009','DbfSpec',dbf_color)

%s_color = shaperead('color_2009.shp')
%mapshow(s_color)





