From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Dri-devel] Two Linux framebuffer patches, Radeon and Rage128
Date: Sun, 10 Aug 2003 20:57:43 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030811035743.49382.qmail@web14903.mail.yahoo.com>
References: <3F36CAC5.7060504@us.ibm.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14903.mail.yahoo.com ([216.136.225.55])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19m3oV-00050M-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 10 Aug 2003 20:57:43 -0700
In-Reply-To: <3F36CAC5.7060504@us.ibm.com>
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
To: Ian Romanick <idr@us.ibm.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, dri-devel <dri-devel@lists.sourceforge.net>

As far as I know linux/pci_ids.h is not being
generated, it is hand built. That probably explains
why it had about 15 entries in it that were wrong for
the Radeon/Rage128.

My understanding is that drivers/pci/pci.ids is
semi-hand built. It is partially generated from
http://pciids.sf.net/ and then hand diffed. It can be
config'ed out of the kernel by unchecking PCI
Names/PCI_CONFIG_NAMES. When there are no pretty name
available from PCI names then I generate one from chip
ID and PCI ID. This name is only used to log the
sign-on message so that you know the driver loaded and
found your card.

I would like to find a more authoritative database of
which chip family the various chip IDs belong to. I
would also like to know for sure whether each is PCI,
AGP, or secondary. Is there a way to get this info
from the cards themselves and not hardcode it? It also
would be nice to have a scipt to generate the code for
the drivers, but we need a good database to run it
against.

I'm working on the embedded Mesa code. Embedded Mesa
does not use XFree xf86PciInfo.h, instead it relies on
the Linux framebuffer drivers to identify the cards
via the modules/PCI hotplug system. The Rage128/Radeon
framebuffer drivers are not heavily used so I'm being
forced to update them. 

Embedded Mesa does need chip family info and PCI/AGP
status. I should probably modifiy the framebuffer
drivers to make this info accessible. Right now the
embedded Mesa drivers regenerate it based on chip ID
thus duplicating the chip ID/family data. 

For Linux the best solution would be to simply merge
the framebuffer and 3D drivers into a single driver. A
lot of duplicated code would be eliminated. That would
solve other problems too like locking and register
stomping.


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
