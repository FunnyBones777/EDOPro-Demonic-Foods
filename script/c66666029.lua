-- Demon Chef Matt
local s, id = GetID()
function s.initial_effect(c)
  --pendulum summon
  Pendulum.AddProcedure(c)
  --scale
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LSCALE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(s.slcon)
	e1:SetValue(5)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CHANGE_RSCALE)
	c:RegisterEffect(e2)
  --change race
  local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(s.racetg)
	e3:SetOperation(s.raceop)
	c:RegisterEffect(e3)
end
s.listed_series={0x18d}
function s.slfilter(c)
	return c:IsSetCard(0x18d)
end
function s.slcon(e)
	return not Duel.IsExistingMatchingCard(s.slfilter,e:GetHandlerPlayer(),LOCATION_PZONE,0,1,e:GetHandler())
end
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