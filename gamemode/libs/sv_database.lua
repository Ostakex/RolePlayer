require( "mysqloo" )

local hostname = GM.dbHost
local username = GM.dbUser
local password = GM.dbPassword
local database = GM.dbDatabase
local port = GM.dbPort

local db = mysqloo.connect( hostname, username, password, database, port)

function db:onConnected()
	print( "Database has connected!" )
end
 
function db:onConnectionFailed( err ) 
    print( "Connection to database failed!" )
    print( "Error:", err )
end
 
db:connect()

function checkqueryCheck(query)
    local playerInfo = query:getData()
    if playerInfo[1] ~= nil then
	return true
    else
	return false
    end
end

function getPlayerStats( ply )
    local queryStats = db:query("SELECT model, first, last, money FROM players WHERE steamID = '" .. ply:SteamID() .. "'")
    function queryStats:onSuccess(data)
        ply:SetModel(data[1].model)
    end
    queryStats.onError = function(q,e) print("something went wrong when checking" .. e) end
    queryStats:start()
end


function FirstJoinMysql( ply )

    local queryCheck = db:query("SELECT * FROM players WHERE steamID = '" .. ply:SteamID() .. "'")
    queryCheck.onSuccess = function(q)
        if not checkqueryCheck(q) then
            umsg.Start("rp_newchar", ply);
            umsg.End();
        else
            print(ply:SteamID().." already exsists")
            getPlayerStats( ply )
        end
    end
    queryCheck.onError = function(q,e) print("something went wrong when checking" .. e) end
    queryCheck:start()
end
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawn", FirstJoinMysql )

function registerNewPlayer(ply, command, args)
    local playerModel = args[1]
    local firstName = args[2]
    local lastName = args[3]
    local money = 25000
    local register = db:query("INSERT INTO players(steamID, model, nick, first, last, money) VALUES ('".. ply:SteamID() .."','".. playerModel .."','" .. ply:Nick() .."','"..firstName.."','"..lastName.."',"..money..")")      // else create the bugger
    register.onSuccess = function(q)  print(ply:SteamID().." first time joining created in database") end
    register.onError = function(q,e) print("something went wrong" .. e) end
    register:start()
    getPlayerStats( ply )
end
concommand.Add("rp_register", registerNewPlayer)