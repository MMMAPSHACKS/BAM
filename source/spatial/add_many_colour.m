S = shaperead('color_lga.shp');

dbfspec = makedbfspec(S);

dbfspec.color = [];

attr_struct = struct('FieldName', {}, 'FieldType', {}, 'FieldLength', {}, 'FieldDecimalCount', {});

attr_struct(1).FieldName = 'Color'
attr_struct(1).FieldType = 'int'
attr_struct(1).FieldLength = 8
attr_struct(1).FieldDecimalCount = 0
dbfspec.color = attr_struct

for i = 1 : length(S)
    S(i).color = i
end

dbf_color = makedbfspec(S)
shapewrite(S,'many_color_lga','DbfSpec',dbf_color)

s_color = shaperead('color_lga.shp')
mapshow(s_color)


