function [DV, X, Y] = porkchop_exact(orb_1, orb_2, JD0, DT, body)
%PORKCHOP Calculated the DV required to perform a transfer in the given
%time range

DV = zeros(length(JD0), length(DT));

for i=1:length(JD0)
    orb_1_p = propagate_elements(orb_1, JD0(i), body);
    
    for j=1:length(DT)
        JD2 = JD0(i) + DT(j)/86400;
        [valid, ~, ~, DVT, ~] = transfer(orb_1_p, orb_2, JD0(1), JD2, body);
%         if valid
            DV(i,j) = DVT;
%         else
%             DV(i,j) = inf;
%         end
    end
end

X = repmat(JD0', 1, length(DT));
Y = repmat(DT, length(JD0), 1);
end

