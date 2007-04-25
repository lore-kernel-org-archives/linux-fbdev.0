From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 41/41] nvidiafb: Prevent triggering of
	softlockup
Date: Wed, 25 Apr 2007 15:25:33 +0800
Message-ID: <462F026D.6000104@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcET-0001sK-7h for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:48:09 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcEQ-0007z9-7s
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:48:06 -0700
Received: by py-out-1112.google.com with SMTP id a29so117820pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:48:06 -0700 (PDT)
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
Cc: Dave Jones <davej@redhat.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Dave Jones <davej@redhat.com>

If the chip locks up, we get into a long polling loop,
where the softlockup detector kicks in.
See https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=151878
for an example.

[adaplas]
Chip lockup can occur at 3 points (flush, sync, and wait). Consolidate and
allow the driver to go to safe mode cleanly.

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/nvidia/nv_accel.c |   76 ++++++++++++++++++++++++---------------
 drivers/video/nvidia/nv_local.h |    4 +-
 2 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/drivers/video/nvidia/nv_accel.c b/drivers/video/nvidia/nv_accel.c
index 9efb8a3..fa4821c 100644
--- a/drivers/video/nvidia/nv_accel.c
+++ b/drivers/video/nvidia/nv_accel.c
@@ -69,27 +69,38 @@ static const int NVCopyROP_PM[16] = {
 	0x5A,			/* invert */
 };
 
-static inline void NVFlush(struct nvidia_par *par)
+static inline void nvidiafb_safe_mode(struct fb_info *info)
 {
+	struct nvidia_par *par = info->par;
+
+	touch_softlockup_watchdog();
+	info->pixmap.scan_align = 1;
+	par->lockup = 1;
+}
+
+static inline void NVFlush(struct fb_info *info)
+{
+	struct nvidia_par *par = info->par;
 	int count = 1000000000;
 
 	while (--count && READ_GET(par) != par->dmaPut) ;
 
 	if (!count) {
 		printk("nvidiafb: DMA Flush lockup\n");
-		par->lockup = 1;
+		nvidiafb_safe_mode(info);
 	}
 }
 
-static inline void NVSync(struct nvidia_par *par)
+static inline void NVSync(struct fb_info *info)
 {
+	struct nvidia_par *par = info->par;
 	int count = 1000000000;
 
 	while (--count && NV_RD32(par->PGRAPH, 0x0700)) ;
 
 	if (!count) {
 		printk("nvidiafb: DMA Sync lockup\n");
-		par->lockup = 1;
+		nvidiafb_safe_mode(info);
 	}
 }
 
@@ -101,8 +112,9 @@ static void NVDmaKickoff(struct nvidia_p
 	}
 }
 
-static void NVDmaWait(struct nvidia_par *par, int size)
+static void NVDmaWait(struct fb_info *info, int size)
 {
+	struct nvidia_par *par = info->par;
 	int dmaGet;
 	int count = 1000000000, cnt;
 	size++;
@@ -135,34 +147,38 @@ static void NVDmaWait(struct nvidia_par 
 	}
 
 	if (!count) {
-		printk("DMA Wait Lockup\n");
-		par->lockup = 1;
+		printk("nvidiafb: DMA Wait Lockup\n");
+		nvidiafb_safe_mode(info);
 	}
 }
 
