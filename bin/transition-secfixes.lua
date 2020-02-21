-- script to parse the aports tree and generate secfixes yaml files

yaml = require('lyaml')

function read_apkbuild(file)
	local repo,  pkg = file:match("([a-z]+)/([^/]+)/APKBUILD")
	local f = io.open(file)
	if f == nil then
		return
	end
	while true do
		line = f:read("*line")
		if line == nil then
			break
		end
		if line:match("^# secfixes") then
			local y = ""
			while line ~= nil and line:match("^#") do
				local l = line:gsub("^# ", "")
				if l == nil then
					break
				end
				y = y..l.."\n"
				line = f:read("*line")
			end
			f:close()
			f = io.open(repo.."/"..pkg.."/".."secfixes.yaml", "w+")
			io.output(f)
			io.write(y)
			f:close()
			return
		end
	end
	f:close()
end

for i = 1, #arg do
	read_apkbuild(arg[i])
end
