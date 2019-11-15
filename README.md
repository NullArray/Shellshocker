# Shellshocker
A bash script that tests a list of hosts for the shellshock vulnerability. It does so by sending the payload:

```
'() { :; };echo;/bin/cat /etc/passwd
```
Via curl to each URL in the list respectively, per line, in sequence.

To use this script download or clone it then make `shellshocker.sh` executable like so `chmod +x shellshocker.sh`.
After starting it from your terminal, select the 'List' option to specify a path to a list of URLs to be tested, in example; 
```
'Path to list: /tmp/list.txt', 
```
After doing so you can select the 'Output' option to specify a location to which a copy of the script's output will be saved. 
This option is not mandatory and output will be printed to the STDOUT regardless of whether it is set or not.

After a list of URLs has been loaded you can test them for the shellshock vulnerability by selecting the 'Test' option. 
If any given host is vulnerable the contents of their /etc/passwd will be retrieved and printed to the terminal.

Upon completion the script will exit.

### Known issue

From time to time when testing a list of URLs, HTML documents are retrieved as well together with the results from the command injection. Fortunately it doesn't happen often but i thought i'd mention it here regardless.

If you have any questions regarding this script please feel free to open a ticket. 
Thank you.
