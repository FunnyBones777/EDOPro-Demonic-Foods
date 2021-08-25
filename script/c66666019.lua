-- Desiring Fusion
local s,id=GetID()
function s.initial_effect(c)
    local e1=Fusion.CreateSummonEff(c,aux.FilterBoolFunction(Card.IsSetCard,0x18c),nil,nil)
    c:RegisterEffect(e1)
    if not AshBlossomTable then AshBlossomTable={} end
    table.insert(AshBlossomTable,e1)
end
s.listed_series={0x18c}