From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: ioremap problem on highmem
Date: Mon, 13 Oct 2003 17:46:51 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031014004651.36307.qmail@web14914.mail.yahoo.com>
References: <20031014001445.GC454@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9DKu-0003dH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 13 Oct 2003 17:46:52 -0700
Received: from web14914.mail.yahoo.com ([216.136.225.241])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A9DKt-0001lV-Qa
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Oct 2003 17:46:51 -0700
In-Reply-To: <20031014001445.GC454@guug.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Otto Solares <solca@guug.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Fix is not that simple. There is a basic conflict with mapping framebuffers
into the kernel address space and the kernel's need of that address space for
other purposes. Drivers need to be rewritten to do one of:

1) Map the frame buffer into the kernel address space a few pages at a time.
This is how kernel high mem support works.
2) Map the minimal amount of address space necessary for visible framebuffer.
This is what the VGA driver does. It works most of the time.
3) Use a user space program to map the framebuffer and do the drawing.
4) Use the reserve= to reserve the needed address space. This boots performance
sensitive page tables into highmem while keeping your slow framebuffer in
lowmem.

It is only fbconsole that uses the kernel mapped framebuffer. If you aren't
using fbconsole you could just delete the ioremap code from the framebuffer
driver. Another quick fix would be to eliminate the framebuffer ioremaps from
each driver and instead do it in the fbconsole driver. This would let people
still load fb drivers and not load fbconsole.

The more I learn about fbconsole the more I think it is a bad idea. This is no
comment on the skill of the people writing it, I just think the whole concept
of mapping the framebuffer in to kernel space needs to be eliminated. There is
only 1GB of kernel space and it make no sense to chew up 128MB or 256MB of it
mapping a framebuffer just to get a penguin at boot. I do think penguin is
cute, but not cute enough to waste kernel address space on.

Right now I am exploring this alternative:
1) System boots using VGA mode or whatever BIOS provides.
2) DRI drivers are loaded. They have been modified to use PCI subsys to find
hardware.
3) Run a console program. This program uses a user level lib (from standalone
mesa) to switch to graphics mode and draw the console. Like gnome-terminal does
under X.
4) Run X or standalone mesa on another VT. Everything shares DRI driver for
hardware interface.

The advantage to this is that there is a single hardware driver in the system -
the DRI one; the fb driver is gone. The only loss I see is no penguin at boot. 

Standalone Mesa is using the fb driver to 1) find the hardware, 2) change
modes. Under the new system the DRI driver finds the hardware. Mode
setting/EDID is done with a user level library - like X does. Once get this
finished Standalone Mesa won't need FB any more.


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
