From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/8] fbdev: Fix IO access in rivafb
Date: Tue, 2 Nov 2004 19:46:13 +0800
Message-ID: <200411021946.13999.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1COx7Z-0002iS-LV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 03:46:41 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1COx7Y-00056K-TW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 03:46:41 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 1DB40983782
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  2 Nov 2004 11:46:27 +0000 (UTC)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix IO access in rivafb:
- change NV_RD*/WR* macros to use read*/write* family
- use NV_RD*/WR* to access IO memory
- add __iomem annotations

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbdev.c   |   97 +++++-----
 riva_hw.c |  560 +++++++++++++++++++++++++++++++++-----------------------------
 riva_hw.h |   68 +++----
 rivafb.h  |    2
 4 files changed, 391 insertions(+), 336 deletions(-)

diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	2004-10-31 07:27:18 +08:00
+++ b/drivers/video/riva/fbdev.c	2004-10-31 16:57:08 +08:00
@@ -717,7 +717,7 @@
 		newmode.ext.interlace = 0xff; /* interlace off */
 
 	if (par->riva.Architecture >= NV_ARCH_10)
-		par->riva.CURSOR = (U032 *)(info->screen_base + par->riva.CursorStart);
+		par->riva.CURSOR = (U032 __iomem *)(info->screen_base + par->riva.CursorStart);
 
 	if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
 		newmode.misc_output &= ~0x40;
@@ -731,22 +731,27 @@
 	par->riva.CalcStateExt(&par->riva, &newmode.ext, bpp, width,
 				  hDisplaySize, height, dotClock);
 
-	newmode.ext.scale = par->riva.PRAMDAC[0x00000848/4] & 0xfff000ff;
+	newmode.ext.scale = NV_RD32(par->riva.PRAMDAC, 0x00000848) &
+		0xfff000ff;
 	if (par->FlatPanel == 1) {
 		newmode.ext.pixel |= (1 << 7);
 		newmode.ext.scale |= (1 << 8);
 	}
 	if (par->SecondCRTC) {
-		newmode.ext.head  = par->riva.PCRTC0[0x00000860/4] & ~0x00001000;
-		newmode.ext.head2 = par->riva.PCRTC0[0x00002860/4] | 0x00001000;
+		newmode.ext.head  = NV_RD32(par->riva.PCRTC0, 0x00000860) &
+			~0x00001000;
+		newmode.ext.head2 = NV_RD32(par->riva.PCRTC0, 0x00002860) |
+			0x00001000;
 		newmode.ext.crtcOwner = 3;
 		newmode.ext.pllsel |= 0x20000800;
 		newmode.ext.vpll2 = newmode.ext.vpll;
 	} else if (par->riva.twoHeads) {
-		newmode.ext.head  =  par->riva.PCRTC0[0x00000860/4] | 0x00001000;
-		newmode.ext.head2 =  par->riva.PCRTC0[0x00002860/4] & ~0x00001000;
+		newmode.ext.head  =  NV_RD32(par->riva.PCRTC0, 0x00000860) |
+			0x00001000;
+		newmode.ext.head2 =  NV_RD32(par->riva.PCRTC0, 0x00002860) &
+			~0x00001000;
 		newmode.ext.crtcOwner = 0;
-		newmode.ext.vpll2 = par->riva.PRAMDAC0[0x00000520/4];
+		newmode.ext.vpll2 = NV_RD32(par->riva.PRAMDAC0, 0x00000520);
 	}
 	if (par->FlatPanel == 1) {
 		newmode.ext.pixel |= (1 << 7);
@@ -887,10 +892,10 @@
 riva_set_pattern(struct riva_par *par, int clr0, int clr1, int pat0, int pat1)
 {
 	RIVA_FIFO_FREE(par->riva, Patt, 4);
-	par->riva.Patt->Color0        = clr0;
-	par->riva.Patt->Color1        = clr1;
-	par->riva.Patt->Monochrome[0] = pat0;
-	par->riva.Patt->Monochrome[1] = pat1;
+	NV_WR32(&par->riva.Patt->Color0, 0, clr0);
+	NV_WR32(&par->riva.Patt->Color1, 0, clr1);
+	NV_WR32(par->riva.Patt->Monochrome, 0, pat0);
+	NV_WR32(par->riva.Patt->Monochrome, 4, pat1);
 }
 
 /* acceleration routines */
@@ -907,7 +912,7 @@
 {
 	riva_set_pattern(par, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
         RIVA_FIFO_FREE(par->riva, Rop, 1);
-        par->riva.Rop->Rop3 = rop;
+        NV_WR32(&par->riva.Rop->Rop3, 0, rop);
 
 }
 
@@ -916,9 +921,10 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 
 	RIVA_FIFO_FREE(par->riva, Clip, 2);
-	par->riva.Clip->TopLeft     = 0x0;
-	par->riva.Clip->WidthHeight = (info->var.xres_virtual & 0xffff) |
-		(info->var.yres_virtual << 16);
+	NV_WR32(&par->riva.Clip->TopLeft, 0, 0x0);
+	NV_WR32(&par->riva.Clip->WidthHeight, 0,
+		(info->var.xres_virtual & 0xffff) |
+		(info->var.yres_virtual << 16));
 	riva_set_rop_solid(par, 0xcc);
 	wait_for_idle(par);
 }
@@ -1405,14 +1411,14 @@
 	riva_set_rop_solid(par, rop);
 
 	RIVA_FIFO_FREE(par->riva, Bitmap, 1);
-	par->riva.Bitmap->Color1A = color;
+	NV_WR32(&par->riva.Bitmap->Color1A, 0, color);
 
 	RIVA_FIFO_FREE(par->riva, Bitmap, 2);
-	par->riva.Bitmap->UnclippedRectangle[0].TopLeft =
-			(rect->dx << 16) | rect->dy;
+	NV_WR32(&par->riva.Bitmap->UnclippedRectangle[0].TopLeft, 0,
+		(rect->dx << 16) | rect->dy);
 	mb();
-	par->riva.Bitmap->UnclippedRectangle[0].WidthHeight =
-			(rect->width << 16) | rect->height;
+	NV_WR32(&par->riva.Bitmap->UnclippedRectangle[0].WidthHeight, 0,
+		(rect->width << 16) | rect->height);
 	mb();
 	riva_set_rop_solid(par, 0xcc);
 
@@ -1439,10 +1445,13 @@
 	}
 
 	RIVA_FIFO_FREE(par->riva, Blt, 3);
-	par->riva.Blt->TopLeftSrc  = (region->sy << 16) | region->sx;
-	par->riva.Blt->TopLeftDst  = (region->dy << 16) | region->dx;
+	NV_WR32(&par->riva.Blt->TopLeftSrc, 0,
+		(region->sy << 16) | region->sx);
+	NV_WR32(&par->riva.Blt->TopLeftDst, 0,
+		(region->dy << 16) | region->dx);
 	mb();
-	par->riva.Blt->WidthHeight = (region->height << 16) | region->width;
+	NV_WR32(&par->riva.Blt->WidthHeight, 0,
+		(region->height << 16) | region->width);
 	mb();
 }
 
@@ -1477,7 +1486,7 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 	u32 fgx = 0, bgx = 0, width, tmp;
 	u8 *cdat = (u8 *) image->data;
-	volatile u32 *d;
+	volatile u32 __iomem *d;
 	int i, size;
 
 	if ((info->flags & FBINFO_HWACCEL_DISABLED) || image->depth != 1) {
@@ -1505,19 +1514,19 @@
 	}
 
 	RIVA_FIFO_FREE(par->riva, Bitmap, 7);
-	par->riva.Bitmap->ClipE.TopLeft     = 
-		(image->dy << 16) | (image->dx & 0xFFFF);
-	par->riva.Bitmap->ClipE.BottomRight = 
+	NV_WR32(&par->riva.Bitmap->ClipE.TopLeft, 0,
+		(image->dy << 16) | (image->dx & 0xFFFF));
+	NV_WR32(&par->riva.Bitmap->ClipE.BottomRight, 0,
 		(((image->dy + image->height) << 16) |
-		 ((image->dx + image->width) & 0xffff));
-	par->riva.Bitmap->Color0E           = bgx;
-	par->riva.Bitmap->Color1E           = fgx;
-	par->riva.Bitmap->WidthHeightInE    = 
-		(image->height << 16) | ((image->width + 31) & ~31);
-	par->riva.Bitmap->WidthHeightOutE   = 
-		(image->height << 16) | ((image->width + 31) & ~31);
-	par->riva.Bitmap->PointE            = 
-		(image->dy << 16) | (image->dx & 0xFFFF);
+		 ((image->dx + image->width) & 0xffff)));
+	NV_WR32(&par->riva.Bitmap->Color0E, 0, bgx);
+	NV_WR32(&par->riva.Bitmap->Color1E, 0, fgx);
+	NV_WR32(&par->riva.Bitmap->WidthHeightInE, 0,
+		(image->height << 16) | ((image->width + 31) & ~31));
+	NV_WR32(&par->riva.Bitmap->WidthHeightOutE, 0,
+		(image->height << 16) | ((image->width + 31) & ~31));
+	NV_WR32(&par->riva.Bitmap->PointE, 0,
+		(image->dy << 16) | (image->dx & 0xFFFF));
 
 	d = &par->riva.Bitmap->MonochromeData01E;
 
@@ -1529,7 +1538,7 @@
 			tmp = *((u32 *)cdat);
 			cdat = (u8 *)((u32 *)cdat + 1);
 			reverse_order(&tmp);
-			d[i] = tmp;
+			NV_WR32(d, i*4, tmp);
 		}
 		size -= 16;
 	}
