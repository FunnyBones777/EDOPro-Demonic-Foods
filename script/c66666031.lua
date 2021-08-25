-- Supreme Demon Chef Bach
local s, id = GetID()
function s.initial_effect(c)
  --pendulum summon
  Pendulum.AddProcedure(c)
  --Rusty Old Shield
  local e1=Effect.CreateEffect(c)
  	e1:SetType(EFFECT_TYPE_FIELD)
  	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
  	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
  	e1:SetRange(LOCATION_PZONE)
  	e1:SetTargetRange(LOCATION_MZONE,0)
  	e1:SetTarget(s.shifilter)
  	e1:SetValue(1)
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
s.listed_series={0x18a, 0x18b, 0x18c, 0x18d}
--Rusty Old Shield
function s.shifilter(e,c)
  return c:IsSetCard(0x18a) and c:IsSetCard(0x18b) and c:IsSetCard(0x18c) and c:IsSetCard(0x18d)
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