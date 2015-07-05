S = shaperead('POA06aAUST_region.shp');

%load lga-2009-2013.mat;
load('starts_codes.mat');

%S(2000).POA_2006
years = years(34:50,1);
raw_starts = raw_starts(:,34:50);
percent_starts = 100*percent_starts(:,34:50);


color_year = zeros(length(S),length(years));
for i = 1:length(S)
    if sum(str2double(S(i).POA_2006)== newdiffcodes)>0
    ind = find(str2double(S(i).POA_2006)== newdiffcodes);
    color_year(i,:) = percent_starts(ind,:);
    end
end



dbfspec = makedbfspec(S);

dbfspec.color = [];

attr_struct = struct('FieldName', {}, 'FieldType', {}, 'FieldLength', {}, 'FieldDecimalCount', {});

attr_struct(1).FieldName = 'color'
attr_struct(1).FieldType = 'int'
attr_struct(1).FieldLength = 8
attr_struct(1).FieldDecimalCount = 0
dbfspec.color = attr_struct
for j = 2:4
    j
for i = 1 : length(S)
    S(i).color = color_year(i,j);
end

dbf_color = makedbfspec(S)
shapewrite(S,['poa_' num2str(years(j))],'DbfSpec',dbf_color)

%s_color = shaperead('poa_1999.shp')
%mapshow(s_color)
end
