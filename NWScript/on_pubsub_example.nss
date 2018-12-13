#include "inc_nwncogs"

void main()
{
    struct NWNX_Redis_PubSubMessageData data = NWNX_Redis_GetPubSubMessageData();

    if( data.channel == NWNCOGS_INCOMING_REDIS_CHANNEL && GetStringLength(data.message) > 0 )
    {
        if( data.message == "FULL" )
        {
            struct NWNCogs_DiscordEmbed discordEmbed = NWNCogs_DiscordEmbed_Full(
                                                                        GetName(GetModule()),
                                                                        "https://i.imgur.com/k7AyXCD.png",
                                                                        "'" + data.message + "' Response",
                                                                        RandomName(NAME_FAMILIAR),
                                                                        NWNCogs_RBGToDiscordColor(Random(256), Random(256), Random(256)),
                                                                        "https://i.imgur.com/k7AyXCD.png",
                                                                        "Sent from my iPhone",
                                                                        "https://i.imgur.com/k7AyXCD.png"
            );

            NWNCogs_PublishDiscordResponse_Embed(discordEmbed);
        }
        else
        {
            struct NWNCogs_DiscordEmbed discordEmbed = NWNCogs_DiscordEmbed_Simple(
                                                                        GetName(GetModule()),
                                                                        "'" + data.message + "' Response",
                                                                        RandomName(NAME_FAMILIAR),
                                                                        NWNCogs_RBGToDiscordColor(Random(256), Random(256), Random(256))
            );

            NWNCogs_PublishDiscordResponse_Embed(discordEmbed);
        }
    }
    else
    if( data.channel == NWNCOGS_INCOMING_REDIS_CHANNEL_RESTRICTED && GetStringLength(data.message) > 0 )
    {
        NWNCogs_PublishDiscordResponse_Simple("Received Restricted Command: " + data.message);
    }
}