@@ -1539,7 +1548,7 @@
 			tmp = *((u32 *) cdat);
 			cdat = (u8 *)((u32 *)cdat + 1);
 			reverse_order(&tmp);
-			d[i] = tmp;
+			NV_WR32(d, i*4, tmp);
 		}
 	}
 }
@@ -1582,7 +1591,7 @@
 		temp = xx & 0xFFFF;
 		temp |= yy << 16;
 
-		par->riva.PRAMDAC[0x0000300/4] = temp;
+		NV_WR32(par->riva.PRAMDAC, 0x0000300, temp);
 	}
 
 
@@ -1960,8 +1969,10 @@
 	case NV_ARCH_10:
 	case NV_ARCH_20:
 	case NV_ARCH_30:
-		default_par->riva.PCRTC0 = (unsigned *)(default_par->ctrl_base + 0x00600000);
-		default_par->riva.PRAMIN = (unsigned *)(default_par->ctrl_base + 0x00710000);
+		default_par->riva.PCRTC0 =
+			(u32 __iomem *)(default_par->ctrl_base + 0x00600000);
+		default_par->riva.PRAMIN =
+			(u32 __iomem *)(default_par->ctrl_base + 0x00710000);
 		break;
 	}
 	riva_common_setup(default_par);
@@ -2037,7 +2048,7 @@
 	iounmap(info->screen_base);
 err_out_free_base1:
 	if (default_par->riva.Architecture == NV_ARCH_03) 
-		iounmap((caddr_t)default_par->riva.PRAMIN);
+		iounmap(default_par->riva.PRAMIN);
 err_out_free_nv3_pramin:
 	iounmap(default_par->ctrl_base);
 err_out_free_base0:
@@ -2077,7 +2088,7 @@
 	iounmap(par->ctrl_base);
 	iounmap(info->screen_base);
 	if (par->riva.Architecture == NV_ARCH_03)
-		iounmap((caddr_t)par->riva.PRAMIN);
+		iounmap(par->riva.PRAMIN);
 	pci_release_regions(pd);
 	pci_disable_device(pd);
 	kfree(info->pixmap.addr);
diff -Nru a/drivers/video/riva/riva_hw.c b/drivers/video/riva/riva_hw.c
--- a/drivers/video/riva/riva_hw.c	2004-10-31 07:27:18 +08:00
+++ b/drivers/video/riva/riva_hw.c	2004-10-31 16:57:08 +08:00
@@ -62,21 +62,24 @@
     RIVA_HW_INST *chip
 )
 {
-    return ((chip->Rop->FifoFree < chip->FifoEmptyCount) || (chip->PGRAPH[0x000006B0/4] & 0x01));
+    return ((NV_RD32(&chip->Rop->FifoFree, 0) < chip->FifoEmptyCount) ||
+	    NV_RD32(&chip->PGRAPH[0x000006B0/4], 0) & 0x01);
 }
 static int nv4Busy
 (
     RIVA_HW_INST *chip
 )
 {
-    return ((chip->Rop->FifoFree < chip->FifoEmptyCount) || (chip->PGRAPH[0x00000700/4] & 0x01));
+    return ((NV_RD32(&chip->Rop->FifoFree, 0) < chip->FifoEmptyCount) ||
+	    NV_RD32(&chip->PGRAPH[0x00000700/4], 0) & 0x01);
 }
 static int nv10Busy
 (
     RIVA_HW_INST *chip
 )
 {
-    return ((chip->Rop->FifoFree < chip->FifoEmptyCount) || (chip->PGRAPH[0x00000700/4] & 0x01));
+    return ((NV_RD32(&chip->Rop->FifoFree, 0) < chip->FifoEmptyCount) ||
+	    NV_RD32(&chip->PGRAPH[0x00000700/4], 0) & 0x01);
 }
 
 static void vgaLockUnlock
@@ -616,14 +619,15 @@
     nv3_sim_state sim_data;
     unsigned int M, N, P, pll, MClk;
     
-    pll = chip->PRAMDAC0[0x00000504/4]; 
+    pll = NV_RD32(&chip->PRAMDAC0[0x00000504/4], 0);
     M = (pll >> 0) & 0xFF; N = (pll >> 8) & 0xFF; P = (pll >> 16) & 0x0F;
     MClk = (N * chip->CrystalFreqKHz / M) >> P;
     sim_data.pix_bpp        = (char)pixelDepth;
     sim_data.enable_video   = 0;
     sim_data.enable_mp      = 0;
     sim_data.video_scale    = 1;
-    sim_data.memory_width   = (chip->PEXTDEV[0x00000000/4] & 0x10) ? 128 : 64;
+    sim_data.memory_width   = (NV_RD32(&chip->PEXTDEV[0x00000000/4], 0) & 0x10) ?
+	128 : 64;
     sim_data.memory_width   = 128;
 
     sim_data.mem_latency    = 9;
@@ -637,7 +641,10 @@
     {
         int  b = fifo_data.graphics_burst_size >> 4;
         *burst = 0;
-        while (b >>= 1) (*burst)++;
+        while (b) {
+	    (*burst)++;
+	    b >>= 1;
+	}
         *lwm   = fifo_data.graphics_lwm >> 3;
     }
     else
@@ -803,17 +810,18 @@
     nv4_sim_state sim_data;
     unsigned int M, N, P, pll, MClk, NVClk, cfg1;
 
-    pll = chip->PRAMDAC0[0x00000504/4];
+    pll = NV_RD32(&chip->PRAMDAC0[0x00000504/4], 0);
     M = (pll >> 0)  & 0xFF; N = (pll >> 8)  & 0xFF; P = (pll >> 16) & 0x0F;
     MClk  = (N * chip->CrystalFreqKHz / M) >> P;
-    pll = chip->PRAMDAC0[0x00000500/4];
+    pll = NV_RD32(&chip->PRAMDAC0[0x00000500/4], 0);
     M = (pll >> 0)  & 0xFF; N = (pll >> 8)  & 0xFF; P = (pll >> 16) & 0x0F;
     NVClk  = (N * chip->CrystalFreqKHz / M) >> P;
-    cfg1 = chip->PFB[0x00000204/4];
+    cfg1 = NV_RD32(&chip->PFB[0x00000204/4], 0);
     sim_data.pix_bpp        = (char)pixelDepth;
     sim_data.enable_video   = 0;
     sim_data.enable_mp      = 0;
-    sim_data.memory_width   = (chip->PEXTDEV[0x00000000/4] & 0x10) ? 128 : 64;
+    sim_data.memory_width   = (NV_RD32(&chip->PEXTDEV[0x00000000/4], 0) & 0x10) ?
+	128 : 64;
     sim_data.mem_latency    = (char)cfg1 & 0x0F;
     sim_data.mem_aligned    = 1;
     sim_data.mem_page_miss  = (char)(((cfg1 >> 4) &0x0F) + ((cfg1 >> 31) & 0x01));
@@ -826,7 +834,10 @@
     {
         int  b = fifo_data.graphics_burst_size >> 4;
         *burst = 0;
-        while (b >>= 1) (*burst)++;
+        while (b) {
+	    (*burst)++;
+	    b >>= 1;
+	}
         *lwm   = fifo_data.graphics_lwm >> 3;
     }
 }
@@ -1064,18 +1075,20 @@
     nv10_sim_state sim_data;
     unsigned int M, N, P, pll, MClk, NVClk, cfg1;
 
-    pll = chip->PRAMDAC0[0x00000504/4];
+    pll = NV_RD32(&chip->PRAMDAC0[0x00000504/4], 0);
     M = (pll >> 0)  & 0xFF; N = (pll >> 8)  & 0xFF; P = (pll >> 16) & 0x0F;
     MClk  = (N * chip->CrystalFreqKHz / M) >> P;
-    pll = chip->PRAMDAC0[0x00000500/4];
+    pll = NV_RD32(&chip->PRAMDAC0[0x00000500/4], 0);
     M = (pll >> 0)  & 0xFF; N = (pll >> 8)  & 0xFF; P = (pll >> 16) & 0x0F;
     NVClk  = (N * chip->CrystalFreqKHz / M) >> P;
-    cfg1 = chip->PFB[0x00000204/4];
+    cfg1 = NV_RD32(&chip->PFB[0x00000204/4], 0);
     sim_data.pix_bpp        = (char)pixelDepth;
     sim_data.enable_video   = 0;
     sim_data.enable_mp      = 0;
-    sim_data.memory_type    = (chip->PFB[0x00000200/4] & 0x01) ? 1 : 0;
-    sim_data.memory_width   = (chip->PEXTDEV[0x00000000/4] & 0x10) ? 128 : 64;
+    sim_data.memory_type    = (NV_RD32(&chip->PFB[0x00000200/4], 0) & 0x01) ?
+	1 : 0;
+    sim_data.memory_width   = (NV_RD32(&chip->PEXTDEV[0x00000000/4], 0) & 0x10) ?
+	128 : 64;
     sim_data.mem_latency    = (char)cfg1 & 0x0F;
     sim_data.mem_aligned    = 1;
     sim_data.mem_page_miss  = (char)(((cfg1 >> 4) &0x0F) + ((cfg1 >> 31) & 0x01));
@@ -1088,7 +1101,10 @@
     {
         int  b = fifo_data.graphics_burst_size >> 4;
         *burst = 0;
-        while (b >>= 1) (*burst)++;
+        while (b) {
+	    (*burst)++;
+	    b >>= 1;
+	}
         *lwm   = fifo_data.graphics_lwm >> 3;
     }
 }
