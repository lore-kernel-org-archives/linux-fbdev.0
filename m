From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sat, 25 Aug 2018 19:51:00 +0000
Subject: [PATCH 1/3] mach64: fix display corruption on big endian machines
Message-Id: <alpine.LRH.2.02.1808251549550.8284@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

The code for manual bit triple is not endian-clean. It builds the variable
"hostdword" using byte accesses, therefore we must read the variable with
"le32_to_cpu".

The patch also enables (hardware or software) bit triple only if the image
is monochrome (image->depth). If we want to blit full-color image, we
shouldn't use the triple code.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/video/fbdev/aty/mach64_accel.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-stable/drivers/video/fbdev/aty/mach64_accel.c
=================================--- linux-stable.orig/drivers/video/fbdev/aty/mach64_accel.c	2018-08-24 17:31:21.000000000 +0200
+++ linux-stable/drivers/video/fbdev/aty/mach64_accel.c	2018-08-24 19:12:40.000000000 +0200
@@ -345,7 +345,7 @@ void atyfb_imageblit(struct fb_info *inf
 		 * since Rage 3D IIc we have DP_HOST_TRIPLE_EN bit
 		 * this hwaccelerated triple has an issue with not aligned data
 		 */
-		if (M64_HAS(HW_TRIPLE) && image->width % 8 = 0)
+		if (image->depth = 1 && M64_HAS(HW_TRIPLE) && image->width % 8 = 0)
 			pix_width |= DP_HOST_TRIPLE_EN;
 	}
 
@@ -382,7 +382,7 @@ void atyfb_imageblit(struct fb_info *inf
 	src_bytes = (((image->width * image->depth) + 7) / 8) * image->height;
 
 	/* manual triple each pixel */
-	if (info->var.bits_per_pixel = 24 && !(pix_width & DP_HOST_TRIPLE_EN)) {
+	if (image->depth = 1 && info->var.bits_per_pixel = 24 && !(pix_width & DP_HOST_TRIPLE_EN)) {
 		int inbit, outbit, mult24, byte_id_in_dword, width;
 		u8 *pbitmapin = (u8*)image->data, *pbitmapout;
 		u32 hostdword;
@@ -415,7 +415,7 @@ void atyfb_imageblit(struct fb_info *inf
 				}
 			}
 			wait_for_fifo(1, par);
-			aty_st_le32(HOST_DATA0, hostdword, par);
+			aty_st_le32(HOST_DATA0, le32_to_cpu(hostdword), par);
 		}
 	} else {
 		u32 *pbitmap, dwords = (src_bytes + 3) / 4;
