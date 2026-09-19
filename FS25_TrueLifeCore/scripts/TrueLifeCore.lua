TrueLifeCore = TrueLifeCore or {API_VERSION = 1, modules = {}, capabilities = {}, listeners = {}}

function TrueLifeCore.registerModule(id, version, capabilities)
    TrueLifeCore.modules[id] = {version = version, capabilities = capabilities or {}}
    for _, capability in ipairs(capabilities or {}) do TrueLifeCore.capabilities[capability] = id end
end
function TrueLifeCore.hasCapability(capability) return TrueLifeCore.capabilities[capability] ~= nil end
function TrueLifeCore.subscribe(eventName, callback)
    TrueLifeCore.listeners[eventName] = TrueLifeCore.listeners[eventName] or {}
    table.insert(TrueLifeCore.listeners[eventName], callback)
end
function TrueLifeCore.emit(eventName, payload)
    for _, callback in ipairs(TrueLifeCore.listeners[eventName] or {}) do callback(payload) end
end
TrueLifeCore.registerModule("core", "0.1.0", {"moduleRegistry", "eventBus", "capabilityRegistry"})
print("[TrueLifeCore] Loaded")
