From: David J Ring Jr <n1ea@arrl.net>
Date: Sun, 13 Nov 2011 02:46:09 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <alpine.DEB.2.00.1111130224120.2319@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello Florian,

What I'm trying to do is make a command line distribution with speakup so 
that blind people and people who just like the command line can use it.  I 
still have some sight so occasionally I like to see the pictures that 
links2 -g can display.

I have everything working in this system:  alpine, mutt, elmo for mail, 
emacspeak the complete audio desktop is loaded and running and speaking. 
elinks, links2, w3m, and searchraw are all installed.   All the console 
multimedia stuff is in here, ftp, pdftotext converters, etc.

But the only thing that doesn't work on this is command links2 -g.

So I want this to be card independant - and my previous versions of Debian 
command line Vinux (that's the distro) worked fine.

I have no /etc/modprobe.d/fbdev-blacklist.conf file at all.

I also have no /dev/fb0 file.

Here is my /etc/modprobe.d/blacklist.conf file - it doesn't have any fb 
blacklisted either.

# This file lists modules which will not be loaded as the result of
# alias expansion, with the purpose of preventing the hotplug subsystem
# to load them. It does not affect autoloading of modules by the kernel.
# This file is provided by the udev package.

# evbug is a debug tool and should be loaded explicitly
blacklist evbug

# these drivers are very simple, the HID drivers are usually preferred
blacklist usbmouse
blacklist usbkbd

# replaced by e100
blacklist eepro100

# replaced by tulip
blacklist de4x5

# replaced by tmscsim
blacklist am53c974

# these watchdog drivers break some systems
blacklist iTCO_wdt

Any suggestions?

I have changed grub to give me a large 640x480 screen and that works but 
and it gives me color say if I have bash add color to folders and 
executables - and mc comes up in color but no links2 -g in color because 
no /dev/fb0.

Any other suggestions?

I made my username member of its own group and also tty and video.

As I said before I tried mknod and that worked but when I rebooted
/dev/fb0 was gone.

I tried the mknod command again and it created /dev/fb0
which is owned by root and in root group.  I changed the group to video.

Now root has rwx permissions the group can read and everyone can read.

I run links2 -g and it still says it cannot access /dev/fb0.

If I reboot /dev/fb0 will disappear.

I'm stuck!

David


On Sun, 13 Nov 2011, Florian Tobias Schandinat wrote:

> Hi,
>
> On 11/12/2011 11:42 PM, D.J.J. Ring, Jr. wrote:
>> I want to make framebuffer work in console only Debian installation.
>> I find many of the howto's on the web won't work for current Debian
>> Stable - or I'm just too stupid to figure them out.
>
> what graphic card/chip do you have?
> You might have to remove the corresponding framebuffer from
> /etc/modprobe.d/fbdev-blacklist.conf
>
>> < grin >
>>
>> I want to get fbi and links2 -g working in console.
>>
>> I tried entering in console:
>>
>> sudo mknod /dev/fb0 c 29 0
>
> Shouldn't be necessary. If the correct driver is loaded the device should appear
> immediately.
>
>
> Best regards,
>
> Florian Tobias Schandinat
>
>>
>> But when I reboot /dev/fb0 does not exist.
>>
>> I've had links2 -g working before - I've got libdirectfb-dev
>> libdirectfb-bin and all the files I can find with directfb to install.
>>
>> I am working on Debian Stable command line only.
>>
>> David
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
