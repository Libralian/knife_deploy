#include <amxmodx>
#include <fakemeta>
#include <hamsandwich>
#include <cstrike>


new bool:Knife[33];

public plugin_init()
{
	register_plugin("KnifeDeploy", "1.0", "Lovsky")
	RegisterHam(Ham_Spawn, "player", "Ham_PlayerSpawn_Post", 1)
	register_clcmd("say /knifedp", "Knife_deploy")
	register_clcmd("knifedp", "Knife_deploy")
}
public client_putinserver(id)
{
	Knife[id] = false
}
public client_disconnected(id)
{
	Knife[id] = false
}

public Knife_deploy(id)
{
  Knife[id] = !Knife[id];
}

public Ham_PlayerSpawn_Post(id)
{
	GiveItem(id);
}

public GiveItem(id)
{
    if(!is_user_alive(id)) return;
        if(Knife[id])
	{		
		fm_strip_user_weapons(id)
	}
	else
	{
      		fm_strip_user_weapons(id)
     	 	fm_give_item(id, "weapon_knife")
	}
	return PLUGIN_HANDLED;
}

stock fm_give_item(index, const item[])
{
	if (!equal(item, "weapon_", 7) && !equal(item, "ammo_", 5) && !equal(item, "item_", 5) && !equal(item, "tf_weapon_", 10))
		return 0
	new ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, item))
	if (!pev_valid(ent))
		return 0
	new Float:origin[3];
	pev(index, pev_origin, origin)
	set_pev(ent, pev_origin, origin)
	set_pev(ent, pev_spawnflags, pev(ent, pev_spawnflags) | SF_NORESPAWN)
	dllfunc(DLLFunc_Spawn, ent)
	new save = pev(ent, pev_solid)
	dllfunc(DLLFunc_Touch, ent, index)
	if (pev(ent, pev_solid) != save)
		return ent
	engfunc(EngFunc_RemoveEntity, ent)
	return -1
}
stock fm_strip_user_weapons(id)
{
        static ent
        ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "player_weaponstrip"))
        if (!pev_valid(ent)) return;
       
        dllfunc(DLLFunc_Spawn, ent)
        dllfunc(DLLFunc_Use, ent, id)
        engfunc(EngFunc_RemoveEntity, ent)
}
