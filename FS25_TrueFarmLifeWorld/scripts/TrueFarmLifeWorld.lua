-- Companion module for the systems that do not belong to one vehicle.
-- It deliberately depends on the mechanical mod's central coordinator.

TrueFarmLifeWorld = {}
TrueFarmLifeWorld.MOD_NAME = g_currentModName
TrueFarmLifeWorld.soilMoisture = 0.25
TrueFarmLifeWorld.rainAccumulated = 0
TrueFarmLifeWorld.updateTimer = 0
TrueFarmLifeWorld.zones = {}

function TrueFarmLifeWorld.getSoilWetness()
    return TrueFarmLifeWorld.soilMoisture or 0
end

function TrueFarmLifeWorld.getZoneKey(vehicle)
    if vehicle == nil or vehicle.rootNode == nil then return nil end
    local x, _, z = getWorldTranslation(vehicle.rootNode)
    return math.floor(x / 64) .. ":" .. math.floor(z / 64)
end

function TrueFarmLifeWorld.getSoilConditionAtVehicle(vehicle)
    local key = TrueFarmLifeWorld.getZoneKey(vehicle)
    if key == nil then return TrueFarmLifeWorld.soilMoisture, 0 end
    local zone = TrueFarmLifeWorld.zones[key]
    if zone == nil then
        zone = {moisture = TrueFarmLifeWorld.soilMoisture, compaction = 0}
        TrueFarmLifeWorld.zones[key] = zone
    end
    return zone.moisture, zone.compaction
end

function TrueFarmLifeWorld.recordFieldPass(vehicle, workload)
    local key = TrueFarmLifeWorld.getZoneKey(vehicle)
    if key == nil then return end
    local zone = TrueFarmLifeWorld.zones[key] or {moisture = TrueFarmLifeWorld.soilMoisture, compaction = 0}
    zone.moisture = math.max(zone.moisture, TrueFarmLifeWorld.soilMoisture)
    zone.compaction = math.min(1, zone.compaction + 0.0008 * (workload or 1) * (0.5 + zone.moisture))
    TrueFarmLifeWorld.zones[key] = zone
end

function TrueFarmLifeWorld:onUpdateTick(dt)
    self.updateTimer = self.updateTimer + dt
    if self.updateTimer < 1000 then return end
    local elapsedHours = self.updateTimer / 3600000
    self.updateTimer = 0
    local weather = g_currentMission ~= nil and g_currentMission.environment ~= nil and g_currentMission.environment.weather or nil
    local rain = weather ~= nil and weather:getRainFallScale() or 0
    if rain > 0 then
        self.rainAccumulated = self.rainAccumulated + rain * elapsedHours
        self.soilMoisture = math.min(1, self.soilMoisture + rain * elapsedHours * 0.60)
    else
        -- Drainage and evaporation are deliberately gradual: a wet field does not
        -- become dry the instant that rain stops.
        self.soilMoisture = math.max(0, self.soilMoisture - elapsedHours * 0.045)
    end
    for _, zone in pairs(self.zones) do
        zone.moisture = zone.moisture + (self.soilMoisture - zone.moisture) * 0.04
        zone.compaction = math.max(0, zone.compaction - elapsedHours * 0.0015)
    end
end

function TrueFarmLifeWorld:onStartMission()
    if TrueFarmLife == nil or TrueFarmLife.core == nil then
        if g_currentMission ~= nil and g_currentMission.showBlinkingWarning ~= nil then
            g_currentMission:showBlinkingWarning(g_i18n:getText("tflw_missingCore"), 5000)
        end
        return
    end

    -- Public bridge: later modules (soil, weather, crops, warehouse and economy)
    -- report their causal events through this one coordinator.
    TrueFarmLifeWorld.core = TrueFarmLife.core
    TrueFarmLifeWorld.core:record("world", "World & Farm Systems connected")
    if g_currentMission ~= nil and g_currentMission.showBlinkingWarning ~= nil then
        g_currentMission:showBlinkingWarning(g_i18n:getText("tflw_started"), 2500)
    end
end

addModEventListener(TrueFarmLifeWorld)
