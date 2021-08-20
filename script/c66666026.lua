-- Demonic Milkshake Kasib Colada
local s, id = GetID()
function s.initial_effect(c)
  --pendulum summon
  Pendulum.AddProcedure(c)
  --Add from the deck to the hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
  e1:SetCountLimit(1,id)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(s.thcon)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
  --race
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD)
  e2:SetRange(LOCATION_MZONE)
  e2:SetTargetRange(LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE)
  e2:SetCode(EFFECT_CHANGE_RACE)
  e2:SetValue(RACE_ZOMBIE)
  e2:SetTarget(s.tg)
  c:RegisterEffect(e2)
  --damage
  local e3=Effect.CreateEffect(c)
  e3:SetDescription(aux.Stringid(id,0))
  e3:SetCategory(CATEGORY_DAMAGE)
  e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
  e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
  e3:SetRange(LOCATION_MZONE)
  e3:SetCountLimit(1)
  e3:SetCode(EVENT_SPSUMMON_SUCCESS)
  e3:SetCondition(s.damcon)
  e3:SetTarget(s.damtg)
  e3:SetOperation(s.damop)
  c:RegisterEffect(e3)
end
s.listed_series={0x18a}
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function s.filter(c)
	return c:IsSetCard(0x18a) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDestructable()
		and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil) and Duel.GetFlagEffect(tp,id+1)==0 end
	Duel.RegisterFlagEffect(tp,id+1,RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.Destroy(c,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
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
  Duel.SetTargetParam(1000)
  Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
  if not e:GetHandler():IsRelateToEffect(e) then return end
  local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
  Duel.Damage(p,d,REASON_EFFECT)
end