@@ -1115,7 +1131,7 @@
     if(!uMClkPostDiv) uMClkPostDiv = 4;
     MClk = 400000 / uMClkPostDiv;
 
-    pll = chip->PRAMDAC0[0x00000500/4];
+    pll = NV_RD32(&chip->PRAMDAC0[0x00000500/4], 0);
     M = (pll >> 0)  & 0xFF; N = (pll >> 8)  & 0xFF; P = (pll >> 16) & 0x0F;
     NVClk  = (N * chip->CrystalFreqKHz / M) >> P;
     sim_data.pix_bpp        = (char)pixelDepth;
@@ -1139,7 +1155,10 @@
     {
         int  b = fifo_data.graphics_burst_size >> 4;
         *burst = 0;
-        while (b >>= 1) (*burst)++;
+        while (b) {
+	    (*burst)++;
+	    b >>= 1;
+	}
         *lwm   = fifo_data.graphics_lwm >> 3;
     }
 }
@@ -1294,7 +1313,7 @@
             state->cursor1  = (chip->CursorStart >> 11) << 2;
             state->cursor2  = chip->CursorStart >> 24;
             state->pllsel   = 0x10000700;
-            state->config   = chip->PFB[0x00000200/4];
+            state->config   = NV_RD32(&chip->PFB[0x00000200/4], 0);
             state->general  = bpp == 16 ? 0x00101100 : 0x00100100;
             state->repaint1 = hDisplaySize < 1280 ? 0x04 : 0x00;
             break;
@@ -1320,6 +1339,7 @@
 /*
  * Load fixed function state and pre-calculated/stored state.
  */
