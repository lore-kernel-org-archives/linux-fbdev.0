From: Kronos <kronos@people.it>
Subject: Re: Re: 2.6.8.1-mm2
Date: Fri, 20 Aug 2004 18:20:45 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040820162045.GB5184@dreamland.darkstar.lan>
References: <20040819014204.2d412e9b.akpm@osdl.org> <20040820005019.GB6374@logos.cnet> <20040819230850.09d7d274.akpm@osdl.org> <200408201711.26091.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByC8S-0001BH-M4
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 09:21:00 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1ByC8R-0001ZG-6o
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 09:21:00 -0700
Content-Disposition: inline
In-Reply-To: <200408201711.26091.adaplas@hotpop.com>
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>

Il Fri, Aug 20, 2004 at 05:11:26PM +0800, Antonino A. Daplas ha scritto: 
> > > drivers/built-in.o(.text+0xa1bde): In function `radeon_match_mode':
> > > : undefined reference to `vesa_modes'
> > >
> > > drivers/built-in.o(.text+0xa1cbd): In function `radeon_match_mode':
> > > : undefined reference to `vesa_modes'
> > >
> > > make: ** [.tmp_vmlinux1] Erro 1
> > >
> > > Known already?
> >
> > nope.  That symbol is exported to modules.
> >
> 
> Oops.  vesa_modes is now dependent on CONFIG_FB_MODE_HELPERS.  
> I'll submit a patch over the weekend to fix drivers that require this option.
> 
> Tony

Hi,
I sent the following patch a while ago. radeonfb, rivafb and i810fb need
CONFIG_FB_MODE_HELPERS the patch makes them select it: 

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
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
