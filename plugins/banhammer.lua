local function pre_process(msg)
   if msg.to.type ~= 'pv' then
chat = msg.to.id
user = msg.from.id
 local function check_newmember(arg, data)
  test = load_data(_config.moderation.data)
  lock_bots = test[arg.chat_id]['settings']['lock_bots']
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    if data.type_.ID == "UserTypeBot" then
      if not is_owner(arg.msg) and lock_bots == 'yes' then
kick_user(data.id_, arg.chat_id)
end
end
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if is_banned(data.id_, arg.chat_id) then
   if not lang then
  tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_User_ "..user_name.." *[ "..data.id_.." ]* _is banned_", 0, "md")
   else
  tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_کاربر_ "..user_name.." *[ "..data.id.."]*_banned_", 0, "md")
end
kick_user(data.id_, arg.chat_id)
end
if is_gbanned(data.id_) then
     if not lang then
  tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_User_ "..user_name.." *[ "..data.id_.." ]* _is globally banned_", 0, "md")
    else
  tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_کاربر_ "..user_name.." *[ "..data.id_.." ]* _از تمام گروه های ربات محروم است_", 0, "md")
   end
kick_user(data.id_, arg.chat_id)
     end
 end
 if msg.adduser then
   tdcli_function ({
       ID = "GetUser",
       user_id_ = msg.adduser
     }, check_newmember, {chat_id=chat,msg_id=msg.id,user_id=user,msg=msg})
 end
 if msg.joinuser then
   tdcli_function ({
       ID = "GetUser",
       user_id_ = msg.joinuser
     }, check_newmember, {chat_id=chat,msg_id=msg.id,user_id=user,msg=msg})
    end
 if is_silent_user(msg.from.id, msg.to.id) then
 del_msg(msg.to.id, msg.id)
    return false
 end
 if is_banned(msg.from.id, msg.to.id) then
 del_msg(msg.to.id, tonumber(msg.id))
     kick_user(msg.from.id, msg.to.id)
    return false
    end
 if is_gbanned(msg.from.id) then
 del_msg(msg.to.id, tonumber(msg.id))
     kick_user(msg.from.id, msg.to.id)
    return false
   end
 end
   return msg
end
local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
  local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
if data.sender_user_id_ then
  if cmd == "ban" then
local function ban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't ban_ *mods,owners and bot admins*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*شما نمیتوانید مدیران،صاحبان گروه، و ادمین های ربات رو از گروه محروم کنید*", 0, "md")
         end
     end
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* * از گروه محروم بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *banned*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از گروه محروم شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, ban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
   if cmd == "unban" then
local function unban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *banned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از گروه محروم نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *unbanned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از محرومیت گروه خارج شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "silent" then
local function silent_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't silent_ *mods,owners and bot admins*", 0, "md")
    else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*شما نمیتوانید توانایی چت کردن رو از مدیران،صاحبان گروه، و ادمین های ربات بگیرید*", 0, "md")
       end
     end
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *silent*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل توانایی چت کردن رو نداشت*", 0, "md")
     end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
  if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _added to_ *silent users list*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *توانایی چت کردن رو از دست داد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, silent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "unsilent" then
local function unsilent_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *silent*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل توانایی چت کردن را داشت*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _removed from_ *silent users list*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *توانایی چت کردن رو به دست آورد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unsilent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "banall" then
local function gban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
   if is_admin1(data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't_ *globally ban* _other admins_", 0, "md")
  else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*شما نمیتوانید ادمین های ربات رو از تمامی گروه های ربات محروم کنید*", 0, "md")
        end
     end
if is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *globally banned*", 0, "md")
    else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از گروه های ربات محروم بود*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
     if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *globally banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از تمام گروه های ربات محروم شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, gban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "unbanall" then
local function ungban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
if not is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *globally banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کارب
