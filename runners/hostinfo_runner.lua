--[[
Copyright 2015 Rackspace

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS-IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--]]
local HostInfo = require('../hostinfo')
local upper = require('string').upper

local function run(...)
  local argv = require("options")
  .usage('Usage: -a')
  .describe("a", "Get debug info for all hostinfos")
  .usage('Usage: -D')
  .describe("D", "Generate documentation")
  .usage('Usage: -t')
  .describe("t", "Print all implemented hostinfo types")
  .usage('Usage: -x [Host Info Type]')
  .describe("x", "Host info type to run")
  .usage('Usage: -f [File name]')
  .describe("f", "Filename to write to. Can be used with either -x for a single hostinfo or -a for all of them")
  .usage('Usage: -F [Folder name]')
  .describe("F", "Folder name to write to. Can only be used with the -a option")
  .argv("adtx:f:F:")

  local args = argv.args

  local folderName, fileName, typeName
  if args.f then fileName = args.f end
  if args.x then typeName = upper(args.x) end
  if args.F then folderName = args.F end

  if args.a and args.F then
    local function cb() print('Generated debug info for all hostinfo in folder ' .. folderName) end
    return HostInfo.debugInfoAllToFolder(folderName, cb)
  elseif args.x and args.f then
    local function cb() print('Debug info written to file ' .. fileName .. ' for host info type ' .. typeName) end
    return HostInfo.debugInfoToFile(typeName, fileName, cb)
  elseif args.a and args.f then
    local function cb() print('Debug info written to file '.. fileName) end
    return HostInfo.debugInfoAllToFile(fileName, cb)
  elseif args.x and not args.f then
    return HostInfo.debugInfo(typeName, print)
  elseif args.a and not args.f then
    return HostInfo.debugInfoAll(print)
  elseif args.d and args.t then
    table.foreach(HostInfo.getTypes(), function(k, v)
      print(string.format('- [%s](https://github.com/virgo-agent-toolkit/rackspace-monitoring-agent/blob/master/hostinfo/debug/%s)', v, v..'.txt'))
    end)
    return
  elseif args.t and not args.d then
    return print(table.concat(HostInfo.getTypes(), '\n'))
  else
    print(argv._usage)
    return process:exit(0)
  end
end

return { run = run }
