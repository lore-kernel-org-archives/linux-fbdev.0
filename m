From: Egbert Eich <eich@xfree86.org>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Sat, 25 Oct 2003 19:29:18 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <16282.45806.428547.279213@zeus.local>
References: <20031023213144.66685.qmail@web14916.mail.yahoo.com>
	<Pine.LNX.4.44.0310231541000.3421-100000@home.osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADSgG-0004QH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 25 Oct 2003 10:58:28 -0700
Received: from smtp.compuserve.de ([62.52.27.101] helo=desws061.mediaways.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1ADSba-0005yw-1E
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 25 Oct 2003 10:53:38 -0700
In-Reply-To: torvalds@osdl.org wrote on Thursday, 23 October 2003 at 16:23:44 -0700 
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>, Jeff Garzik <jgarzik@pobox.com>

Linus Torvalds writes:
 > > could lead to problems with hotplug.  XFree is also mapping PCI ROMs in without
 > > informing the kernel and that can definitely cause problems.
 > 
 > Absolutely. Changing PCI configurations without telling the kernel _will_ 
 > cause problems. Especially for hotplug systems, but it's also very iffy to 
 > do if the card is behind a PCI bridge, since you have to take bridge 
 > resources into account (and know which bridges are transparent, which are 
 > not, etc etc). 

Speaking of XFree86: when I developed the PCI resource stuff in 
XFree86 I was trying to get support from kernel folks to get the 
appropriate user space interfaces into the kernel. When I got 
nowhere I decided to do everything myself. 
XFree86 does PCI bridge tracking and one reason it does this is PCI
ROM mapping. 
 > 
 > The kernel spends a lot of effort on getting this right, and even so it 
 > fails every once in a while (devices that use IO or memory regions without 
 > announcing them in the standard BAR's are quite common, and the kernel has 
 > to have special quirk entries for things like that).

Right. One reason why the PCI code in XFree86 looks so difficult is
that old ATi Mach?? cards had their 8514 registers (and their mirror
images) scattered all over the PIO space.

 > 
 > Few enough drivers actually want to enable the roms, but the code should 
 > look something like
 > 
 > 	/* Assign space for ROM resource if not already assigned. Ugly. */
 > 	if (!pci_resource_start(dev, PCI_ROM_RESOURCE))
 > 		if (pci_assign_resource(dev, PCI_ROM_RESOURCE) < 0)
 > 			return -ENOMEM;

[Stuff deleted] .....

Is there any API that allows one to do this from user space?
There are plenty of XFree86 drivers around that don't have a
DRM kernel module and it should  be possible to run those which
do without DRI support, therefore it would be a good if the
XFree86 driver could do this registration itself.

Cheers,
	Egbert.


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
