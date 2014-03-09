require( "mysqloo" )

local hostname = GM.dbHost
local username = GM.dbUser
local password = GM.dbPassword
local database = GM.dbDatabase
local port = GM.dbPort

local first = GM.defaultFirst
local last = GM.defaultLast
local money = GM.defaultStartMoney

local db = mysqloo.connect( hostname, username, password, database, port)

function db:onConnected()
	print( "Database has connected!" )
end
 
function db:onConnectionFailed( err ) 
    print( "Connection to database failed!" )
    print( "Error:", err )
end
 
db:connect()

function checkQuery(query)
    local playerInfo = query:getData()
    if playerInfo[1] ~= nil then
	return true
    else
	return false
    end
end

function FirstJoinMysql( ply )

    local query1 = db:query("SELECT * FROM players WHERE steamID = '" .. ply:SteamID() .. "'")
    query1.onSuccess = function(q)
        if not checkQuery(q) then
        umsg.Start("rp_newchar", ply);
        umsg.End();
        end
        /*    
	    local query2 = db:query("INSERT INTO players(steamID, nick, first, last, money) VALUES ('".. ply:SteamID() .."','".. ply:Nick() .."','"..first.."','"..last.."',"..money..")")		// else create the bugger
	    query2.onSuccess = function(q)  print(ply:SteamID().." first time joining created in database") end
	    query2.onError = function(q,e) print("something went wrong" .. e) end
	    query2:start()	
        else
            print(ply:SteamID().." already exsists")
        end
        */
    end
    query1.onError = function(q,e) print("something went wrong when checking") end
    query1:start()
end
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawn", FirstJoinMysql )

