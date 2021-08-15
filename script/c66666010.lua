-- Evil Fruit Payapa
local s, id = GetID()
function s.initial_effect(c)
  --flip
  local e1=Effect.CreateEffect(c)
  e1:SetDescription(aux.Stringid(id,0))
  e1:SetCategory(CATEGORY_DESTROY)
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
  e1:SetTarget(s.target)
  e1:SetOperation(s.operation)
  c:RegisterEffect(e1)
end
function s.filter(c)
    return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_PSYCHIC)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsLocation(LOCATION_MZONE) end
  if chk==0 then return true end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
  local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_MZONE,0,1,1,nil)
  Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc and tc:IsRelateToEffect(e) then
    Duel.Destroy(tc,REASON_EFFECT)
  end
end