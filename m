From: Kronos <kronos@people.it>
Subject: Re: [PATCH 4/5] Video Mode Handling - Reduce memory footprint of fbdev
Date: Mon, 9 Aug 2004 17:08:33 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040809150833.GA4244@dreamland.darkstar.lan>
References: <200408090946.30692.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BuBlS-0003YX-Vv
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 08:08:42 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BuBlS-0000PZ-Ay
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 08:08:42 -0700
Content-Disposition: inline
In-Reply-To: <200408090946.30692.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Mon, Aug 09, 2004 at 09:46:30AM +0800, Antonino A. Daplas ha scritto: 
> b. Add CONFIG_FB_MODE_HELPERS.  Unselecting this will uninclude the code for 
> Generalized Timing Formula and the EDID parser on kernel compilation.  These
> are used only by radeonfb, rivafb and i810fb.

Then make radeonfb, rivafb and i810fb select CONFIG_FB_MODE_HELPERS:

--- a/drivers/video/Kconfig	2004-08-09 17:03:58.000000000 +0200
+++ b/drivers/video/Kconfig	2004-08-09 17:04:56.000000000 +0200
@@ -437,6 +437,7 @@
 	depends on FB && PCI
 	select I2C_ALGOBIT if FB_RIVA_I2C
 	select I2C if FB_RIVA_I2C
+	select FB_MODE_HELPERS
 	help
 	  This driver supports graphics boards with the nVidia Riva/Geforce
 	  chips.
@@ -469,6 +470,7 @@
 config FB_I810
 	tristate "Intel 810/815 support (EXPERIMENTAL)"
 	depends on FB && AGP && AGP_INTEL && EXPERIMENTAL && PCI	
+	select FB_MODE_HELPERS
 	help
 	  This driver supports the on-board graphics built in to the Intel 810 
           and 815 chipsets.  Say Y if you have and plan to use such a board.
@@ -672,6 +674,7 @@
 	depends on FB && PCI
 	select I2C_ALGOBIT if FB_RADEON_I2C
 	select I2C if FB_RADEON_I2C
+	select FB_MODE_HELPERS
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
 	  a framebuffer device.  There are both PCI and AGP versions.  You


Luca
-- 
Home: http://kronoz.cjb.net
Do, or do not. There is no try.


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
