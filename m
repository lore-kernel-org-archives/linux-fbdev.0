From: James Simmons <jsimmons@infradead.org>
Subject: Re: ioremap problem on highmem
Date: Tue, 14 Oct 2003 17:49:33 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310141735250.20831-100000@phoenix.infradead.org>
References: <20031014004651.36307.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9SMm-0004CI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Oct 2003 09:49:48 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A9SMk-0007yY-U7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Oct 2003 09:49:47 -0700
In-Reply-To: <20031014004651.36307.qmail@web14914.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Otto Solares <solca@guug.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I just think the whole concept
> of mapping the framebuffer in to kernel space needs to be eliminated. 

I agree. That is why I moved the api over to a accelerated api. The idea 
was to get people to write accelerated drivers. Drivers using acceleration 
don't need to map the framebuffer in kernel space.

> 1) System boots using VGA mode or whatever BIOS provides.

On x86 platforms this fine but for the rest of the world this is not.

> 2) DRI drivers are loaded. They have been modified to use PCI subsys to find
> hardware.

You could make a dricon but you going to have to add kernel side graphics 
support. You need image drawing in kernel space in the DRI driver then to 
do printk's. You will also need to copyareas and fillrect functions. Then 
you will need mode switching support as well as cursor support. Basically 
you will have to port all of fbdev into the DRI api. Then you will need to 
make sure DRI working on arm and m68k and uClinux platforms. 

> 3) Run a console program. This program uses a user level lib (from standalone
> mesa) to switch to graphics mode and draw the console. Like gnome-terminal does
> under X.

So we will see printk's when init runs. It will make life much harders to 
read oops if we never get there.

> 4) Run X or standalone mesa on another VT. Everything shares DRI driver for
> hardware interface.

And this helps printk support how? You just can't get around the need for 
a framebuffer console on non x86 platforms. The day will come when x86 
will also no longer support VGA text mode.

> The advantage to this is that there is a single hardware driver in the system -
> the DRI one; the fb driver is gone. The only loss I see is no penguin at boot. 

Also long as you port the entire api into DRI I'm fine with that.

> Standalone Mesa is using the fb driver to 1) find the hardware, 2) change
> modes. Under the new system the DRI driver finds the hardware. Mode
> setting/EDID is done with a user level library - like X does. Once get this
> finished Standalone Mesa won't need FB any more.

Nice. Still doesn't solve the need to display oops meessages tho. 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
