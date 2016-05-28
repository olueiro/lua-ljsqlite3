SQlite3 Interface for [Turbo.lua](http://www.turbolua.org/)
===========================================================

Forked from [stepelu/lua-ljsqlite3](https://github.com/stepelu/lua-ljsqlite3) by [Stefano Peluchetti](http://scilua.org/index.html).

Pure LuaJIT binding for [SQLite3](http://sqlite.org) databases.

## Installation

- Install `SQLite3`:
```
$ apt-get install sqlite3 libsqlite3-dev
```

- Install `luarocks`:
```
$ wget http://luarocks.org/releases/luarocks-2.3.0.tar.gz
$ tar zxpf luarocks-2.3.0.tar.gz
$ cd luarocks-2.3.0
$ ./configure; sudo make bootstrap
```

- Install `turbo-sqlite3`:
```
$ luarocks install turbo-sqlite3
```

- Done!

## Documentation

Refer to the [official documentation](http://scilua.org/ljsqlite3.html).

## Features

- all SQLite3 types are supported and mapped to LuaJIT types
- efficient implementation via value-binding methods and prepared statements
- ability to extend SQLite3 via scalar and aggregate (Lua) callback functions
- command-line shell feature
- results by row or by whole table

```lua
local sql = require "turbo-sqlite3"

local conn = sql.open("") -- Open a temporary in-memory database.
  
-- Execute SQL commands separated by the ';' character:
conn:exec[[
CREATE TABLE t(id TEXT, num REAL);
INSERT INTO t VALUES('myid1', 200);
]]
  
-- Prepared statements are supported:
local stmt = conn:prepare("INSERT INTO t VALUES(?, ?)")
for i=2,4 do
  stmt:reset():bind('myid'..i, 200*i):step()
end
  
-- Command-line shell feature which here prints all records:
conn "SELECT * FROM t"
--> id    num
--> myid1 200
--> myid2 400
--> myid3 600
--> myid4 800
  
local t = conn:exec("SELECT * FROM t") -- Records are by column.
-- Access to columns via column numbers or names:
assert(t[1] == t.id)
-- Nested indexing corresponds to the record number:
assert(t[1][3] == 'myid3')
  
-- Convenience function returns multiple values for one record:
local id, num = conn:rowexec("SELECT * FROM t WHERE id=='myid3'")
print(id, num) --> myid3 600
 
-- Custom scalar function definition, aggregates supported as well.
conn:setscalar("MYFUN", function(x) return x/100 end)
conn "SELECT MYFUN(num) FROM t"
--> MYFUN(num)
--> 2
--> 4
--> 6
--> 8
 
conn:close() -- Close stmt as well.
```

## Credits

- LJSQLite3 and xsys: Stefano Peluchetti
- templet: Peter Colberg

## License

MIT license

LJSQLite3: SQlite3 Interface.

Copyright (C) 2014-2016 Stefano Peluchetti. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

MIT license: http://opensource.org/licenses/MIT
