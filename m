From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [RFC] Video Mode Handling
Date: Sun, 8 Aug 2004 20:50:02 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040809035002.65812.qmail@web14924.mail.yahoo.com>
References: <200408090944.01414.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bu1Ah-0000xb-Cq
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 20:50:03 -0700
Received: from web14924.mail.yahoo.com ([216.136.225.8])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1Bu1Ag-0004nE-Qm
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 20:50:03 -0700
In-Reply-To: <200408090944.01414.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

There was a lot of discussion about mode handling at OLS. Here's some
of the lwn coverage...

http://lwn.net/Articles/94202/
http://lwn.net/Articles/94763/

I'll attach a list of points discussed. Mode setting needs to cover
multihead cards, and devices that only use the BIOS for mode setting.
There also needs to be coordinated memory management when multiple
heads are involved. Point 7 talks about a design where most of the mode
setting code is moved to user space via hotplug.

Can your design be adjusted to work in the framework outlined below?

---------------------------------------------------------------
After talking to many people at OLS this seems to be the consensus for
rearchitecting fbdev/DRM. It has been proposed that this design be a
five year goal and there is still disagreement about the exact path to
get there.

This is a first pass for lkml people. I will incorporate comments and
repost for the final pass. I'm sure everyone will let me know if I've
misinterpreted some of the design points.

First a basic definition. There are two consoles, the kernel one
(printk, kdbg, OOPs, etc) and user one (normal console logins). In
Linux these are currently implemented with the same code. There may be
advantages to splitting the implementation in a future design.

1) PCI ROMs - these would be exposed via sysfs. A quirk is needed to
track the boot video device and expose the contents of C000:0 for that
special case. See the lkml thread: Exposing ROM's though sysfs, there
are already proposed patches.

2) VGA control - there needs to be a device for coordinating this. It
would ensure that only a single VGA device gets enabled at a time. It
would also adjust PCI bus routing as needed. It needs commands for
disabling all VGA devices and then enabling a selected one. This device
may need to coordinate with VGA console. You have to use this device
even if you aren't using VGA console since it ensures that only a
single VGA device gets enabled.
Alan Cox: what about hardware that supports multiple vga routers? do we
care?
JS: no design work has been done for this device, what would be it's
major/minor? would this be better done in sysfs?

3) Secondary card reset - Handled by an initial hotplug event. We need
a volunteer to write clean vm86 and emu86 apps for running the ROM
initialization. Resetting needs #1 and #2 to work since resetting a
card will enable it's VGA mode. I have an implementation of this but it
needs a lot of clean up.

4) DRM code reorganization. There were several requests to reorganize
DRM to more closely follow the Linux kernel guidelines. This
reorganization should occur before new features are added.

5) Multihead cards will expose one device file per head. Many IOCTLs
exposed by these devices will be common. Some, like mode setting, will
be per head.

6) Mode setting before early user space - this was decided to be a
platform specific problem. With minor adjustment the kernel can be made
to boot without printing anything except errors before early user space
starts. Platform specific code will need to handle these error messages
if any. This includes INT10, Openfirmware, mainframe serial consoles,
VGA mode. Suppressing informatory printing before early user space
starts allows a clean boot straight into graphics mode.

7) Mode setting from normal user space - devices will have a standard
IOCTL accepting a mode string like fbdev currently uses. This IOCTL
will lock the device and optionally trigger a hotplug mode event. Mode
setting for some fixed devices is simple enough to avoid the hotplug
event. In the hotplug event the mode line will be decoded, DDC queried,
etc. Some classes of devices (for example Intel 810,830,915) have to
have their mode set using vm86 and the video BIOS. Others might use a
small C app to query DDC and then use a device specific IOCTL to set
the mode registers. Early boot and normal user space will use the same
hotplug apps so they need to be as small as possible (good luck IA64
and emu86).