-static void NVSetPattern(struct nvidia_par *par, u32 clr0, u32 clr1,
+static void NVSetPattern(struct fb_info *info, u32 clr0, u32 clr1,
 			 u32 pat0, u32 pat1)
 {
-	NVDmaStart(par, PATTERN_COLOR_0, 4);
+	struct nvidia_par *par = info->par;
+
+	NVDmaStart(info, par, PATTERN_COLOR_0, 4);
 	NVDmaNext(par, clr0);
 	NVDmaNext(par, clr1);
 	NVDmaNext(par, pat0);
 	NVDmaNext(par, pat1);
 }
 
-static void NVSetRopSolid(struct nvidia_par *par, u32 rop, u32 planemask)
+static void NVSetRopSolid(struct fb_info *info, u32 rop, u32 planemask)
 {
+	struct nvidia_par *par = info->par;
+
 	if (planemask != ~0) {
-		NVSetPattern(par, 0, planemask, ~0, ~0);
+		NVSetPattern(info, 0, planemask, ~0, ~0);
 		if (par->currentRop != (rop + 32)) {
-			NVDmaStart(par, ROP_SET, 1);
+			NVDmaStart(info, par, ROP_SET, 1);
 			NVDmaNext(par, NVCopyROP_PM[rop]);
 			par->currentRop = rop + 32;
 		}
 	} else if (par->currentRop != rop) {
 		if (par->currentRop >= 16)
-			NVSetPattern(par, ~0, ~0, ~0, ~0);
-		NVDmaStart(par, ROP_SET, 1);
+			NVSetPattern(info, ~0, ~0, ~0, ~0);
+		NVDmaStart(info, par, ROP_SET, 1);
 		NVDmaNext(par, NVCopyROP[rop]);
 		par->currentRop = rop;
 	}
@@ -175,7 +191,7 @@ static void NVSetClippingRectangle(struc
 	int h = y2 - y1 + 1;
 	int w = x2 - x1 + 1;
 
-	NVDmaStart(par, CLIP_POINT, 2);
+	NVDmaStart(info, par, CLIP_POINT, 2);
 	NVDmaNext(par, (y1 << 16) | x1);
 	NVDmaNext(par, (h << 16) | w);
 }
@@ -237,23 +253,23 @@ void NVResetGraphics(struct fb_info *inf
 		break;
 	}
 
-	NVDmaStart(par, SURFACE_FORMAT, 4);
+	NVDmaStart(info, par, SURFACE_FORMAT, 4);
 	NVDmaNext(par, surfaceFormat);
 	NVDmaNext(par, pitch | (pitch << 16));
 	NVDmaNext(par, 0);
 	NVDmaNext(par, 0);
 
-	NVDmaStart(par, PATTERN_FORMAT, 1);
+	NVDmaStart(info, par, PATTERN_FORMAT, 1);
 	NVDmaNext(par, patternFormat);
 
-	NVDmaStart(par, RECT_FORMAT, 1);
+	NVDmaStart(info, par, RECT_FORMAT, 1);
 	NVDmaNext(par, rectFormat);
 
-	NVDmaStart(par, LINE_FORMAT, 1);
+	NVDmaStart(info, par, LINE_FORMAT, 1);
 	NVDmaNext(par, lineFormat);
 
 	par->currentRop = ~0;	/* set to something invalid */
-	NVSetRopSolid(par, ROP_COPY, ~0);
+	NVSetRopSolid(info, ROP_COPY, ~0);
 
 	NVSetClippingRectangle(info, 0, 0, info->var.xres_virtual,
 			       info->var.yres_virtual);
@@ -269,10 +285,10 @@ int nvidiafb_sync(struct fb_info *info)
 		return 0;
 
 	if (!par->lockup)
-		NVFlush(par);
+		NVFlush(info);
 
 	if (!par->lockup)
-		NVSync(par);
+		NVSync(info);
 
 	return 0;
 }
@@ -287,7 +303,7 @@ void nvidiafb_copyarea(struct fb_info *i
 	if (par->lockup)
 		return cfb_copyarea(info, region);
 
-	NVDmaStart(par, BLIT_POINT_SRC, 3);
+	NVDmaStart(info, par, BLIT_POINT_SRC, 3);
 	NVDmaNext(par, (region->sy << 16) | region->sx);
 	NVDmaNext(par, (region->dy << 16) | region->dx);
 	NVDmaNext(par, (region->height << 16) | region->width);
@@ -312,19 +328,19 @@ void nvidiafb_fillrect(struct fb_info *i
 		color = ((u32 *) info->pseudo_palette)[rect->color];
 
 	if (rect->rop != ROP_COPY)
-		NVSetRopSolid(par, rect->rop, ~0);
+		NVSetRopSolid(info, rect->rop, ~0);
 
-	NVDmaStart(par, RECT_SOLID_COLOR, 1);
+	NVDmaStart(info, par, RECT_SOLID_COLOR, 1);
 	NVDmaNext(par, color);
 
-	NVDmaStart(par, RECT_SOLID_RECTS(0), 2);
+	NVDmaStart(info, par, RECT_SOLID_RECTS(0), 2);
 	NVDmaNext(par, (rect->dx << 16) | rect->dy);
 	NVDmaNext(par, (rect->width << 16) | rect->height);
 
 	NVDmaKickoff(par);
 
 	if (rect->rop != ROP_COPY)
-		NVSetRopSolid(par, ROP_COPY, ~0);
+		NVSetRopSolid(info, ROP_COPY, ~0);
 }
 
 static void nvidiafb_mono_color_expand(struct fb_info *info,
@@ -346,7 +362,7 @@ static void nvidiafb_mono_color_expand(s
 		bg = ((u32 *) info->pseudo_palette)[image->bg_color] | mask;
 	}
 
-	NVDmaStart(par, RECT_EXPAND_TWO_COLOR_CLIP, 7);
+	NVDmaStart(info, par, RECT_EXPAND_TWO_COLOR_CLIP, 7);
 	NVDmaNext(par, (image->dy << 16) | (image->dx & 0xffff));
 	NVDmaNext(par, ((image->dy + image->height) << 16) |
 		  ((image->dx + image->width) & 0xffff));
@@ -357,7 +373,7 @@ static void nvidiafb_mono_color_expand(s
 	NVDmaNext(par, (image->dy << 16) | (image->dx & 0xffff));
 
 	while (dsize >= RECT_EXPAND_TWO_COLOR_DATA_MAX_DWORDS) {
-		NVDmaStart(par, RECT_EXPAND_TWO_COLOR_DATA(0),
+		NVDmaStart(info, par, RECT_EXPAND_TWO_COLOR_DATA(0),
 			   RECT_EXPAND_TWO_COLOR_DATA_MAX_DWORDS);
 
 		for (j = RECT_EXPAND_TWO_COLOR_DATA_MAX_DWORDS; j--;) {
@@ -370,7 +386,7 @@ static void nvidiafb_mono_color_expand(s
 	}
 
 	if (dsize) {
-		NVDmaStart(par, RECT_EXPAND_TWO_COLOR_DATA(0), dsize);
+		NVDmaStart(info, par, RECT_EXPAND_TWO_COLOR_DATA(0), dsize);
 
 		for (j = dsize; j--;) {
 			tmp = data[k++];
diff --git a/drivers/video/nvidia/nv_local.h b/drivers/video/nvidia/nv_local.h
index e009d24..68e508d 100644
--- a/drivers/video/nvidia/nv_local.h
+++ b/drivers/video/nvidia/nv_local.h
@@ -73,9 +73,9 @@ #define VGA_RD08(p,i)   (readb((void __i
 #define NVDmaNext(par, data) \
      NV_WR32(&(par)->dmaBase[(par)->dmaCurrent++], 0, (data))
 
-#define NVDmaStart(par, tag, size) {          \
+#define NVDmaStart(info, par, tag, size) {    \
      if((par)->dmaFree <= (size))             \
-        NVDmaWait(par, size);                 \
+        NVDmaWait(info, size);                \
      NVDmaNext(par, ((size) << 18) | (tag));  \
      (par)->dmaFree -= ((size) + 1);          \
 }


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
