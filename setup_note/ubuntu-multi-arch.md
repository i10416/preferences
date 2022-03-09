# setup multi architecture for ubuntu/debian 



```
// check
dpkg --print-architecture
// check foreign architecture
dpkg --print-foreign-architecture
// add i386
dpkg --add-architecture i386
// list i386 packages
sudo dpkg -l | grep i386
// remove i386 packages
apt purge '*:i386'
// remove i386 architecture
dpkg --remove-architecture i386

```

