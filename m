From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 1/4] cirrusfb: fix up debug printk types
Date: Fri, 5 Sep 2008 23:53:12 +0200
Message-ID: <20080905235312.ae259d60.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kbj8E-0007nt-VB for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 14:46:18 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kbj8D-0004hT-B0
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 14:46:18 -0700
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Fix debug printk types mismatch after
my earlier changes.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 50fdd33..30c47f1 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -811,21 +811,21 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 	vga_wcrt(regbase, VGA_CRTC_V_SYNC_END, 0x20);	/* previously: 0x00) */
 
 	/* if debugging is enabled, all parameters get output before writing */
-	DPRINTK("CRT0: %ld\n", htotal);
+	DPRINTK("CRT0: %d\n", htotal);
 	vga_wcrt(regbase, VGA_CRTC_H_TOTAL, htotal);
 
-	DPRINTK("CRT1: %ld\n", hdispend);
+	DPRINTK("CRT1: %d\n", hdispend);
 	vga_wcrt(regbase, VGA_CRTC_H_DISP, hdispend);
 
-	DPRINTK("CRT2: %ld\n", var->xres / 8);
+	DPRINTK("CRT2: %d\n", var->xres / 8);
 	vga_wcrt(regbase, VGA_CRTC_H_BLANK_START, var->xres / 8);
 
 	/*  + 128: Compatible read */
-	DPRINTK("CRT3: 128+%ld\n", (htotal + 5) % 32);
+	DPRINTK("CRT3: 128+%d\n", (htotal + 5) % 32);
 	vga_wcrt(regbase, VGA_CRTC_H_BLANK_END,
 		 128 + ((htotal + 5) % 32));
 
-	DPRINTK("CRT4: %ld\n", hsyncstart);
+	DPRINTK("CRT4: %d\n", hsyncstart);
 	vga_wcrt(regbase, VGA_CRTC_H_SYNC_START, hsyncstart);
 
 	tmp = hsyncend % 32;
@@ -834,7 +834,7 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 	DPRINTK("CRT5: %d\n", tmp);
 	vga_wcrt(regbase, VGA_CRTC_H_SYNC_END, tmp);
 
-	DPRINTK("CRT6: %ld\n", vtotal & 0xff);
+	DPRINTK("CRT6: %d\n", vtotal & 0xff);
 	vga_wcrt(regbase, VGA_CRTC_V_TOTAL, vtotal & 0xff);
 
 	tmp = 16;		/* LineCompare bit #9 */
@@ -863,19 +863,19 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 	DPRINTK("CRT9: %d\n", tmp);
 	vga_wcrt(regbase, VGA_CRTC_MAX_SCAN, tmp);
 
-	DPRINTK("CRT10: %ld\n", vsyncstart & 0xff);
+	DPRINTK("CRT10: %d\n", vsyncstart & 0xff);
 	vga_wcrt(regbase, VGA_CRTC_V_SYNC_START, vsyncstart & 0xff);
 
-	DPRINTK("CRT11: 64+32+%ld\n", vsyncend % 16);
+	DPRINTK("CRT11: 64+32+%d\n", vsyncend % 16);
 	vga_wcrt(regbase, VGA_CRTC_V_SYNC_END, vsyncend % 16 + 64 + 32);
 
-	DPRINTK("CRT12: %ld\n", vdispend & 0xff);
+	DPRINTK("CRT12: %d\n", vdispend & 0xff);
 	vga_wcrt(regbase, VGA_CRTC_V_DISP_END, vdispend & 0xff);
 
-	DPRINTK("CRT15: %ld\n", (vdispend + 1) & 0xff);
+	DPRINTK("CRT15: %d\n", (vdispend + 1) & 0xff);
 	vga_wcrt(regbase, VGA_CRTC_V_BLANK_START, (vdispend + 1) & 0xff);
 
-	DPRINTK("CRT16: %ld\n", vtotal & 0xff);
+	DPRINTK("CRT16: %d\n", vtotal & 0xff);
 	vga_wcrt(regbase, VGA_CRTC_V_BLANK_END, vtotal & 0xff);
 
 	DPRINTK("CRT18: 0xff\n");
-- 
1.5.2.2


----------------------------------------------------------------------
Nie zwlekaj! Tapetuj z nami!
Sprawdz >>  http://link.interia.pl/f1f01


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
