function h = hasfield(s,field_str)
h = sum(strcmp(fieldnames(s), field_str)) == 1;
end

