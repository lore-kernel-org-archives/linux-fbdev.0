From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 11 Mar 2015 01:28:45 +0000
Subject: [PATCH 6/6] staging: sm750fb: Spinlock and unlock in the same block
Message-Id: <1426037325-8392-6-git-send-email-lstoakes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>

This patch combines spinlock locks and unlocks together in the same block rather
than occurring in separate blocks preventing a possible deadlock. This fixes the
following sparse warnings:-

drivers/staging/sm750fb/sm750.c:218:22: warning: context imbalance in 'lynxfb_ops_fillrect' - different lock contexts for basic block
drivers/staging/sm750fb/sm750.c:241:22: warning: context imbalance in 'lynxfb_ops_copyarea' - different lock contexts for basic block
drivers/staging/sm750fb/sm750.c:282:22: warning: context imbalance in 'lynxfb_ops_imageblit' - different lock contexts for basic block

Unfortunately this change involves code (and comment) duplication.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 76 +++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 3e36b6a..58c7518 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -56,23 +56,6 @@ static char * g_settings = NULL;
 static int g_dualview = 0;
 static char * g_option = NULL;
 
-/* if not use spin_lock,system will die if user load driver
- * and immediatly unload driver frequently (dual)*/
-static inline void myspin_lock(spinlock_t * sl){
-	struct lynx_share * share;
-	share = container_of(sl,struct lynx_share,slock);
-	if(share->dual){
-		spin_lock(sl);
-	}
-}
-
-static inline void myspin_unlock(spinlock_t * sl){
-	struct lynx_share * share;
-	share = container_of(sl,struct lynx_share,slock);
-	if(share->dual){
-		spin_unlock(sl);
-	}
-}
 static const struct fb_videomode lynx750_ext[] = {
 	/*  	1024x600-60 VESA 	[1.71:1]	*/
 	{NULL,  60, 1024, 600, 20423, 144,  40, 18, 1, 104, 3,
@@ -209,13 +192,22 @@ static void lynxfb_ops_fillrect(struct fb_info* info,const struct fb_fillrect* r
 	color = (Bpp = 1)?region->color:((u32*)info->pseudo_palette)[region->color];
 	rop = ( region->rop != ROP_COPY ) ? HW_ROP2_XOR:HW_ROP2_COPY;
 
-	myspin_lock(&share->slock);
-	share->accel.de_fillrect(&share->accel,
-							base,pitch,Bpp,
-							region->dx,region->dy,
-							region->width,region->height,
-							color,rop);
-	myspin_unlock(&share->slock);
+	/* if not use spin_lock,system will die if user load driver
+	 * and immediatly unload driver frequently (dual)*/
+	if (share->dual) {
+		spin_lock(&share->slock);
+		share->accel.de_fillrect(&share->accel,
+					base,pitch,Bpp,
+					region->dx,region->dy,
+					region->width,region->height,
+					color,rop);
+		spin_unlock(&share->slock);
+	} else
+		share->accel.de_fillrect(&share->accel,
+					base,pitch,Bpp,
+					region->dx,region->dy,
+					region->width,region->height,
+					color,rop);
 }
 
 static void lynxfb_ops_copyarea(struct fb_info * info,const struct fb_copyarea * region)
@@ -233,12 +225,20 @@ static void lynxfb_ops_copyarea(struct fb_info * info,const struct fb_copyarea *
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
 
-	myspin_lock(&share->slock);
-	share->accel.de_copyarea(&share->accel,
-							base,pitch,region->sx,region->sy,
-							base,pitch,Bpp,region->dx,region->dy,
-							region->width,region->height,HW_ROP2_COPY);
-	myspin_unlock(&share->slock);
+	/* if not use spin_lock,system will die if user load driver
+	 * and immediatly unload driver frequently (dual)*/
+	if (share->dual) {
+		spin_lock(&share->slock);
+		share->accel.de_copyarea(&share->accel,
+					base,pitch,region->sx,region->sy,
+					base,pitch,Bpp,region->dx,region->dy,
+					region->width,region->height,HW_ROP2_COPY);
+		spin_unlock(&share->slock);
+	} else
+		share->accel.de_copyarea(&share->accel,
+					base,pitch,region->sx,region->sy,
+					base,pitch,Bpp,region->dx,region->dy,
+					region->width,region->height,HW_ROP2_COPY);
 }
 
 static void lynxfb_ops_imageblit(struct fb_info*info,const struct fb_image* image)
@@ -272,14 +272,24 @@ static void lynxfb_ops_imageblit(struct fb_info*info,const struct fb_image* imag
 	}
 	return;
 _do_work:
-	myspin_lock(&share->slock);
-	share->accel.de_imageblit(&share->accel,
+	/* if not use spin_lock,system will die if user load driver
+	 * and immediatly unload driver frequently (dual)*/
+	if (share->dual) {
+		spin_lock(&share->slock);
+		share->accel.de_imageblit(&share->accel,
+					image->data,image->width>>3,0,
+					base,pitch,Bpp,
+					image->dx,image->dy,
+					image->width,image->height,
+					fgcol,bgcol,HW_ROP2_COPY);
+		spin_unlock(&share->slock);
+	} else
+		share->accel.de_imageblit(&share->accel,
 					image->data,image->width>>3,0,
 					base,pitch,Bpp,
 					image->dx,image->dy,
 					image->width,image->height,
 					fgcol,bgcol,HW_ROP2_COPY);
-	myspin_unlock(&share->slock);
 }
 
 static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
-- 
2.3.2

