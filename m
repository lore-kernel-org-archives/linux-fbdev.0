From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [REPOST PATCH] gbefb: cmap FIFO timeout
Date: Wed, 30 Jul 2008 00:12:04 +0200 (CEST)
Message-ID: <20080729221204.25D97C2F34@solo.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KNxQW-0001fo-0A for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 15:12:16 -0700
Received: from elvis.franken.de ([193.175.24.41]
	ident=[ptRaN1jRzSl5NnE5py8uyJsxbe1aqEmP])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1KNxQU-0001td-Bk
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 15:12:15 -0700
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
Cc: linux-mips@linux-mips.org, akpm@linux-foundation.org, adaplas@gmail.com

Writes to the cmap fifo while the display is blanked caused cmap FIFO
timeout messages and a wrong colormap. To avoid this the driver now
maintains a colormap in memory and updates the colormap after the
display is unblanked.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

It would be really nice to get this bugfix into 2.6.27. It was posted
the first time 26. June 2008 and I didn't get any response at all.

 drivers/video/gbefb.c |   50 +++++++++++++++++++++++++++++++++---------------
 1 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index 2e552d5..f89c3cc 100644
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -87,6 +87,8 @@ static int gbe_revision;
 static int ypan, ywrap;
 
 static uint32_t pseudo_palette[16];
+static uint32_t gbe_cmap[256];
+static int gbe_turned_on; /* 0 turned off, 1 turned on */
 
 static char *mode_option __initdata = NULL;
 
@@ -208,6 +210,8 @@ void gbe_turn_off(void)
 	int i;
 	unsigned int val, x, y, vpixen_off;
 
+	gbe_turned_on = 0;
+
 	/* check if pixel counter is on */
 	val = gbe->vt_xy;
 	if (GET_GBE_FIELD(VT_XY, FREEZE, val) == 1)
@@ -371,6 +375,22 @@ static void gbe_turn_on(void)
 	}
 	if (i == 10000)
 		printk(KERN_ERR "gbefb: turn on DMA timed out\n");
+
+	gbe_turned_on = 1;
+}
+
+static void gbe_loadcmap(void)
+{
+	int i, j;
+
+	for (i = 0; i < 256; i++) {
+		for (j = 0; j < 1000 && gbe->cm_fifo >= 63; j++)
+			udelay(10);
+		if (j == 1000)
+			printk(KERN_ERR "gbefb: cmap FIFO timeout\n");
+
+		gbe->cmap[i] = gbe_cmap[i];
+	}
 }
 
 /*
@@ -382,6 +402,7 @@ static int gbefb_blank(int blank, struct fb_info *info)
 	switch (blank) {
 	case FB_BLANK_UNBLANK:		/* unblank */
 		gbe_turn_on();
+		gbe_loadcmap();
 		break;
 
 	case FB_BLANK_NORMAL:		/* blank */
@@ -796,16 +817,10 @@ static int gbefb_set_par(struct fb_info *info)
 		gbe->gmap[i] = (i << 24) | (i << 16) | (i << 8);
 
 	/* Initialize the color map */
-	for (i = 0; i < 256; i++) {
-		int j;
-
-		for (j = 0; j < 1000 && gbe->cm_fifo >= 63; j++)
-			udelay(10);
-		if (j == 1000)
-			printk(KERN_ERR "gbefb: cmap FIFO timeout\n");
+	for (i = 0; i < 256; i++)
+		gbe_cmap[i] = (i << 8) | (i << 16) | (i << 24);
 
-		gbe->cmap[i] = (i << 8) | (i << 16) | (i << 24);
-	}
+	gbe_loadcmap();
 
 	return 0;
 }
@@ -855,14 +870,17 @@ static int gbefb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	blue >>= 8;
 
 	if (info->var.bits_per_pixel <= 8) {
-		/* wait for the color map FIFO to have a free entry */
-		for (i = 0; i < 1000 && gbe->cm_fifo >= 63; i++)
-			udelay(10);
-		if (i == 1000) {
-			printk(KERN_ERR "gbefb: cmap FIFO timeout\n");
-			return 1;
+		gbe_cmap[regno] = (red << 24) | (green << 16) | (blue << 8);
+		if (gbe_turned_on) {
+			/* wait for the color map FIFO to have a free entry */
+			for (i = 0; i < 1000 && gbe->cm_fifo >= 63; i++)
+				udelay(10);
+			if (i == 1000) {
+				printk(KERN_ERR "gbefb: cmap FIFO timeout\n");
+				return 1;
+			}
+			gbe->cmap[regno] = gbe_cmap[regno];
 		}
-		gbe->cmap[regno] = (red << 24) | (green << 16) | (blue << 8);
 	} else if (regno < 16) {
 		switch (info->var.bits_per_pixel) {
 		case 15:

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
