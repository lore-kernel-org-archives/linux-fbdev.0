From: "Giampaolo Tomassoni" <Giampaolo@Tomassoni.biz>
Subject: Linux 2.6.x misses pci, fb,
	agp and dri support for the Intel E7221 chipset
Date: Thu, 3 Jan 2008 16:20:39 +0100
Message-ID: <002201c84e1c$327c5900$97750b00$@biz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JARqv-0006lb-QY for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Jan 2008 07:19:25 -0800
Received: from smtp-out3.libero.it ([212.52.84.43])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JARqu-0001wH-5N
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Jan 2008 07:19:25 -0800
Received: from mailrelay07.libero.it (192.168.32.94) by smtp-out3.libero.it
	(7.3.120)
	id 4628C87A01A71969 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 3 Jan 2008 16:19:18 +0100
Content-Language: it
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Dears,

I see that every Linux 2.6.x kernel is actually missing any support for the
Intel E7221 chipset (aka i915).

Linux 2.6.23, in example, doesn't even report the 0x258A PCI id in
include/linux/pci_ids.h...

However, from Xorg's xf86-video-intel-2.1.1 driver I see that this kind of
video chipset would be handled by the i810_driver.c, if the linux AGP driver
would in turn handle it.

Xorg's driver defines the following in common.h:

	#ifndef PCI_CHIP_E7221_G
	#define PCI_CHIP_E7221_G	   0x258A
	/* Same as I915_G_BRIDGE */
	#define PCI_CHIP_E7221_G_BRIDGE	   0x2580
	#endif

I found this chipset in some Dell PowerEdge SC420 servers I manage, which
are more or less two years old.

Is there any reason why the E7221 chipset can't be handled by the fb, agp
and (possibly) dri drivers from linux?

Thank you,

Giampaolo


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
