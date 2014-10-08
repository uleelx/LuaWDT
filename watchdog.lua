local dogs

local function Timer(handler, interval)
  assert(type(handler) == "function")
  interval = interval or 1
  local o = {}
  o.start = function()
    o.enabled = true
    while o.enabled do
      handler()
      ps.sleep(interval)
    end
  end
  o.stop = function()
    o.enabled = false
  end
  return o
end

local function check(dog)
  dog.counter = dog.counter - 1
  if fs.stat(dog.name).atime ~= dog.atime then
    dog.counter = dog.lifetime
    dog.atime = fs.stat(dog.name).atime
  end
  if dog.counter < 0 then
    for _, cmd in ipairs(dog.action) do
      os.execute(cmd)
    end
    dog.counter = dog.lifetime
  end
end

local function idle()
  for _, dog in ipairs(dogs) do
    check(dog)
  end
end

local function main()
  dogs = {}
  for f in fs.walk() do
    if string.match(fs.basename(f), "^dog.*") then
      local dog = {name = f, atime = fs.stat(f).atime}
      loadfile(f, "t", dog)()
      dog.counter = dog.lifetime
      dogs[#dogs + 1] = dog
      print(f.." loaded")
    end
  end
  local timer1 = Timer(idle)
  timer1.start()
end

main()
