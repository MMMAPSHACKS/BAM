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



% for i = 1:length(S)
%     for j = 1:length(YearLabels)
%         if((YearLabels(j) == 2013) && strcmp(upper(LGA2013Labels(j)),S(i).ABBNAME))
%             color_2013(i) = All(j);
%         end
%     end
% end

pause
pause

%
% dbfspec = makedbfspec(S);
%
% dbfspec.color = [];
%
% attr_struct = struct('FieldName', {}, 'FieldType', {}, 'FieldLength', {}, 'FieldDecimalCount', {});
%
% attr_struct(1).FieldName = 'Color'
% attr_struct(1).FieldType = 'int'
% attr_struct(1).FieldLength = 8
% attr_struct(1).FieldDecimalCount = 0
% dbfspec.color = attr_struct
%
% for i = 1 : length(S)
%     S(i).color = i
% end
%
% dbf_color = makedbfspec(S)
% shapewrite(S,'color_lga','DbfSpec',dbf_color)
%
% s_color = shaperead('color_lga.shp')
% mapshow(s_color)
%
%
