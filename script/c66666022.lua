-- Demonic Burger Extreme Giant
local s, id = GetID()
function s.initial_effect(c)
  --fusion material
  c:EnableReviveLimit()
  Fusion.AddProcMixRep(c,true,true,aux.FilterBoolFunctionEx(s.matfilter),1,1,66666021,66666020)
  --equip
  local e1=Effect.CreateEffect(c)
  e1:SetDescription(aux.Stringid(id,0))
  e1:SetCategory(CATEGORY_EQUIP)
  e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
  e1:SetCode(EVENT_BATTLE_DESTROYING)
  e1:SetCondition(s.eqcon)
  e1:SetTarget(s.eqtg)
  e1:SetOperation(s.eqop)
  c:RegisterEffect(e1)
  aux.AddEREquipLimit(c,nil,aux.FilterBoolFunction(Card.IsType,TYPE_MONSTER),s.equipop,e1)
end
function s.matfilter(c,fc,sumtype,tp)
	return c:IsRace(RACE_ZOMBIE,fc,sumtype,tp) and c:IsLevelBelow(4)
end
function s.eqcon(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local tc=c:GetBattleTarget()
  return c:IsRelateToBattle() and c:IsFaceup() and tc:IsLocation(LOCATION_GRAVE) and tc:IsType(TYPE_MONSTER) and tc:IsReason(REASON_BATTLE)
end
function s.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  local tc=e:GetHandler():GetBattleTarget()
  Duel.SetTargetCard(tc)
  Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,tc,1,0,0)
end
function s.equipop(c,e,tp,tc)
  if not aux.EquipByEffectAndLimitRegister(c,e,tp,tc) then return end
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_EQUIP)
  e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
  e2:SetCode(EFFECT_UPDATE_ATTACK)
  e2:SetReset(RESET_EVENT+RESETS_STANDARD)
  e2:SetValue(1000)
  tc:RegisterEffect(e2)
end
function s.eqop(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  local tc=Duel.GetFirstTarget()
  if c:IsRelateToEffect(e) and c:IsFaceup() and tc and tc:IsRelateToEffect(e) then
    s.equipop(c,e,tp,tc)
  end
end