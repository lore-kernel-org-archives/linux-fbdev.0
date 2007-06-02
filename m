From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 16/24] tgafb: Actually allocate memory
	for the pseudo_palette
Date: Sat, 02 Jun 2007 18:08:47 +0800
Message-ID: <466141AF.8060900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuS4T-0000T5-D6 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 04:47:01 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQjA-00011W-RO
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:20:57 -0700
Received: by py-out-1112.google.com with SMTP id u77so1508651pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:20:56 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Maciej W. Rozycki" <macro@linux-mips.org>

No memory allocation was done for the pseudo_palette.  Allocate one for it.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/tgafb.c |    2 +-
 include/video/tgafb.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
index f0fde6e..5c9cd6e 100644
--- a/drivers/video/tgafb.c
+++ b/drivers/video/tgafb.c
@@ -1635,7 +1635,7 @@ tgafb_register(struct device *dev)
 		      FBINFO_HWACCEL_IMAGEBLIT | FBINFO_HWACCEL_FILLRECT;
 	info->fbops = &tgafb_ops;
 	info->screen_base = par->tga_fb_base;
-	info->pseudo_palette = (void *)(par + 1);
+	info->pseudo_palette = par->palette;
 
 	/* This should give a reasonable default video mode.  */
 	if (tga_bus_pci) {
diff --git a/include/video/tgafb.h b/include/video/tgafb.h
index 03d0dbe..7bc5e2c 100644
--- a/include/video/tgafb.h
+++ b/include/video/tgafb.h
@@ -216,6 +216,7 @@ struct tga_par {
 	u32 pll_freq;			/* pixclock in mhz */
 	u32 bits_per_pixel;		/* bits per pixel */
 	u32 sync_on_green;		/* set if sync is on green */
+	u32 palette[16];
 };
 
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
