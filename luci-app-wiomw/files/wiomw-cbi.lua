m = Map("wiomw", translate("Who Is On My WiFi"))
s = m:section(NamedSection, "agent", "wiomw-agent", translate("Basic Settings"))
s:option(Value, "username", translate("Username"))
s:option(Value, "passhash", translate("Password Hash"))
s:option(Value, "agentkey", translate("Agent Key"))
return m
