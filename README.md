# rAirBag
Système de Airbag véhicules pour fivem

Utilisez la commande "/airbag" pour activer l'airbag
__**Vous pourrez trouvez dans le cl_airbag.lua ceci :**__ 
local damageLevel = 960.0
*Mettez damageLevel à 100,0 pour activer les airbags lorsque le véhicule n'est plus conduisible*
*Je vous recommande vivement de maintenir ce niveau entre 700 et 999,0*
*Les véhicules commencent avec un niveau de dommages de 1000,0 - puis diminuent progressivement*

local secondsToExpire = 50
*C'est le nombre de secondes avant que les airbags disparaissent automatiquement - celui de la commande /airbag ne disparaît pas*
*Si vous réglez ceci à -1, tous les airbags resteront pour toujours, même lorsque le véhicule est supprimé (donc je recommande de les faire expirer)*

requis : 

__***ESX/STANDALONE***__: You don't need ESX but this library support it

__***Previews***__: 
- <img src="https://cdn.discordapp.com/attachments/1099805357120962631/1211425197929005116/zJpyVyX.png?ex=65ee26a2&is=65dbb1a2&hm=66c1e1cea40ad664bbb02e8a8d5315ebd1a86621e4fdc4b5c4e29f9d93018ccb&" alt="AirBag">