From: Witold Filipczyk <witekfl@poczta.onet.pl>
Subject: aty128fb blank
Date: Thu, 15 Feb 2007 20:06:50 +0100
Message-ID: <20070215190650.GA12174@pldmachine>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHlu9-0006NA-Ar for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 11:04:29 -0800
Received: from smtp22.poczta.onet.pl ([213.180.130.93])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HHlu6-0001cc-3P
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 11:04:29 -0800
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi!
I have a problem with blanking. The soundcard uses speakers of the monitor.
Sound is muted when the screen blanks due to a bug in aty128fb.c.
Here is the patch:
--- linux-2.6.19/drivers/video/aty/aty128fb.c.old	2007-02-15 19:27:53.000000000 +0100
+++ linux-2.6.19/drivers/video/aty/aty128fb.c	2007-02-15 19:30:32.000000000 +0100
@@ -2204,7 +2204,7 @@
 static int aty128fb_blank(int blank, struct fb_info *fb)
 {
 	struct aty128fb_par *par = fb->par;
-	u8 state = 0;
+	u8 state;
 
 	if (par->lock_blank || par->asleep)
 		return 0;
@@ -2214,13 +2214,24 @@
 		aty128_bl_set_power(fb, FB_BLANK_POWERDOWN);
 #endif
 
-	if (blank & FB_BLANK_VSYNC_SUSPEND)
-		state |= 2;
-	if (blank & FB_BLANK_HSYNC_SUSPEND)
-		state |= 1;
-	if (blank & FB_BLANK_POWERDOWN)
-		state |= 4;
-
+	switch (blank) {
+	case FB_BLANK_NORMAL:
+		state = 4;
+		break;
+	case FB_BLANK_VSYNC_SUSPEND:
+		state = 6;
+		break;
+	case FB_BLANK_HSYNC_SUSPEND:
+		state = 5;
+		break;
+	case FB_BLANK_POWERDOWN:
+		state = 7;
+		break;
+	case FB_BLANK_UNBLANK:
+	default:
+		state = 0;
+		break;
+	}
 	aty_st_8(CRTC_EXT_CNTL+1, state);
 
 	if (par->chip_gen == rage_M3) {



Here is a fragment of linux/fb.h
/* VESA Blanking Levels */
#define VESA_NO_BLANKING        0
#define VESA_VSYNC_SUSPEND      1
#define VESA_HSYNC_SUSPEND      2
#define VESA_POWERDOWN          3


enum {
        /* screen: unblanked, hsync: on,  vsync: on */
        FB_BLANK_UNBLANK       = VESA_NO_BLANKING,

        /* screen: blanked,   hsync: on,  vsync: on */
        FB_BLANK_NORMAL        = VESA_NO_BLANKING + 1,

        /* screen: blanked,   hsync: on,  vsync: off */
        FB_BLANK_VSYNC_SUSPEND = VESA_VSYNC_SUSPEND + 1,

        /* screen: blanked,   hsync: off, vsync: on */
        FB_BLANK_HSYNC_SUSPEND = VESA_HSYNC_SUSPEND + 1,

        /* screen: blanked,   hsync: off, vsync: off */
        FB_BLANK_POWERDOWN     = VESA_POWERDOWN + 1
};

So FB_BLANK_NORMAL is 1, FB_BLANK_VSYNC_SUSPEND is 2,
FB_BLANK_HSYNC_SUSPEND is 3, FB_BLANK_POWERDOWN is 4.
And now:
blank = FB_BLANK_NORMAL (1)
blank & FB_BLANK_HSYNC_SUSPEND (1 & 3) is true,
so normal blank caused hsync suspend and sound is muted.
Sorry for my bad English, but I hope you got it.

The second patch is related to the first one:
--- linux-2.6.19/drivers/video/aty/aty128fb.c.stare	2007-01-28 19:42:52.000000000 +0100
+++ linux-2.6.19/drivers/video/aty/aty128fb.c	2007-01-28 19:45:43.000000000 +0100
@@ -2490,7 +2495,7 @@
 	wait_for_idle(par);
 
 	/* Blank display and LCD */
-	aty128fb_blank(VESA_POWERDOWN, info);
+	aty128fb_blank(FB_BLANK_POWERDOWN, info);
 
 	/* Sleep */
 	par->asleep = 1;
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
