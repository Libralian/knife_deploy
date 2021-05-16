#include <amxmodx>
#include <reapi>

#pragma semicolon 1

new bool:gKnife[MAX_PLAYERS + 1];

public plugin_init()
{
	register_plugin("[ReAPI]KnifeDeploy", "1.0", "Libralian");

	RegisterHookChain(RG_CBasePlayer_Spawn, "CBasePlayer_Spawn", .post = true);

	register_clcmd("say /knife", "knife_deploy");
	register_clcmd("knife_dp", "knife_deploy");
}

public client_putinserver(id)
{
	gKnife[id] = false;

}

public client_disconnected(id)
{
	gKnife[id] = false;
}

public CBasePlayer_Spawn(id)
{
	GiveItem(id);
}

public knife_deploy(id)
{
	gKnife[id] = !gKnife[id];
}

public GiveItem(id)
{
	if (!is_user_alive(id)) return;

	if (gKnife[id])
	{
		rg_remove_all_items(id);
		set_entvar(id, var_maxspeed, 250.0);
	}
	else
	{
		rg_remove_all_items(id);
		rg_give_item(id, "weapon_knife");
		engclient_cmd(id, "weapon_knife");
	}
}
