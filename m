From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH fbtest] fix blue feet by 24bpp
Date: Mon, 18 Oct 2004 00:25:24 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410180025.24498.alex.kern@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UFvcBZd9uoEu+qJ"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJJSs-0000mo-Bp
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 15:25:22 -0700
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CJJSr-0006w2-Fc
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 15:25:22 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: fbdev mail-list <linux-fbdev-devel@lists.sourceforge.net>

--Boundary-00=_UFvcBZd9uoEu+qJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, I have investigate, that blue feet by penguin in fbtest and 24bpp deep 
was caused by error in cfb24.c.
This patch fix it for me



But I have steel problems in test 007 and 008

I have posted photo pixs on 
http://home.arcor.de/alexander.khe/atyfb/fbtest-results/

Is it the similar problems with byte separation?

Cheers
Alex

--Boundary-00=_UFvcBZd9uoEu+qJ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fbtest24bppfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fbtest24bppfix.patch"

--- drawops/cfb24.c.orig	2002-10-08 16:20:27.000000000 +0200
+++ drawops/cfb24.c	2004-10-17 15:08:02.000000000 +0200
@@ -33,9 +33,9 @@ static void cfb24_setpixel(u32 x, u32 y,
     u8 *dst;
 
     dst = &screen[y*screen_width+x*3];
-    dst[0] = (pixel >> 16) & 0xff;
+    dst[2] = (pixel >> 16) & 0xff;
     dst[1] = (pixel >> 8) & 0xff;
-    dst[2] = pixel & 0xff;
+    dst[0] = pixel & 0xff;
 }
 
 static pixel_t cfb24_getpixel(u32 x, u32 y)
@@ -43,7 +43,7 @@ static pixel_t cfb24_getpixel(u32 x, u32
     const u8 *src;
 
     src = &screen[y*screen_width+x*3];
-    return (src[0] << 16) | (src[1] << 8) | src[2];
+    return (src[2] << 16) | (src[1] << 8) | src[0];
 }
 
 const struct drawops cfb24_drawops = {

--Boundary-00=_UFvcBZd9uoEu+qJ--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