+#if 0
 #define LOAD_FIXED_STATE(tbl,dev)                                       \
     for (i = 0; i < sizeof(tbl##Table##dev)/8; i++)                 \
         chip->dev[tbl##Table##dev[i][0]] = tbl##Table##dev[i][1]
@@ -1335,6 +1355,24 @@
 #define LOAD_FIXED_STATE_32BPP(tbl,dev)                                 \
     for (i = 0; i < sizeof(tbl##Table##dev##_32BPP)/8; i++)           \
         chip->dev[tbl##Table##dev##_32BPP[i][0]] = tbl##Table##dev##_32BPP[i][1]
+#endif
+
+#define LOAD_FIXED_STATE(tbl,dev)                                       \
+    for (i = 0; i < sizeof(tbl##Table##dev)/8; i++)                 \
+        NV_WR32(&chip->dev[tbl##Table##dev[i][0]], 0, tbl##Table##dev[i][1])
+#define LOAD_FIXED_STATE_8BPP(tbl,dev)                                  \
+    for (i = 0; i < sizeof(tbl##Table##dev##_8BPP)/8; i++)            \
+        NV_WR32(&chip->dev[tbl##Table##dev##_8BPP[i][0]], 0, tbl##Table##dev##_8BPP[i][1])
+#define LOAD_FIXED_STATE_15BPP(tbl,dev)                                 \
+    for (i = 0; i < sizeof(tbl##Table##dev##_15BPP)/8; i++)           \
+        NV_WR32(&chip->dev[tbl##Table##dev##_15BPP[i][0]], 0, tbl##Table##dev##_15BPP[i][1])
+#define LOAD_FIXED_STATE_16BPP(tbl,dev)                                 \
+    for (i = 0; i < sizeof(tbl##Table##dev##_16BPP)/8; i++)           \
+        NV_WR32(&chip->dev[tbl##Table##dev##_16BPP[i][0]], 0, tbl##Table##dev##_16BPP[i][1])
+#define LOAD_FIXED_STATE_32BPP(tbl,dev)                                 \
+    for (i = 0; i < sizeof(tbl##Table##dev##_32BPP)/8; i++)           \
+        NV_WR32(&chip->dev[tbl##Table##dev##_32BPP[i][0]], 0, tbl##Table##dev##_32BPP[i][1])
+
 static void UpdateFifoState
 (
     RIVA_HW_INST  *chip
@@ -1347,7 +1385,7 @@
         case NV_ARCH_04:
             LOAD_FIXED_STATE(nv4,FIFO);
             chip->Tri03 = NULL;
-            chip->Tri05 = (RivaTexturedTriangle05 *)&(chip->FIFO[0x0000E000/4]);
+            chip->Tri05 = (RivaTexturedTriangle05 __iomem *)&(chip->FIFO[0x0000E000/4]);
             break;
         case NV_ARCH_10:
         case NV_ARCH_20:
@@ -1358,7 +1396,7 @@
             LOAD_FIXED_STATE(nv10tri05,PGRAPH);
             LOAD_FIXED_STATE(nv10,FIFO);
             chip->Tri03 = NULL;
-            chip->Tri05 = (RivaTexturedTriangle05 *)&(chip->FIFO[0x0000E000/4]);
+            chip->Tri05 = (RivaTexturedTriangle05 __iomem *)&(chip->FIFO[0x0000E000/4]);
             break;
     }
 }
@@ -1381,7 +1419,7 @@
             /*
              * Make sure frame buffer config gets set before loading PRAMIN.
              */
-            chip->PFB[0x00000200/4] = state->config;
+            NV_WR32(chip->PFB, 0x00000200, state->config);
             LOAD_FIXED_STATE(nv3,PFIFO);
             LOAD_FIXED_STATE(nv3,PRAMIN);
             LOAD_FIXED_STATE(nv3,PGRAPH);
@@ -1391,7 +1429,7 @@
                 case 16:
                     LOAD_FIXED_STATE_15BPP(nv3,PRAMIN);
                     LOAD_FIXED_STATE_15BPP(nv3,PGRAPH);
-                    chip->Tri03 = (RivaTexturedTriangle03  *)&(chip->FIFO[0x0000E000/4]);
+                    chip->Tri03 = (RivaTexturedTriangle03  __iomem *)&(chip->FIFO[0x0000E000/4]);
                     break;
                 case 24:
                 case 32:
@@ -1407,21 +1445,21 @@
                     break;
             }
             for (i = 0x00000; i < 0x00800; i++)
-                chip->PRAMIN[0x00000502 + i] = (i << 12) | 0x03;
-            chip->PGRAPH[0x00000630/4] = state->offset0;
-            chip->PGRAPH[0x00000634/4] = state->offset1;
-            chip->PGRAPH[0x00000638/4] = state->offset2;
-            chip->PGRAPH[0x0000063C/4] = state->offset3;
-            chip->PGRAPH[0x00000650/4] = state->pitch0;
-            chip->PGRAPH[0x00000654/4] = state->pitch1;
-            chip->PGRAPH[0x00000658/4] = state->pitch2;
-            chip->PGRAPH[0x0000065C/4] = state->pitch3;
+                NV_WR32(&chip->PRAMIN[0x00000502 + i], 0, (i << 12) | 0x03);
+            NV_WR32(chip->PGRAPH, 0x00000630, state->offset0);
+            NV_WR32(chip->PGRAPH, 0x00000634, state->offset1);
+            NV_WR32(chip->PGRAPH, 0x00000638, state->offset2);
+            NV_WR32(chip->PGRAPH, 0x0000063C, state->offset3);
+            NV_WR32(chip->PGRAPH, 0x00000650, state->pitch0);
+            NV_WR32(chip->PGRAPH, 0x00000654, state->pitch1);
+            NV_WR32(chip->PGRAPH, 0x00000658, state->pitch2);
+            NV_WR32(chip->PGRAPH, 0x0000065C, state->pitch3);
             break;
         case NV_ARCH_04:
             /*
              * Make sure frame buffer config gets set before loading PRAMIN.
              */
-            chip->PFB[0x00000200/4] = state->config;
+            NV_WR32(chip->PFB, 0x00000200, state->config);
             LOAD_FIXED_STATE(nv4,PFIFO);
             LOAD_FIXED_STATE(nv4,PRAMIN);
             LOAD_FIXED_STATE(nv4,PGRAPH);
@@ -1430,12 +1468,12 @@
                 case 15:
                     LOAD_FIXED_STATE_15BPP(nv4,PRAMIN);
                     LOAD_FIXED_STATE_15BPP(nv4,PGRAPH);
-                    chip->Tri03 = (RivaTexturedTriangle03  *)&(chip->FIFO[0x0000E000/4]);
+                    chip->Tri03 = (RivaTexturedTriangle03  __iomem *)&(chip->FIFO[0x0000E000/4]);
                     break;
                 case 16:
                     LOAD_FIXED_STATE_16BPP(nv4,PRAMIN);
                     LOAD_FIXED_STATE_16BPP(nv4,PGRAPH);
-                    chip->Tri03 = (RivaTexturedTriangle03  *)&(chip->FIFO[0x0000E000/4]);
+                    chip->Tri03 = (RivaTexturedTriangle03  __iomem *)&(chip->FIFO[0x0000E000/4]);
                     break;
                 case 24:
                 case 32:
@@ -1450,14 +1488,14 @@
                     chip->Tri03 = NULL;
                     break;
             }
-            chip->PGRAPH[0x00000640/4] = state->offset0;
-            chip->PGRAPH[0x00000644/4] = state->offset1;
-            chip->PGRAPH[0x00000648/4] = state->offset2;
-            chip->PGRAPH[0x0000064C/4] = state->offset3;
-            chip->PGRAPH[0x00000670/4] = state->pitch0;
-            chip->PGRAPH[0x00000674/4] = state->pitch1;
-            chip->PGRAPH[0x00000678/4] = state->pitch2;
-            chip->PGRAPH[0x0000067C/4] = state->pitch3;
+            NV_WR32(chip->PGRAPH, 0x00000640, state->offset0);
+            NV_WR32(chip->PGRAPH, 0x00000644, state->offset1);
+            NV_WR32(chip->PGRAPH, 0x00000648, state->offset2);
+            NV_WR32(chip->PGRAPH, 0x0000064C, state->offset3);
+            NV_WR32(chip->PGRAPH, 0x00000670, state->pitch0);
+            NV_WR32(chip->PGRAPH, 0x00000674, state->pitch1);
+            NV_WR32(chip->PGRAPH, 0x00000678, state->pitch2);
+            NV_WR32(chip->PGRAPH, 0x0000067C, state->pitch3);
             break;
         case NV_ARCH_10:
         case NV_ARCH_20:
@@ -1476,12 +1514,12 @@
                 case 15:
                     LOAD_FIXED_STATE_15BPP(nv10,PRAMIN);
                     LOAD_FIXED_STATE_15BPP(nv10,PGRAPH);
-                    chip->Tri03 = (RivaTexturedTriangle03  *)&(chip->FIFO[0x0000E000/4]);
+                    chip->Tri03 = (RivaTexturedTriangle03  __iomem *)&(chip->FIFO[0x0000E000/4]);
                     break;
                 case 16:
                     LOAD_FIXED_STATE_16BPP(nv10,PRAMIN);
                     LOAD_FIXED_STATE_16BPP(nv10,PGRAPH);
-                    chip->Tri03 = (RivaTexturedTriangle03  *)&(chip->FIFO[0x0000E000/4]);
+                    chip->Tri03 = (RivaTexturedTriangle03  __iomem *)&(chip->FIFO[0x0000E000/4]);
                     break;
                 case 24:
                 case 32:
@@ -1498,134 +1536,134 @@
             }
 
             if(chip->Architecture == NV_ARCH_10) {
-                chip->PGRAPH[0x00000640/4] = state->offset0;
-                chip->PGRAPH[0x00000644/4] = state->offset1;
-                chip->PGRAPH[0x00000648/4] = state->offset2;
-                chip->PGRAPH[0x0000064C/4] = state->offset3;
-                chip->PGRAPH[0x00000670/4] = state->pitch0;
-                chip->PGRAPH[0x00000674/4] = state->pitch1;
-                chip->PGRAPH[0x00000678/4] = state->pitch2;
-                chip->PGRAPH[0x0000067C/4] = state->pitch3;
-                chip->PGRAPH[0x00000680/4] = state->pitch3;
+                NV_WR32(chip->PGRAPH, 0x00000640, state->offset0);
+                NV_WR32(chip->PGRAPH, 0x00000644, state->offset1);
+                NV_WR32(chip->PGRAPH, 0x00000648, state->offset2);
+                NV_WR32(chip->PGRAPH, 0x0000064C, state->offset3);
+                NV_WR32(chip->PGRAPH, 0x00000670, state->pitch0);
+                NV_WR32(chip->PGRAPH, 0x00000674, state->pitch1);
+                NV_WR32(chip->PGRAPH, 0x00000678, state->pitch2);
+                NV_WR32(chip->PGRAPH, 0x0000067C, state->pitch3);
+                NV_WR32(chip->PGRAPH, 0x00000680, state->pitch3);
         } else {
-        chip->PGRAPH[0x00000820/4] = state->offset0;
-        chip->PGRAPH[0x00000824/4] = state->offset1;
-        chip->PGRAPH[0x00000828/4] = state->offset2;
-        chip->PGRAPH[0x0000082C/4] = state->offset3;
-        chip->PGRAPH[0x00000850/4] = state->pitch0;
-        chip->PGRAPH[0x00000854/4] = state->pitch1;
-        chip->PGRAPH[0x00000858/4] = state->pitch2;
-        chip->PGRAPH[0x0000085C/4] = state->pitch3;
-        chip->PGRAPH[0x00000860/4] = state->pitch3;
-        chip->PGRAPH[0x00000864/4] = state->pitch3;
-        chip->PGRAPH[0x000009A4/4] = chip->PFB[0x00000200/4];
-        chip->PGRAPH[0x000009A8/4] = chip->PFB[0x00000204/4];
+        NV_WR32(chip->PGRAPH, 0x00000820, state->offset0);
+        NV_WR32(chip->PGRAPH, 0x00000824, state->offset1);
+        NV_WR32(chip->PGRAPH, 0x00000828, state->offset2);
+        NV_WR32(chip->PGRAPH, 0x0000082C, state->offset3);
+        NV_WR32(chip->PGRAPH, 0x00000850, state->pitch0);
+        NV_WR32(chip->PGRAPH, 0x00000854, state->pitch1);
+        NV_WR32(chip->PGRAPH, 0x00000858, state->pitch2);
+        NV_WR32(chip->PGRAPH, 0x0000085C, state->pitch3);
+        NV_WR32(chip->PGRAPH, 0x00000860, state->pitch3);
+        NV_WR32(chip->PGRAPH, 0x00000864, state->pitch3);
+        NV_WR32(chip->PGRAPH, 0x000009A, NV_RD32(chip->PFB, 0x00000200));
+        NV_WR32(chip->PGRAPH, 0x000009A8, NV_RD32(chip->PFB, 0x00000204));
         }
             if(chip->twoHeads) {
-               chip->PCRTC0[0x00000860/4] = state->head;
-               chip->PCRTC0[0x00002860/4] = state->head2;
+               NV_WR32(chip->PCRTC0, 0x00000860, state->head);
+               NV_WR32(chip->PCRTC0, 0x00002860, state->head2);
             }
-            chip->PRAMDAC[0x00000404/4] |= (1 << 25);
+            NV_WR32(chip->PRAMDAC, 0x00000404, NV_RD32(chip->PRAMDAC, 0x00000404) | (1 << 25));
 
-            chip->PMC[0x00008704/4] = 1;
-            chip->PMC[0x00008140/4] = 0;
-            chip->PMC[0x00008920/4] = 0;
-            chip->PMC[0x00008924/4] = 0;
-            chip->PMC[0x00008908/4] = 0x01ffffff;
-            chip->PMC[0x0000890C/4] = 0x01ffffff;
-            chip->PMC[0x00001588/4] = 0;
-
-            chip->PFB[0x00000240/4] = 0;
-            chip->PFB[0x00000250/4] = 0;
-            chip->PFB[0x00000260/4] = 0;
-            chip->PFB[0x00000270/4] = 0;
-            chip->PFB[0x00000280/4] = 0;
-            chip->PFB[0x00000290/4] = 0;
-            chip->PFB[0x000002A0/4] = 0;
-            chip->PFB[0x000002B0/4] = 0;
-
-            chip->PGRAPH[0x00000B00/4] = chip->PFB[0x00000240/4];
-            chip->PGRAPH[0x00000B04/4] = chip->PFB[0x00000244/4];
-            chip->PGRAPH[0x00000B08/4] = chip->PFB[0x00000248/4];
-            chip->PGRAPH[0x00000B0C/4] = chip->PFB[0x0000024C/4];
-            chip->PGRAPH[0x00000B10/4] = chip->PFB[0x00000250/4];
-            chip->PGRAPH[0x00000B14/4] = chip->PFB[0x00000254/4];
-            chip->PGRAPH[0x00000B18/4] = chip->PFB[0x00000258/4];
-            chip->PGRAPH[0x00000B1C/4] = chip->PFB[0x0000025C/4];
-            chip->PGRAPH[0x00000B20/4] = chip->PFB[0x00000260/4];
-            chip->PGRAPH[0x00000B24/4] = chip->PFB[0x00000264/4];
-            chip->PGRAPH[0x00000B28/4] = chip->PFB[0x00000268/4];
-            chip->PGRAPH[0x00000B2C/4] = chip->PFB[0x0000026C/4];
-            chip->PGRAPH[0x00000B30/4] = chip->PFB[0x00000270/4];
-            chip->PGRAPH[0x00000B34/4] = chip->PFB[0x00000274/4];
-            chip->PGRAPH[0x00000B38/4] = chip->PFB[0x00000278/4];
-            chip->PGRAPH[0x00000B3C/4] = chip->PFB[0x0000027C/4];
-            chip->PGRAPH[0x00000B40/4] = chip->PFB[0x00000280/4];
-            chip->PGRAPH[0x00000B44/4] = chip->PFB[0x00000284/4];
-            chip->PGRAPH[0x00000B48/4] = chip->PFB[0x00000288/4];
-            chip->PGRAPH[0x00000B4C/4] = chip->PFB[0x0000028C/4];
-            chip->PGRAPH[0x00000B50/4] = chip->PFB[0x00000290/4];
-            chip->PGRAPH[0x00000B54/4] = chip->PFB[0x00000294/4];
-            chip->PGRAPH[0x00000B58/4] = chip->PFB[0x00000298/4];
-            chip->PGRAPH[0x00000B5C/4] = chip->PFB[0x0000029C/4];
-            chip->PGRAPH[0x00000B60/4] = chip->PFB[0x000002A0/4];
-            chip->PGRAPH[0x00000B64/4] = chip->PFB[0x000002A4/4];
-            chip->PGRAPH[0x00000B68/4] = chip->PFB[0x000002A8/4];
-            chip->PGRAPH[0x00000B6C/4] = chip->PFB[0x000002AC/4];
-            chip->PGRAPH[0x00000B70/4] = chip->PFB[0x000002B0/4];
-            chip->PGRAPH[0x00000B74/4] = chip->PFB[0x000002B4/4];
-            chip->PGRAPH[0x00000B78/4] = chip->PFB[0x000002B8/4];
-            chip->PGRAPH[0x00000B7C/4] = chip->PFB[0x000002BC/4];
-            chip->PGRAPH[0x00000F40/4] = 0x10000000;
-            chip->PGRAPH[0x00000F44/4] = 0x00000000;
-            chip->PGRAPH[0x00000F50/4] = 0x00000040;
-            chip->PGRAPH[0x00000F54/4] = 0x00000008;
-            chip->PGRAPH[0x00000F50/4] = 0x00000200;
+            NV_WR32(chip->PMC, 0x00008704, 1);
+            NV_WR32(chip->PMC, 0x00008140, 0);
+            NV_WR32(chip->PMC, 0x00008920, 0);
+            NV_WR32(chip->PMC, 0x00008924, 0);
+            NV_WR32(chip->PMC, 0x00008908, 0x01ffffff);
+            NV_WR32(chip->PMC, 0x0000890C, 0x01ffffff);
+            NV_WR32(chip->PMC, 0x00001588, 0);
+
+            NV_WR32(chip->PFB, 0x00000240, 0);
+            NV_WR32(chip->PFB, 0x00000250, 0);
+            NV_WR32(chip->PFB, 0x00000260, 0);
+            NV_WR32(chip->PFB, 0x00000270, 0);
+            NV_WR32(chip->PFB, 0x00000280, 0);
+            NV_WR32(chip->PFB, 0x00000290, 0);
+            NV_WR32(chip->PFB, 0x000002A0, 0);
+            NV_WR32(chip->PFB, 0x000002B0, 0);
+
+            NV_WR32(chip->PGRAPH, 0x00000B00, NV_RD32(chip->PFB, 0x00000240));
+            NV_WR32(chip->PGRAPH, 0x00000B04, NV_RD32(chip->PFB, 0x00000244));
+            NV_WR32(chip->PGRAPH, 0x00000B08, NV_RD32(chip->PFB, 0x00000248));
+            NV_WR32(chip->PGRAPH, 0x00000B0C, NV_RD32(chip->PFB, 0x0000024C));
+            NV_WR32(chip->PGRAPH, 0x00000B10, NV_RD32(chip->PFB, 0x00000250));
+            NV_WR32(chip->PGRAPH, 0x00000B14, NV_RD32(chip->PFB, 0x00000254));
+            NV_WR32(chip->PGRAPH, 0x00000B18, NV_RD32(chip->PFB, 0x00000258));
+            NV_WR32(chip->PGRAPH, 0x00000B1C, NV_RD32(chip->PFB, 0x0000025C));
+            NV_WR32(chip->PGRAPH, 0x00000B20, NV_RD32(chip->PFB, 0x00000260));
+            NV_WR32(chip->PGRAPH, 0x00000B24, NV_RD32(chip->PFB, 0x00000264));
+            NV_WR32(chip->PGRAPH, 0x00000B28, NV_RD32(chip->PFB, 0x00000268));
+            NV_WR32(chip->PGRAPH, 0x00000B2C, NV_RD32(chip->PFB, 0x0000026C));
+            NV_WR32(chip->PGRAPH, 0x00000B30, NV_RD32(chip->PFB, 0x00000270));
+            NV_WR32(chip->PGRAPH, 0x00000B34, NV_RD32(chip->PFB, 0x00000274));
+            NV_WR32(chip->PGRAPH, 0x00000B38, NV_RD32(chip->PFB, 0x00000278));
+            NV_WR32(chip->PGRAPH, 0x00000B3C, NV_RD32(chip->PFB, 0x0000027C));
+            NV_WR32(chip->PGRAPH, 0x00000B40, NV_RD32(chip->PFB, 0x00000280));
+            NV_WR32(chip->PGRAPH, 0x00000B44, NV_RD32(chip->PFB, 0x00000284));
+            NV_WR32(chip->PGRAPH, 0x00000B48, NV_RD32(chip->PFB, 0x00000288));
+            NV_WR32(chip->PGRAPH, 0x00000B4C, NV_RD32(chip->PFB, 0x0000028C));
+            NV_WR32(chip->PGRAPH, 0x00000B50, NV_RD32(chip->PFB, 0x00000290));
+            NV_WR32(chip->PGRAPH, 0x00000B54, NV_RD32(chip->PFB, 0x00000294));
+            NV_WR32(chip->PGRAPH, 0x00000B58, NV_RD32(chip->PFB, 0x00000298));
+            NV_WR32(chip->PGRAPH, 0x00000B5C, NV_RD32(chip->PFB, 0x0000029C));
+            NV_WR32(chip->PGRAPH, 0x00000B60, NV_RD32(chip->PFB, 0x000002A0));
+            NV_WR32(chip->PGRAPH, 0x00000B64, NV_RD32(chip->PFB, 0x000002A4));
+            NV_WR32(chip->PGRAPH, 0x00000B68, NV_RD32(chip->PFB, 0x000002A8));
+            NV_WR32(chip->PGRAPH, 0x00000B6C, NV_RD32(chip->PFB, 0x000002AC));
+            NV_WR32(chip->PGRAPH, 0x00000B70, NV_RD32(chip->PFB, 0x000002B0));
+            NV_WR32(chip->PGRAPH, 0x00000B74, NV_RD32(chip->PFB, 0x000002B4));
+            NV_WR32(chip->PGRAPH, 0x00000B78, NV_RD32(chip->PFB, 0x000002B8));
+            NV_WR32(chip->PGRAPH, 0x00000B7C, NV_RD32(chip->PFB, 0x000002BC));
+            NV_WR32(chip->PGRAPH, 0x00000F40, 0x10000000);
+            NV_WR32(chip->PGRAPH, 0x00000F44, 0x00000000);
+            NV_WR32(chip->PGRAPH, 0x00000F50, 0x00000040);
+            NV_WR32(chip->PGRAPH, 0x00000F54, 0x00000008);
+            NV_WR32(chip->PGRAPH, 0x00000F50, 0x00000200);
             for (i = 0; i < (3*16); i++)
-                chip->PGRAPH[0x00000F54/4] = 0x00000000;
-            chip->PGRAPH[0x00000F50/4] = 0x00000040;
-            chip->PGRAPH[0x00000F54/4] = 0x00000000;
-            chip->PGRAPH[0x00000F50/4] = 0x00000800;
+                NV_WR32(chip->PGRAPH, 0x00000F54, 0x00000000);
+            NV_WR32(chip->PGRAPH, 0x00000F50, 0x00000040);
+            NV_WR32(chip->PGRAPH, 0x00000F54, 0x00000000);
+            NV_WR32(chip->PGRAPH, 0x00000F50, 0x00000800);
             for (i = 0; i < (16*16); i++)
-                chip->PGRAPH[0x00000F54/4] = 0x00000000;
-            chip->PGRAPH[0x00000F40/4] = 0x30000000;
-            chip->PGRAPH[0x00000F44/4] = 0x00000004;
-            chip->PGRAPH[0x00000F50/4] = 0x00006400;
+                NV_WR32(chip->PGRAPH, 0x00000F54, 0x00000000);
+            NV_WR32(chip->PGRAPH, 0x00000F40, 0x30000000);
+            NV_WR32(chip->PGRAPH, 0x00000F44, 0x00000004);
+            NV_WR32(chip->PGRAPH, 0x00000F50, 0x00006400);
             for (i = 0; i < (59*4); i++)
-                chip->PGRAPH[0x00000F54/4] = 0x00000000;
-            chip->PGRAPH[0x00000F50/4] = 0x00006800;
+                NV_WR32(chip->PGRAPH, 0x00000F54, 0x00000000);
+            NV_WR32(chip->PGRAPH, 0x00000F50, 0x00006800);
             for (i = 0; i < (47*4); i++)
-                chip->PGRAPH[0x00000F54/4] = 0x00000000;
-            chip->PGRAPH[0x00000F50/4] = 0x00006C00;
+                NV_WR32(chip->PGRAPH, 0x00000F54, 0x00000000);
+            NV_WR32(chip->PGRAPH, 0x00000F50, 0x00006C00);
             for (i = 0; i < (3*4); i++)
-                chip->PGRAPH[0x00000F54/4] = 0x00000000;
-            chip->PGRAPH[0x00000F50/4] = 0x00007000;
+                NV_WR32(chip->PGRAPH, 0x00000F54, 0x00000000);
+            NV_WR32(chip->PGRAPH, 0x00000F50, 0x00007000);
             for (i = 0; i < (19*4); i++)
-                chip->PGRAPH[0x00000F54/4] = 0x00000000;
-            chip->PGRAPH[0x00000F50/4] = 0x00007400;
+                NV_WR32(chip->PGRAPH, 0x00000F54, 0x00000000);
+            NV_WR32(chip->PGRAPH, 0x00000F50, 0x00007400);
             for (i = 0; i < (12*4); i++)
-                chip->PGRAPH[0x00000F54/4] = 0x00000000;
-            chip->PGRAPH[0x00000F50/4] = 0x00007800;
+                NV_WR32(chip->PGRAPH, 0x00000F54, 0x00000000);
+            NV_WR32(chip->PGRAPH, 0x00000F50, 0x00007800);
             for (i = 0; i < (12*4); i++)
-                chip->PGRAPH[0x00000F54/4] = 0x00000000;
-            chip->PGRAPH[0x00000F50/4] = 0x00004400;
+                NV_WR32(chip->PGRAPH, 0x00000F54, 0x00000000);
+            NV_WR32(chip->PGRAPH, 0x00000F50, 0x00004400);
             for (i = 0; i < (8*4); i++)
-                chip->PGRAPH[0x00000F54/4] = 0x00000000;
-            chip->PGRAPH[0x00000F50/4] = 0x00000000;
+                NV_WR32(chip->PGRAPH, 0x00000F54, 0x00000000);
+            NV_WR32(chip->PGRAPH, 0x00000F50, 0x00000000);
             for (i = 0; i < 16; i++)
-                chip->PGRAPH[0x00000F54/4] = 0x00000000;
-            chip->PGRAPH[0x00000F50/4] = 0x00000040;
+                NV_WR32(chip->PGRAPH, 0x00000F54, 0x00000000);
+            NV_WR32(chip->PGRAPH, 0x00000F50, 0x00000040);
             for (i = 0; i < 4; i++)
-                chip->PGRAPH[0x00000F54/4] = 0x00000000;
+                NV_WR32(chip->PGRAPH, 0x00000F54, 0x00000000);
 
-            chip->PCRTC[0x00000810/4] = state->cursorConfig;
+            NV_WR32(chip->PCRTC, 0x00000810, state->cursorConfig);
 
             if(chip->flatPanel) {
                if((chip->Chipset & 0x0ff0) == 0x0110) {
-                   chip->PRAMDAC[0x0528/4] = state->dither;
+                   NV_WR32(chip->PRAMDAC, 0x0528, state->dither);
                } else 
                if((chip->Chipset & 0x0ff0) >= 0x0170) {
-                   chip->PRAMDAC[0x083C/4] = state->dither;
+                   NV_WR32(chip->PRAMDAC, 0x083C, state->dither);
                }
             
                VGA_WR08(chip->PCIO, 0x03D4, 0x53);
@@ -1668,24 +1706,24 @@
     VGA_WR08(chip->PCIO, 0x03D5, state->interlace);
 
     if(!chip->flatPanel) {
-       chip->PRAMDAC0[0x00000508/4] = state->vpll;
-       chip->PRAMDAC0[0x0000050C/4] = state->pllsel;
+       NV_WR32(chip->PRAMDAC0, 0x00000508, state->vpll);
+       NV_WR32(chip->PRAMDAC0, 0x0000050C, state->pllsel);
        if(chip->twoHeads)
-          chip->PRAMDAC0[0x00000520/4] = state->vpll2;
+          NV_WR32(chip->PRAMDAC0, 0x00000520, state->vpll2);
     }  else {
-       chip->PRAMDAC[0x00000848/4]  = state->scale;
+       NV_WR32(chip->PRAMDAC, 0x00000848 , state->scale);
     }  
-    chip->PRAMDAC[0x00000600/4]  = state->general;
+    NV_WR32(chip->PRAMDAC, 0x00000600 , state->general);
 
     /*
      * Turn off VBlank enable and reset.
      */
-    chip->PCRTC[0x00000140/4] = 0;
-    chip->PCRTC[0x00000100/4] = chip->VBlankBit;
+    NV_WR32(chip->PCRTC, 0x00000140, 0);
+    NV_WR32(chip->PCRTC, 0x00000100, chip->VBlankBit);
     /*
      * Set interrupt enable.
      */    
-    chip->PMC[0x00000140/4]  = chip->EnableIRQ & 0x01;
+    NV_WR32(chip->PMC, 0x00000140, chip->EnableIRQ & 0x01);
     /*
      * Set current state pointer.
      */
@@ -1695,7 +1733,7 @@
      */
     chip->FifoFreeCount  = 0;
     /* Free count from first subchannel */
-    chip->FifoEmptyCount = chip->Rop->FifoFree; 
+    chip->FifoEmptyCount = NV_RD32(&chip->Rop->FifoFree, 0);
 }
 static void UnloadStateExt
 (
@@ -1728,60 +1766,60 @@
     state->cursor2      = VGA_RD08(chip->PCIO, 0x03D5);
     VGA_WR08(chip->PCIO, 0x03D4, 0x39);
     state->interlace    = VGA_RD08(chip->PCIO, 0x03D5);
-    state->vpll         = chip->PRAMDAC0[0x00000508/4];
-    state->vpll2        = chip->PRAMDAC0[0x00000520/4];
-    state->pllsel       = chip->PRAMDAC0[0x0000050C/4];
-    state->general      = chip->PRAMDAC[0x00000600/4];
-    state->scale        = chip->PRAMDAC[0x00000848/4];
-    state->config       = chip->PFB[0x00000200/4];
+    state->vpll         = NV_RD32(chip->PRAMDAC0, 0x00000508);
+    state->vpll2        = NV_RD32(chip->PRAMDAC0, 0x00000520);
+    state->pllsel       = NV_RD32(chip->PRAMDAC0, 0x0000050C);
+    state->general      = NV_RD32(chip->PRAMDAC, 0x00000600);
+    state->scale        = NV_RD32(chip->PRAMDAC, 0x00000848);
+    state->config       = NV_RD32(chip->PFB, 0x00000200);
     switch (chip->Architecture)
     {
         case NV_ARCH_03:
-            state->offset0  = chip->PGRAPH[0x00000630/4];
-            state->offset1  = chip->PGRAPH[0x00000634/4];
-            state->offset2  = chip->PGRAPH[0x00000638/4];
-            state->offset3  = chip->PGRAPH[0x0000063C/4];
-            state->pitch0   = chip->PGRAPH[0x00000650/4];
-            state->pitch1   = chip->PGRAPH[0x00000654/4];
-            state->pitch2   = chip->PGRAPH[0x00000658/4];
-            state->pitch3   = chip->PGRAPH[0x0000065C/4];
+            state->offset0  = NV_RD32(chip->PGRAPH, 0x00000630);
+            state->offset1  = NV_RD32(chip->PGRAPH, 0x00000634);
+            state->offset2  = NV_RD32(chip->PGRAPH, 0x00000638);
+            state->offset3  = NV_RD32(chip->PGRAPH, 0x0000063C);
+            state->pitch0   = NV_RD32(chip->PGRAPH, 0x00000650);
+            state->pitch1   = NV_RD32(chip->PGRAPH, 0x00000654);
+            state->pitch2   = NV_RD32(chip->PGRAPH, 0x00000658);
+            state->pitch3   = NV_RD32(chip->PGRAPH, 0x0000065C);
             break;
         case NV_ARCH_04:
-            state->offset0  = chip->PGRAPH[0x00000640/4];
-            state->offset1  = chip->PGRAPH[0x00000644/4];
-            state->offset2  = chip->PGRAPH[0x00000648/4];
-            state->offset3  = chip->PGRAPH[0x0000064C/4];
-            state->pitch0   = chip->PGRAPH[0x00000670/4];
-            state->pitch1   = chip->PGRAPH[0x00000674/4];
-            state->pitch2   = chip->PGRAPH[0x00000678/4];
-            state->pitch3   = chip->PGRAPH[0x0000067C/4];
+            state->offset0  = NV_RD32(chip->PGRAPH, 0x00000640);
+            state->offset1  = NV_RD32(chip->PGRAPH, 0x00000644);
+            state->offset2  = NV_RD32(chip->PGRAPH, 0x00000648);
+            state->offset3  = NV_RD32(chip->PGRAPH, 0x0000064C);
+            state->pitch0   = NV_RD32(chip->PGRAPH, 0x00000670);
+            state->pitch1   = NV_RD32(chip->PGRAPH, 0x00000674);
+            state->pitch2   = NV_RD32(chip->PGRAPH, 0x00000678);
+            state->pitch3   = NV_RD32(chip->PGRAPH, 0x0000067C);
             break;
         case NV_ARCH_10:
         case NV_ARCH_20:
         case NV_ARCH_30:
-            state->offset0  = chip->PGRAPH[0x00000640/4];
-            state->offset1  = chip->PGRAPH[0x00000644/4];
-            state->offset2  = chip->PGRAPH[0x00000648/4];
-            state->offset3  = chip->PGRAPH[0x0000064C/4];
-            state->pitch0   = chip->PGRAPH[0x00000670/4];
-            state->pitch1   = chip->PGRAPH[0x00000674/4];
-            state->pitch2   = chip->PGRAPH[0x00000678/4];
-            state->pitch3   = chip->PGRAPH[0x0000067C/4];
+            state->offset0  = NV_RD32(chip->PGRAPH, 0x00000640);
+            state->offset1  = NV_RD32(chip->PGRAPH, 0x00000644);
+            state->offset2  = NV_RD32(chip->PGRAPH, 0x00000648);
+            state->offset3  = NV_RD32(chip->PGRAPH, 0x0000064C);
+            state->pitch0   = NV_RD32(chip->PGRAPH, 0x00000670);
+            state->pitch1   = NV_RD32(chip->PGRAPH, 0x00000674);
+            state->pitch2   = NV_RD32(chip->PGRAPH, 0x00000678);
+            state->pitch3   = NV_RD32(chip->PGRAPH, 0x0000067C);
             if(chip->twoHeads) {
-               state->head     = chip->PCRTC0[0x00000860/4];
-               state->head2    = chip->PCRTC0[0x00002860/4];
+               state->head     = NV_RD32(chip->PCRTC0, 0x00000860);
+               state->head2    = NV_RD32(chip->PCRTC0, 0x00002860);
                VGA_WR08(chip->PCIO, 0x03D4, 0x44);
                state->crtcOwner = VGA_RD08(chip->PCIO, 0x03D5);
             }
             VGA_WR08(chip->PCIO, 0x03D4, 0x41);
             state->extra = VGA_RD08(chip->PCIO, 0x03D5);
-            state->cursorConfig = chip->PCRTC[0x00000810/4];
+            state->cursorConfig = NV_RD32(chip->PCRTC, 0x00000810);
 
             if((chip->Chipset & 0x0ff0) == 0x0110) {
-                state->dither = chip->PRAMDAC[0x0528/4];
+                state->dither = NV_RD32(chip->PRAMDAC, 0x0528);
             } else 
             if((chip->Chipset & 0x0ff0) >= 0x0170) {
-                state->dither = chip->PRAMDAC[0x083C/4];
+                state->dither = NV_RD32(chip->PRAMDAC, 0x083C);
             }
             break;
     }
@@ -1792,7 +1830,7 @@
     unsigned      start
 )
 {
-    chip->PCRTC[0x800/4] = start;
+    NV_WR32(chip->PCRTC, 0x800, start);
 }
 
 static void SetStartAddress3
@@ -1834,14 +1872,15 @@
     unsigned     surf1
 )
 {
-    RivaSurface *Surface = (RivaSurface *)&(chip->FIFO[0x0000E000/4]);
+    RivaSurface __iomem *Surface =
+	(RivaSurface __iomem *)&(chip->FIFO[0x0000E000/4]);
 
     RIVA_FIFO_FREE(*chip,Tri03,5);
-    chip->FIFO[0x00003800] = 0x80000003;
-    Surface->Offset        = surf0;
-    chip->FIFO[0x00003800] = 0x80000004;
-    Surface->Offset        = surf1;
-    chip->FIFO[0x00003800] = 0x80000013;
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000003);
+    NV_WR32(&Surface->Offset, 0, surf0);
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000004);
+    NV_WR32(&Surface->Offset, 0, surf1);
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000013);
 }
 static void nv4SetSurfaces2D
 (
@@ -1850,13 +1889,14 @@
     unsigned     surf1
 )
 {
-    RivaSurface *Surface = (RivaSurface *)&(chip->FIFO[0x0000E000/4]);
+    RivaSurface __iomem *Surface =
+	(RivaSurface __iomem *)&(chip->FIFO[0x0000E000/4]);
 
-    chip->FIFO[0x00003800] = 0x80000003;
-    Surface->Offset        = surf0;
-    chip->FIFO[0x00003800] = 0x80000004;
-    Surface->Offset        = surf1;
-    chip->FIFO[0x00003800] = 0x80000014;
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000003);
+    NV_WR32(&Surface->Offset, 0, surf0);
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000004);
+    NV_WR32(&Surface->Offset, 0, surf1);
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000014);
 }
 static void nv10SetSurfaces2D
 (
@@ -1865,13 +1905,14 @@
     unsigned     surf1
 )
 {
-    RivaSurface *Surface = (RivaSurface *)&(chip->FIFO[0x0000E000/4]);
+    RivaSurface __iomem *Surface =
+	(RivaSurface __iomem *)&(chip->FIFO[0x0000E000/4]);
 
-    chip->FIFO[0x00003800] = 0x80000003;
-    Surface->Offset        = surf0;
-    chip->FIFO[0x00003800] = 0x80000004;
-    Surface->Offset        = surf1;
-    chip->FIFO[0x00003800] = 0x80000014;
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000003);
+    NV_WR32(&Surface->Offset, 0, surf0);
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000004);
+    NV_WR32(&Surface->Offset, 0, surf1);
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000014);
 }
 static void nv3SetSurfaces3D
 (
@@ -1880,14 +1921,15 @@
     unsigned     surf1
 )
 {
-    RivaSurface *Surface = (RivaSurface *)&(chip->FIFO[0x0000E000/4]);
+    RivaSurface __iomem *Surface =
+	(RivaSurface __iomem *)&(chip->FIFO[0x0000E000/4]);
 
     RIVA_FIFO_FREE(*chip,Tri03,5);
-    chip->FIFO[0x00003800] = 0x80000005;
-    Surface->Offset        = surf0;
-    chip->FIFO[0x00003800] = 0x80000006;
-    Surface->Offset        = surf1;
-    chip->FIFO[0x00003800] = 0x80000013;
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000005);
+    NV_WR32(&Surface->Offset, 0, surf0);
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000006);
+    NV_WR32(&Surface->Offset, 0, surf1);
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000013);
 }
 static void nv4SetSurfaces3D
 (
@@ -1896,13 +1938,14 @@
     unsigned     surf1
 )
 {
-    RivaSurface *Surface = (RivaSurface *)&(chip->FIFO[0x0000E000/4]);
+    RivaSurface __iomem *Surface =
+	(RivaSurface __iomem *)&(chip->FIFO[0x0000E000/4]);
 
-    chip->FIFO[0x00003800] = 0x80000005;
-    Surface->Offset        = surf0;
-    chip->FIFO[0x00003800] = 0x80000006;
-    Surface->Offset        = surf1;
-    chip->FIFO[0x00003800] = 0x80000014;
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000005);
+    NV_WR32(&Surface->Offset, 0, surf0);
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000006);
+    NV_WR32(&Surface->Offset, 0, surf1);
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000014);
 }
 static void nv10SetSurfaces3D
 (
@@ -1911,13 +1954,14 @@
     unsigned     surf1
 )
 {
-    RivaSurface3D *Surfaces3D = (RivaSurface3D *)&(chip->FIFO[0x0000E000/4]);
+    RivaSurface3D __iomem *Surfaces3D =
+	(RivaSurface3D __iomem *)&(chip->FIFO[0x0000E000/4]);
 
     RIVA_FIFO_FREE(*chip,Tri03,4);
-    chip->FIFO[0x00003800]         = 0x80000007;
-    Surfaces3D->RenderBufferOffset = surf0;
-    Surfaces3D->ZBufferOffset      = surf1;
-    chip->FIFO[0x00003800]         = 0x80000014;
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000007);
+    NV_WR32(&Surfaces3D->RenderBufferOffset, 0, surf0);
+    NV_WR32(&Surfaces3D->ZBufferOffset, 0, surf1);
+    NV_WR32(&chip->FIFO[0x00003800], 0, 0x80000014);
 }
 
 /****************************************************************************\
@@ -1934,16 +1978,16 @@
     /*
      * Fill in chip configuration.
      */
-    if (chip->PFB[0x00000000/4] & 0x00000020)
+    if (NV_RD32(&chip->PFB[0x00000000/4], 0) & 0x00000020)
     {
-        if (((chip->PMC[0x00000000/4] & 0xF0) == 0x20)
-         && ((chip->PMC[0x00000000/4] & 0x0F) >= 0x02))
+        if (((NV_RD32(chip->PMC, 0x00000000) & 0xF0) == 0x20)
+         && ((NV_RD32(chip->PMC, 0x00000000) & 0x0F) >= 0x02))
         {        
             /*
              * SDRAM 128 ZX.
              */
             chip->RamBandwidthKBytesPerSec = 800000;
-            switch (chip->PFB[0x00000000/4] & 0x03)
+            switch (NV_RD32(chip->PFB, 0x00000000) & 0x03)
             {
                 case 2:
                     chip->RamAmountKBytes = 1024 * 4;
@@ -1968,7 +2012,7 @@
          * SGRAM 128.
          */
         chip->RamBandwidthKBytesPerSec = 1000000;
-        switch (chip->PFB[0x00000000/4] & 0x00000003)
+        switch (NV_RD32(chip->PFB, 0x00000000) & 0x00000003)
         {
             case 0:
                 chip->RamAmountKBytes = 1024 * 8;
@@ -1981,7 +2025,7 @@
                 break;
         }
     }        
-    chip->CrystalFreqKHz   = (chip->PEXTDEV[0x00000000/4] & 0x00000040) ? 14318 : 13500;
+    chip->CrystalFreqKHz   = (NV_RD32(chip->PEXTDEV, 0x00000000) & 0x00000040) ? 14318 : 13500;
     chip->CURSOR           = &(chip->PRAMIN[0x00008000/4 - 0x0800/4]);
     chip->VBlankBit        = 0x00000100;
     chip->MaxVClockFreqKHz = 256000;
@@ -2006,14 +2050,14 @@
     /*
      * Fill in chip configuration.
      */
-    if (chip->PFB[0x00000000/4] & 0x00000100)
+    if (NV_RD32(chip->PFB, 0x00000000) & 0x00000100)
     {
-        chip->RamAmountKBytes = ((chip->PFB[0x00000000/4] >> 12) & 0x0F) * 1024 * 2
+        chip->RamAmountKBytes = ((NV_RD32(chip->PFB, 0x00000000) >> 12) & 0x0F) * 1024 * 2
                               + 1024 * 2;
     }
     else
     {
-        switch (chip->PFB[0x00000000/4] & 0x00000003)
+        switch (NV_RD32(chip->PFB, 0x00000000) & 0x00000003)
         {
             case 0:
                 chip->RamAmountKBytes = 1024 * 32;
@@ -2030,7 +2074,7 @@
                 break;
         }
     }
-    switch ((chip->PFB[0x00000000/4] >> 3) & 0x00000003)
+    switch ((NV_RD32(chip->PFB, 0x00000000) >> 3) & 0x00000003)
     {
         case 3:
             chip->RamBandwidthKBytesPerSec = 800000;
@@ -2039,7 +2083,7 @@
             chip->RamBandwidthKBytesPerSec = 1000000;
             break;
     }
-    chip->CrystalFreqKHz   = (chip->PEXTDEV[0x00000000/4] & 0x00000040) ? 14318 : 13500;
+    chip->CrystalFreqKHz   = (NV_RD32(chip->PEXTDEV, 0x00000000) & 0x00000040) ? 14318 : 13500;
     chip->CURSOR           = &(chip->PRAMIN[0x00010000/4 - 0x0800/4]);
     chip->VBlankBit        = 0x00000001;
     chip->MaxVClockFreqKHz = 350000;
@@ -2067,8 +2111,8 @@
 
 #ifdef __BIG_ENDIAN
     /* turn on big endian register access */
-    if(!(chip->PMC[0x00000004/4] & 0x01000001))
-    	chip->PMC[0x00000004/4] = 0x01000001;
+    if(!(NV_RD32(chip->PMC, 0x00000004) & 0x01000001))
+    	NV_WR32(chip->PMC, 0x00000004], 0x01000001);
 #endif
 
     /*
@@ -2083,7 +2127,7 @@
         pci_read_config_dword(dev, 0x84, &amt);
         chip->RamAmountKBytes = (((amt >> 4) & 127) + 1) * 1024;
     } else {
-        switch ((chip->PFB[0x0000020C/4] >> 20) & 0x000000FF)
+        switch ((NV_RD32(chip->PFB, 0x0000020C) >> 20) & 0x000000FF)
         {
             case 0x02:
                 chip->RamAmountKBytes = 1024 * 2;
@@ -2111,7 +2155,7 @@
                 break;
         }
     }
-    switch ((chip->PFB[0x00000000/4] >> 3) & 0x00000003)
+    switch ((NV_RD32(chip->PFB, 0x00000000) >> 3) & 0x00000003)
     {
         case 3:
             chip->RamBandwidthKBytesPerSec = 800000;
@@ -2120,8 +2164,8 @@
             chip->RamBandwidthKBytesPerSec = 1000000;
             break;
     }
-    chip->CrystalFreqKHz = (chip->PEXTDEV[0x0000/4] & (1 << 6)) ? 14318 :
-                                                                  13500;
+    chip->CrystalFreqKHz = (NV_RD32(chip->PEXTDEV, 0x0000) & (1 << 6)) ?
+	14318 : 13500;
 
     switch (chipset & 0x0ff0) {
     case 0x0170:
@@ -2134,7 +2178,7 @@
     case 0x0320:
     case 0x0330:
     case 0x0340:
-       if(chip->PEXTDEV[0x0000/4] & (1 << 22))
+       if(NV_RD32(chip->PEXTDEV, 0x0000) & (1 << 22))
            chip->CrystalFreqKHz = 27000;
        break;
     default:
@@ -2210,14 +2254,14 @@
     /*
      * Fill in FIFO pointers.
      */
-    chip->Rop    = (RivaRop                 *)&(chip->FIFO[0x00000000/4]);
-    chip->Clip   = (RivaClip                *)&(chip->FIFO[0x00002000/4]);
-    chip->Patt   = (RivaPattern             *)&(chip->FIFO[0x00004000/4]);
-    chip->Pixmap = (RivaPixmap              *)&(chip->FIFO[0x00006000/4]);
-    chip->Blt    = (RivaScreenBlt           *)&(chip->FIFO[0x00008000/4]);
-    chip->Bitmap = (RivaBitmap              *)&(chip->FIFO[0x0000A000/4]);
-    chip->Line   = (RivaLine                *)&(chip->FIFO[0x0000C000/4]);
-    chip->Tri03  = (RivaTexturedTriangle03  *)&(chip->FIFO[0x0000E000/4]);
+    chip->Rop    = (RivaRop __iomem         *)&(chip->FIFO[0x00000000/4]);
+    chip->Clip   = (RivaClip __iomem        *)&(chip->FIFO[0x00002000/4]);
+    chip->Patt   = (RivaPattern __iomem     *)&(chip->FIFO[0x00004000/4]);
+    chip->Pixmap = (RivaPixmap __iomem      *)&(chip->FIFO[0x00006000/4]);
+    chip->Blt    = (RivaScreenBlt __iomem   *)&(chip->FIFO[0x00008000/4]);
+    chip->Bitmap = (RivaBitmap __iomem      *)&(chip->FIFO[0x0000A000/4]);
+    chip->Line   = (RivaLine __iomem        *)&(chip->FIFO[0x0000C000/4]);
+    chip->Tri03  = (RivaTexturedTriangle03 __iomem *)&(chip->FIFO[0x0000E000/4]);
     return (0);
 }
 
diff -Nru a/drivers/video/riva/riva_hw.h b/drivers/video/riva/riva_hw.h
--- a/drivers/video/riva/riva_hw.h	2004-10-31 07:27:18 +08:00
+++ b/drivers/video/riva/riva_hw.h	2004-10-31 16:57:08 +08:00
@@ -78,13 +78,13 @@
 #define NV_WR08(p,i,d)	out_8(p+i, d)
 #define NV_RD08(p,i)	in_8(p+i)
 #else
-#define NV_WR08(p,i,d)  (((U008 *)(p))[i]=(d))
-#define NV_RD08(p,i)    (((U008 *)(p))[i])
+#define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
+#define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
 #endif
-#define NV_WR16(p,i,d)  (((U016 *)(p))[(i)/2]=(d))
-#define NV_RD16(p,i)    (((U016 *)(p))[(i)/2])
-#define NV_WR32(p,i,d)  (((U032 *)(p))[(i)/4]=(d))
-#define NV_RD32(p,i)    (((U032 *)(p))[(i)/4])
+#define NV_WR16(p,i,d)  (writew((d), (u16 __iomem *)(p) + (i)/2))
+#define NV_RD16(p,i)    (readw((u16 __iomem *)(p) + (i)/2))
+#define NV_WR32(p,i,d)  (writel((d), (u32 __iomem *)(p) + (i)/4))
+#define NV_RD32(p,i)    (readl((u32 __iomem *)(p) + (i)/4))
 #define VGA_WR08(p,i,d) NV_WR08(p,i,d)
 #define VGA_RD08(p,i)   NV_RD08(p,i)
 
@@ -444,24 +444,24 @@
     /*
      * Non-FIFO registers.
      */
-    volatile U032 *PCRTC0;
-    volatile U032 *PCRTC;
-    volatile U032 *PRAMDAC0;
-    volatile U032 *PFB;
-    volatile U032 *PFIFO;
-    volatile U032 *PGRAPH;
-    volatile U032 *PEXTDEV;
-    volatile U032 *PTIMER;
-    volatile U032 *PMC;
-    volatile U032 *PRAMIN;
-    volatile U032 *FIFO;
-    volatile U032 *CURSOR;
-    volatile U008 *PCIO0;
-    volatile U008 *PCIO;
-    volatile U008 *PVIO;
-    volatile U008 *PDIO0;
-    volatile U008 *PDIO;
-    volatile U032 *PRAMDAC;
+    volatile U032 __iomem *PCRTC0;
+    volatile U032 __iomem *PCRTC;
+    volatile U032 __iomem *PRAMDAC0;
+    volatile U032 __iomem *PFB;
+    volatile U032 __iomem *PFIFO;
+    volatile U032 __iomem *PGRAPH;
+    volatile U032 __iomem *PEXTDEV;
+    volatile U032 __iomem *PTIMER;
+    volatile U032 __iomem *PMC;
+    volatile U032 __iomem *PRAMIN;
+    volatile U032 __iomem *FIFO;
+    volatile U032 __iomem *CURSOR;
+    volatile U008 __iomem *PCIO0;
+    volatile U008 __iomem *PCIO;
+    volatile U008 __iomem *PVIO;
+    volatile U008 __iomem *PDIO0;
+    volatile U008 __iomem *PDIO;
+    volatile U032 __iomem *PRAMDAC;
     /*
      * Common chip functions.
      */
@@ -481,15 +481,15 @@
     /*
      * FIFO registers.
      */
-    RivaRop                 *Rop;
-    RivaPattern             *Patt;
-    RivaClip                *Clip;
-    RivaPixmap              *Pixmap;
-    RivaScreenBlt           *Blt;
-    RivaBitmap              *Bitmap;
-    RivaLine                *Line;
-    RivaTexturedTriangle03  *Tri03;
-    RivaTexturedTriangle05  *Tri05;
+    RivaRop                 __iomem *Rop;
+    RivaPattern             __iomem *Patt;
+    RivaClip                __iomem *Clip;
+    RivaPixmap              __iomem *Pixmap;
+    RivaScreenBlt           __iomem *Blt;
+    RivaBitmap              __iomem *Bitmap;
+    RivaLine                __iomem *Line;
+    RivaTexturedTriangle03  __iomem *Tri03;
+    RivaTexturedTriangle05  __iomem *Tri05;
 } RIVA_HW_INST;
 /*
  * Extended mode state information.
@@ -543,7 +543,7 @@
 {                                                                   \
     while ((hwinst).FifoFreeCount < (cnt)) {                        \
 	mb();mb();						    \
-        (hwinst).FifoFreeCount = (hwinst).hwptr->FifoFree >> 2;     \
+        (hwinst).FifoFreeCount = NV_RD32(&(hwinst).hwptr->FifoFree, 0) >> 2;     \
     }								    \
     (hwinst).FifoFreeCount -= (cnt);                                \
 }
diff -Nru a/drivers/video/riva/rivafb.h b/drivers/video/riva/rivafb.h
--- a/drivers/video/riva/rivafb.h	2004-10-27 16:28:37 +08:00
+++ b/drivers/video/riva/rivafb.h	2004-10-31 16:57:08 +08:00
@@ -46,7 +46,7 @@
 	RIVA_HW_INST riva;	/* interface to riva_hw.c */
 	u32 pseudo_palette[16]; /* default palette */
 	u32 palette[16];        /* for Riva128 */
-	caddr_t ctrl_base;	/* virtual control register base addr */
+	u8 __iomem *ctrl_base;	/* virtual control register base addr */
 	unsigned dclk_max;	/* max DCLK */
 
 	struct riva_regs initial_state;	/* initial startup video mode */




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
