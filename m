From: Fredrik Noring <noring@nocrew.org>
Subject: [PATCH] rivafb sync polarity problem?
Date: 19 Jan 2003 13:55:42 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042980943.12192.34.camel@h9n1fls20o980.telia.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from maile.telia.com ([194.22.190.16])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18aEyM-0000ix-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 19 Jan 2003 04:54:46 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Ani Joshi <ajoshi@shell.unixbox.com>

Hi,

It seems the mode below doesn't work with rivafb in Linux 2.4.21-pre2,
the RGB (TV) screen fail to sync properly. (The equivalent modeline in
XFree86 4.2 works.)

    mode "768x288"
        geometry   768 288   768 288   32
        timings    62500   120 80   20 2   54 2
        hsync low
        vsync low
    endmode

I suspect it may have something to do with the sync polarity, as it
does not seem to be implemented fully in the rivafb driver? (Then again,
it seems the polarity always is forced low by the driver, I'm not sure.)

Looking at http://web.inter.nl.net/hcc/S.Weijgers/FreeVGA/vga/extreg.htm
and reading XFree86 source code indicate it should be fairly simple to
solve this, given that the correct bits are set/cleared of course. :)

The patch below tries to set the proper polarity. The mode still doesn't
work though, since misc_output already is 0xEB by default. I don't know
if the patch is wrong or which additional problems the rivafb driver
might have with the mode.

Any ideas?

Thanks

	Fredrik

--- linux-2.4.21-pre2.old/drivers/video/riva/fbdev.c	2002-08-03 02:39:45.000000000 +0200
+++ linux-2.4.21-pre2.new/drivers/video/riva/fbdev.c	2003-01-19 13:21:46.000000000 +0100
@@ -920,6 +920,15 @@
 	newmode.ext.width = width;
 	newmode.ext.height = height;
 
+	if(video_mode->sync & FB_SYNC_HOR_HIGH_ACT)
+		newmode.misc_output &= ~0x40;
+	else
+		newmode.misc_output |= 0x40;
+	if(video_mode->sync & FB_SYNC_VERT_HIGH_ACT)
+		newmode.misc_output &= ~0x80;
+	else
+		newmode.misc_output |= 0x80;
+	
 	rinfo->riva.CalcStateExt(&rinfo->riva, &newmode.ext, bpp, width,
 				  hDisplaySize, hDisplay, hStart, hEnd,
 				  hTotal, height, vDisplay, vStart, vEnd,



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
