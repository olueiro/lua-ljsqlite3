package = "turbo-sqlite3"
version = "1.0.2-1"

source = {
 url = "git://github.com/olueiro/turbo-sqlite3.git",
 branch = "master"
}

description = {
 summary = "Pure LuaJIT binding for SQLite3 databases for Turbo.lua",
 detailed = [[
Pure LuaJIT binding for SQLite3 databases for Turbo.lua
]],
 homepage = "http://scilua.org/ljsqlite3.html",
 license = "MIT"
}

dependencies = {
 "turbo"
}

build = {
 type = "builtin",
 modules = {
  ["turbo-sqlite3"] = "turbo-sqlite3.lua"
 },
 copy_directories = {}
}
