From: Jakub Bogusz <qboosh@pld.org.pl>
Subject: PATCH: tdfxfb palette fix for 2.6.0-test2
Date: Wed, 30 Jul 2003 00:14:11 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030729221411.GA3434@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from px125.warszawa.cvx.ppp.tpnet.pl ([217.99.7.125] helo=satan.blackhosts)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19hcmu-0005xh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Jul 2003 15:17:45 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

In 2.6.0-test2 text palette is broken in 16/24/32bpp modes on tdfxfb
console (because of not using component length information).
This patch fixes it; see also note inside.


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-tdfxfb-palette.patch"

This fixes palette used for text in 16/24/32bpp modes on tdfxfb console.
Note that pseudo_palette is always referenced as array od 32-bit uints
in cfbimgblt.c, regardless of current bpp.

--- linux-2.6.0-test2/drivers/video/tdfxfb.c.orig	2003-07-14 05:32:29.000000000 +0200
+++ linux-2.6.0-test2/drivers/video/tdfxfb.c	2003-07-29 23:42:07.000000000 +0200
@@ -559,6 +559,8 @@
 			var->red.length = var->green.length = var->blue.length = 8;
 			break;
 	}
+	var->transp.offset = 32;
+	var->transp.length = 0;
 	var->height = var->width = -1;
   
 	var->accel_flags = FB_ACCELF_TEXT;
@@ -788,14 +790,10 @@
 			break;
 		/* Truecolor has no hardware color palettes. */
 		case FB_VISUAL_TRUECOLOR:
-			rgbcol = (red << info->var.red.offset) |
-				 (green << info->var.green.offset) |
-				 (blue << info->var.blue.offset) |
-				 (transp << info->var.transp.offset);
-			if (info->var.bits_per_pixel <= 16)
-				((u16*)(info->pseudo_palette))[regno] = rgbcol;
-			else
-				((u32*)(info->pseudo_palette))[regno] = rgbcol;
+			rgbcol = ((red >> (16 - info->var.red.length)) << info->var.red.offset) |
+				 ((green >> (16 - info->var.green.length)) << info->var.green.offset) |
+				 ((blue >> (16 - info->var.blue.length)) << info->var.blue.offset);
+			((u32*)(info->pseudo_palette))[regno] = rgbcol;
 			break;
 		default:
 			DPRINTK("bad depth %u\n", info->var.bits_per_pixel);

--u3/rZRmxL6MmkK24--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
