From: Jakub Bogusz <qboosh@pld.org.pl>
Subject: [PATCH] tdfxfb: fix for background used in fbcon_clear
Date: Thu, 31 Jul 2003 01:43:27 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030730234327.GA3694@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pg224.warszawa.cvx.ppp.tpnet.pl ([213.76.102.224] helo=satan.blackhosts)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19i0Ze-0007zF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Jul 2003 16:41:39 -0700
Received: from satan.blackhosts (localhost [127.0.0.1])
	by satan.blackhosts (8.12.9/8.12.9) with ESMTP id h6UNhVY2003912
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 31 Jul 2003 01:43:31 +0200
Received: (from qboosh@localhost)
	by satan.blackhosts (8.12.9/8.12.9/Submit) id h6UNhROO003909
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 31 Jul 2003 01:43:27 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

This time I checked recent linux-fbdev-devel archives - and didn't see
any patch for this issue. So here is my fix.

There was wrong color used in fillrect in 16/24/32bpp (pseudo_palette
mapping was omitted), which resulted in ugly black (well, almost black)
rectangles painted when some "clear" terminal command was sent (like
"^[[J", "^[[K") with background colour different than black.
It was visible e.g. in mc's View.


BTW, if I use 800x600 framebuffer (i.e. 100x37.5 charasters) the
remaining half line at the bottom sometimes changes colour from black
to some other (used as background in last "clear" command).
Shouldn't margins always be black?
Background of last erase character is definitely not what we want...

I changed "region.color = attr_bgcol_ec(bgshift, vc);" to
"region.color = 0;" in accel_clear_margins()
(linux/drivers/video/console/fbcon.c:505) - it fixed this issue and
I can't see any side-effects.

-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-tdfxfb-fillrect.patch"

This fixes background used for "clear" terminal commands (^[[J, ^[[K etc.)
in 16/24/32bpp modes.

--- linux-2.6.0-test2/drivers/video/tdfxfb.c.orig	2003-07-30 08:31:57.000000000 +0200
+++ linux-2.6.0-test2/drivers/video/tdfxfb.c	2003-07-31 00:44:26.000000000 +0200
@@ -890,7 +890,11 @@
 
 	banshee_make_room(par, 5);
 	tdfx_outl(par,	DSTFORMAT, fmt);
-	tdfx_outl(par,	COLORFORE, rect->color);
+	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
+		tdfx_outl(par,	COLORFORE, rect->color);
+	} else { /* FB_VISUAL_TRUECOLOR */
+		tdfx_outl(par, COLORFORE, ((u32*)(info->pseudo_palette))[rect->color]);
+	}
 	tdfx_outl(par,	COMMAND_2D, COMMAND_2D_FILLRECT | (tdfx_rop << 24));
 	tdfx_outl(par,	DSTSIZE,    rect->width | (rect->height << 16));
 	tdfx_outl(par,	LAUNCH_2D,  rect->dx | (rect->dy << 16));

--PEIAKu/WMn1b1Hv9--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
