What is this?
-------------------------------

LuaWDT is a small watchdog timer written in Lua using [BonaLuna](http://cdsoft.fr/bl/bonaluna.html).
  
Usage
----------------------------

1.	Create a "dog" prefix file contains "lifetime" and "action" variable.
	```lua
		lifetime = 5
		action = {
		  'taskkill /f /im notepad.exe 2>nul',
		  'start notepad'
		}
	```

2.	Run "bl.exe watchdog.lua".

3.	If you don't expect the dogs do actions, you can run "touch dog*" periodically in the terminal console to prevent it.

LICENSE
----------------------

LuaWDT is distributed under the MIT license.