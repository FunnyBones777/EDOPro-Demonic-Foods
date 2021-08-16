-- Dark Ingredient Gigantamix
local s, id = GetID()
function s.initial_effect(c)
  --pendulum summon
  Pendulum.AddProcedure(c)
  --avoid battle damage
  local e3=Effect.CreateEffect(c)
  e3:SetType(EFFECT_TYPE_FIELD)
  e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
  e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
  e3:SetRange(LOCATION_PZONE)
  e3:SetTargetRange(LOCATION_MZONE,0)
  e3:SetTarget(s.efilter)
  e3:SetValue(1)
  c:RegisterEffect(e3)
end
s.listed_series={0x18b}
function s.efilter(e,c)
  return c:IsSetCard(0x18b)
end