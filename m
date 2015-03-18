From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 18 Mar 2015 08:57:26 +0000
Subject: [PATCH RESEND 5/5] staging: sm750fb: Remove spinlock helper function
Message-Id: <1426669046-29935-5-git-send-email-lstoakes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>

This patch removes the unnecessary spinlock helper function and instead
calls spin_lock and spin_unlock directly.

This does *not* resolve sparse warnings about context imbalances but these are
spurious.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 53 +++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index be35429..a6658e1 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -56,23 +56,6 @@ static char * g_settings = NULL;
 static int g_dualview;
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
@@ -209,13 +192,21 @@ static void lynxfb_ops_fillrect(struct fb_info* info,const struct fb_fillrect* r
 	color = (Bpp = 1)?region->color:((u32*)info->pseudo_palette)[region->color];
 	rop = ( region->rop != ROP_COPY ) ? HW_ROP2_XOR:HW_ROP2_COPY;

-	myspin_lock(&share->slock);
+	/*
+	 * If not use spin_lock,system will die if user load driver
+	 * and immediatly unload driver frequently (dual)
+	 */
+	if (share->dual)
+		spin_lock(&share->slock);
+
 	share->accel.de_fillrect(&share->accel,
 							base,pitch,Bpp,
 							region->dx,region->dy,
 							region->width,region->height,
 							color,rop);
-	myspin_unlock(&share->slock);
+
+	if (share->dual)
+		spin_unlock(&share->slock);
 }

 static void lynxfb_ops_copyarea(struct fb_info * info,const struct fb_copyarea * region)
@@ -233,12 +224,20 @@ static void lynxfb_ops_copyarea(struct fb_info * info,const struct fb_copyarea *
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;

-	myspin_lock(&share->slock);
+	/*
+	 * If not use spin_lock, system will die if user load driver
+	 * and immediatly unload driver frequently (dual)
+	 */
+	if (share->dual)
+		spin_lock(&share->slock);
+
 	share->accel.de_copyarea(&share->accel,
 							base,pitch,region->sx,region->sy,
 							base,pitch,Bpp,region->dx,region->dy,
 							region->width,region->height,HW_ROP2_COPY);
-	myspin_unlock(&share->slock);
+
+	if (share->dual)
+		spin_unlock(&share->slock);
 }

 static void lynxfb_ops_imageblit(struct fb_info*info,const struct fb_image* image)
@@ -272,14 +271,22 @@ static void lynxfb_ops_imageblit(struct fb_info*info,const struct fb_image* imag
 	}
 	return;
 _do_work:
-	myspin_lock(&share->slock);
+	/*
+	 * If not use spin_lock, system will die if user load driver
+	 * and immediatly unload driver frequently (dual)
+	 */
+	if (share->dual)
+		spin_lock(&share->slock);
+
 	share->accel.de_imageblit(&share->accel,
 					image->data,image->width>>3,0,
 					base,pitch,Bpp,
 					image->dx,image->dy,
 					image->width,image->height,
 					fgcol,bgcol,HW_ROP2_COPY);
-	myspin_unlock(&share->slock);
+
+	if (share->dual)
+		spin_unlock(&share->slock);
 }

 static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
--
2.3.3
