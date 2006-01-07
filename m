From: Adam Felix Bogacki <afb@paradise.net.nz>
Subject: How to disable 'rivafb_pan_display START' at boot ?
Date: Sun, 08 Jan 2006 09:42:02 +1300
Message-ID: <43C0279A.7060708@paradise.net.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-powerpc=debian-powerpc=m.gmane.org@lists.debian.org>
Resent-Message-ID: <oaAKqC.A.3OB.ssCwDB@murphy>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-powerpc@lists.debian.org>
List-Help: <mailto:debian-powerpc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=unsubscribe>
Content-Type: text/plain; charset="us-ascii"
To: ajoshi@unixbox.com, linux-fbdev-devel@lists.sourceforge.net, linux-nvidia@lists.surfsouth.com, debian-powerpc@lists.debian.org

Hi,  I had to recompile the kernel after an OOPS wiped out things
including all old kernel images .. after using a LiveCD I could boot
but had to manually mount and had no network connection.

I recompiled via 'make menuconfig' a number of times until there were no
error
messages after 'make modules_install' and went through the usual process
until after
reboot I able to do

'Tux:~# /etc/rcS.d/S40networking start'

and go straight into 'apt-get update' and 'apt-get -f upgrade' successfully.

The upgrade was big and took a long time. I had noticed some instability
on what looked like a malformed screensaver so I kept tapping the spacebar as 
the upgrade moved into install phase.

At one stage I had to leave the keyboard briefly and on returning found ..

[xxx.xxxxxx] rivafb_pan_display START   [xxx.xxxxxx] rivafb_pan_display START
[xxx.xxxxxx] rivafb_pan_display END     [xxx.xxxxxx] rivafb_pan_display END
[xxx.xxxxxx] rivafb_pan_display START   [xxx.xxxxxx] rivafb_pan_display START
[xxx.xxxxxx] rivafb_pan_display END     [xxx.xxxxxx] rivafb_pan_display END
[xxx.xxxxxx] rivafb_pan_display START   [xxx.xxxxxx] rivafb_pan_display START
[xxx.xxxxxx] rivafb_pan_display END     [xxx.xxxxxx] rivafb_pan_display END
[xxx.xxxxxx] rivafb_pan_display START   [xxx.xxxxxx] rivafb_pan_display START
[xxx.xxxxxx] rivafb_pan_display END     [xxx.xxxxxx] rivafb_pan_display END

.. in the left half of the screen, [xxx] being digits rapidly cycling upwards.

I have been trying various boot parameters to disable 'rivafb' without
success, including

BOOT_DEBUG=3
debian/installer/framebuffer=false
video=vga16:off
console=ttys0
console=tty1

Also, the font is really tiny and I've tried to introduce arguments to
suit 1024x768 'fb1024' works on the Gentoo-based Rescue CD but not here, neither do
variants including 'video=rivafb:1024' or 'rivafb=1024' .. but that is a minor point.
 
I've discovered that 'rivafb' is known to be incompatible with the
nvidia driver and since it is in the kernel the only fix seems to be to

'make menuconfig' -> Device Drivers -> Graphics -> Framebuffer (and
disable 'rivafb') before 'make bzImage' and so on.

Successive 'init=1'  reboots get almost as far as passwd login before the 
'rivafb screensaver' kicks in ..

How do I disable it ?

Adam Bogacki.
afb@paradise.net.nz