8) Merged fbmode - per head mode lists will include merged fb modes if
the other heads aren't in use. Setting a merged fb mode will lock out
the other head devices. It was decided that this was a better design
than having a control device.

9) printk - setting the mode will also record the fb location, size,
stride. Combining this info with the current fbconsole code will allow
printk/oops to print in all modes.

10) a new system console UI is proposed. SysReq blanks the current
screen and replaces it with the system console. System console will
also support runing kdbg. Hit SysReq again and whatever you were doing
is restored. This operation does not change the video mode.

11) OOPs will cause an immediate screen clear and painting of the
system console including the OOPs data. It is not needed to change the
video mode. Further drawing to the screen will be blocked until SysReq
returns to normal operation if possible.
Alan Cox: No consensus on the screen clear bit - there are actually
reasons to argue against it.
JS: Maybe save the contents at OOPs time and hotkey back to it? This
assumes the system is stable enough to do the copy and access the
keyboard. Another idea: start painting the OOPs from the top without
clearing, hope useful userspace data is at the bottom?
Nicolas Mailhot: Don't forget about power management, unblank the
screen and don't let it blank again since you may not get it back.
Graphics mode lets more OOPs info fit.

12) interrupt time printk - certain hardware implements
non-interruptible operations. Most modern hardware does not do this.
For older hardware these non-interruptible operations will need to be
wrapped by the device driver. The complete data needed to finish the
operation will be provided in the IOCTL. Doing this enables an
interrupt time printk to call into the driver, make sure the hardware
is free by completing the pending operation, and then write to the
framebuffer. No older hardware currently implements this protection;
without this protection there is potential for locking the machine.

13) all of the features being discussed are implemented by a single
device driver plus a supporting set of library drivers. Multitasking of
multiple controlling device drivers for a single piece of hardware is
not allowed.

14) A new framebuffer memory manager is needed for mesa GL support. Ian
is working on it. The memory manager will be part of the support
library driver code. 

15) Over time user space console will be moved to a model where VT's
are implemented in user space. This allows user space console access to
fully accelerated drawing libraries. This might allow removal of all of
the tty/vc layer code avoiding the need to fix it for SMP.

16) accelerated, kernel based console drivers are not easily written in
this model. The only in kernel operations are simple ones like
CR/scroll, clear, print text. It is possible to call existing DRM entry
points from a kernel thread, but the code needed is complex. Note that
only things like printk use this console so is there a real need for
acceleration?

17) A user space console implementation also makes supporting multiple
users on multiple heads/card easier. The kernel will not need to be
modified for multi-user VT support. User mode console allows pretty
text and Asian scripts.

18) A coordinated system for grouping console devices needs to be
designed. This will be bad if each distro does it differently. One
proposal is to use udev to create: /console/1/mouse,
/console/1/keyboard, /console/1/usb_hub, /console/2/mouse,
/console/3/keyboard, /console/4/usb_hub, etc.
Alan Cox: Another is to use namespace mounts

19) SAK - secure attention key. We forgot to talk about this so we need
a design.
Alan Cox: Falls straight out of having the kernel + helper mode setting

20) A PAM login would assign ownership of the console group devices to
the logged in user. A mechanism needs to be designed for assigning
ownership of secondary heads for the merged fb case. X should run as
the logged in user and not require root if the hardware allows.

21) It was also discussed the X should stop implementing OS level
features and instead use the features of the underlying OS. If the
underlying OS is lacking support the support would be implemented in a
library external to X. Examples of moving from X to OS support include:
PCI bus, input, console groupings, etc.

22) A goal this design is to discourage user space video driver
implementations when a kernel one exists. An example of this would be
X's radeon XAA driver. X would instead use the DRM driver via mesa.

23) The old schemes are not going to be removed. If your ancient 2D
card only has an fbdev and XAA driver it will still work. We're not
going to remove old drivers if new ones don't exist. But don't expect
the composting X server to turn your clunker 2D card in to a Radeon
X800.












=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
