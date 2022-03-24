## Io Terminal Game: Clash of the Species
The Io programming language is a tiny, yet powerful object-oriented language referenced in [Seven Languages in Seven Weeks](https://pragprog.com/titles/btlang/seven-languages-in-seven-weeks/).



### Key concepts of Io
- Prototype language -> everything is something else’s object, being derived from an original prototype.
- Minimal syntax makes it simple and consistent.
	
#### Objects in Io
- Every interaction with an object is a message (typically known as function in other languages).
- You don’t instantiate classes; you clone other objects called prototypes.
- Objects remember their prototypes.
- Objects have slots.
- Slots contain objects, including method objects.
- A message returns the value in a slot or invokes the method in a slot.
- If an object can’t respond to a message, it sends that message to its prototype.

#### Sample Code
Use a semi-colon after each item you want accomplished, unless that item is in parentheses, such as an if statement:
```
my_method := method(input, // what you pass in
	"Hello world" println; // item 1
	for (i, 0, input, // item 3 -- 0 is the start & input is the end of the loop.
		mult := i*5;
		mult println) // here we don't need a semi-colon
	return "Thanks for using my method" println // item 4
)
```


### Getting Io Running
Where to download: https://iobin.suspended-chord.info/

Note the ReadMe instructions to drag libgcc_s_dw2-1.dll into the same folder as io.exe after running IoLanguage-2013.11.05-win32.exe

#### Tools for Using the Language
- Editors: Try Sublime text3 and use the Io support: https://packagecontrol.io/packages/Io%20Language. 
- Interpreters: Use the command prompt / shell.
- Tutorials/guides:
	- Main site: https://iolanguage.org/. 
	- Tutorial: https://ozone.wordpress.com/2006/03/15/blame-it-on-io/. 
	- Multi-resource: https://www.symbaloo.com/mix/iolanguage?searched=true. 
