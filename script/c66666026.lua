-- Demonic Milkshake Kasib Colada
local s, id = GetID()
function s.initial_effect(c)
  --synchro summon
  c:EnableReviveLimit()
  Synchro.AddMajesticProcedure(c,aux.FilterBoolFunction(Card.IsCode,66666023),true,aux.FilterBoolFunction(Card.IsCode,66666013),true,Synchro.NonTunerEx(Card.IsRace,RACE_ZOMBIE),1,99)
  --race
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_FIELD)
  e1:SetRange(LOCATION_MZONE)
  e1:SetTargetRange(LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE)
  e1:SetCode(EFFECT_CHANGE_RACE)
  e1:SetValue(RACE_ZOMBIE)
  e1:SetTarget(s.tg)
  c:RegisterEffect(e1)
  --damage
  local e2=Effect.CreateEffect(c)
  e2:SetDescription(aux.Stringid(id,0))
  e2:SetCategory(CATEGORY_DAMAGE)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
  e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
  e2:SetRange(LOCATION_MZONE)
  e2:SetCountLimit(1)
  e2:SetCode(EVENT_SPSUMMON_SUCCESS)
  e2:SetCondition(s.damcon)
  e2:SetTarget(s.damtg)
  e2:SetOperation(s.damop)
  c:RegisterEffect(e2)
end
s.material={66666023,66666013}
s.listed_names={66666023,66666013}
function s.tg(e,c)
  if c:GetFlagEffect(1)==0 then
    c:RegisterFlagEffect(1,0,0,0)
    local eff
    if c:IsLocation(LOCATION_MZONE) then
      eff={Duel.GetPlayerEffect(c:GetControler(),EFFECT_NECRO_VALLEY)}
    else
      eff={c:GetCardEffect(EFFECT_NECRO_VALLEY)}
    end
    c:ResetFlagEffect(1)
    for _,te in ipairs(eff) do
      local op=te:GetOperation()
      if not op or op(e,c) then return false end
    end
  end
  return true
end
function s.filter(c,tp)
  return c:IsFaceup() and c:IsControler(tp)
end
function s.damcon(e,tp,eg,ep,ev,re,r,rp)
  return eg:IsExists(s.filter,1,nil,tp)
end
function s.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetTargetPlayer(1-tp)
  Duel.SetTargetParam(800)
  Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
  if not e:GetHandler():IsRelateToEffect(e) then return end
  local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
  Duel.Damage(p,d,REASON_EFFECT)
end