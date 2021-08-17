-- Dark Ingredient Moomoo Milk
local s, id = GetID()
function s.initial_effect(c)
  --pendulum summon
  Pendulum.AddProcedure(c)
  --activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  c:RegisterEffect(e1)
  --heal
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
  e2:SetCode(EVENT_SUMMON_SUCCESS)
  e2:SetProperty(EFFECT_FLAG_DELAY)
  e2:SetRange(LOCATION_PZONE)
  e2:SetCondition(s.hcondition)
  e2:SetOperation(s.hoperation)
  c:RegisterEffect(e2)
  local e3=e2:Clone()
  e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
  e3:SetCondition(s.hcondition2)
  c:RegisterEffect(e3)
  local e4=e2:Clone()
  e4:SetCode(EVENT_SPSUMMON_SUCCESS)
  c:RegisterEffect(e4)
end
function s.hcondition(e,tp,eg,ep,ev,re,r,rp)
  return eg and eg:IsExists(Card.IsSummonPlayer,1,nil,1-tp)
end
function s.hcondition2(e,tp,eg,ep,ev,re,r,rp)
  return eg and eg:IsExists(Card.IsControler,1,nil,1-tp)
end
function s.hoperation(e,tp)
  Duel.Hint(HINT_CARD,0,id)
  Duel.Recover(tp,100,REASON_EFFECT)
end