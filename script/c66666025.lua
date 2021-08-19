-- Dark Ingredient Giant's Fungus
local s, id = GetID()
function s.initial_effect(c)
  --pendulum summon
  Pendulum.AddProcedure(c)
  --Atk up
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD)
  e2:SetRange(LOCATION_PZONE)
  e2:SetTargetRange(LOCATION_MZONE,0)
  e2:SetCode(EFFECT_UPDATE_ATTACK)
  e2:SetCondition(s.con)
  e2:SetValue(1079)
  c:RegisterEffect(e2)
end
function s.con(e)
  local ph=Duel.GetCurrentPhase()
  local tp=Duel.GetTurnPlayer()
  return tp==e:GetHandlerPlayer() and ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end