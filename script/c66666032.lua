-- Supreme Demon Chef Bob
local s, id = GetID()
function s.initial_effect(c)
  --pendulum summon
  Pendulum.AddProcedure(c)
  --Rusty Old Sword
  	local e1=Effect.CreateEffect(c)
  	e1:SetDescription(aux.Stringid(id,0))
  	e1:SetCategory(CATEGORY_DESTROY)
  	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  	e1:SetType(EFFECT_TYPE_IGNITION)
  	e1:SetRange(LOCATION_PZONE)
  	e1:SetCountLimit(1)
  	e1:SetCost(s.swocost)
  	e1:SetTarget(s.swotarget)
  	e1:SetOperation(s.swooperation)
  	c:RegisterEffect(e1)
  --change race
  local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(s.racetg)
	e2:SetOperation(s.raceop)
	c:RegisterEffect(e2)
end
s.listed_series={0x18a, 0x18b}
--Rusty Old Sword
function s.swofilter(c)
	return c:IsSetCard(0x18a, 0x18b) and c:IsDiscardable()
end
function s.swocost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.swofilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,s.swofilter,1,1,REASON_COST+REASON_DISCARD)
end
function s.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsLevelAbove(5)
end
function s.swotarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and s.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,s.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function s.swooperation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
--change race
function s.racetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local aat=e:GetHandler():AnnounceAnotherRace(tp)
	e:SetLabel(aat)
end
function s.raceop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end