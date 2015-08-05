From: Peng Fan <van.freenix@gmail.com>
Date: Wed, 05 Aug 2015 13:26:44 +0000
Subject: [PATCH] staging: sm750fb: fix sparse warning for lock
Message-Id: <1438781204-13283-1-git-send-email-van.freenix@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425934628-3717-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1425934628-3717-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, van.freenix@gmail.com

Use __acquire() and __release() in the right place to silence the sparse
lock checking warning.

drivers/staging/sm750fb/sm750.c:177:13: warning: context imbalance in 'lynxfb_ops_fillrect' - different lock contexts for basic block
drivers/staging/sm750fb/sm750.c:243:9: warning: context imbalance in 'lynxfb_ops_copyarea' - different lock contexts for basic block
drivers/staging/sm750fb/sm750.c:247:13: warning: context imbalance in 'lynxfb_ops_imageblit' - different lock contexts for basic block

Signed-off-by: Peng Fan <van.freenix@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/sm750fb/sm750.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8e201f1..5ba1c06 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -203,6 +203,8 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	 */
 	if (share->dual)
 		spin_lock(&share->slock);
+	else
+		__acquire(&share->slock);
 
 	share->accel.de_fillrect(&share->accel,
 				 base, pitch, Bpp,
@@ -211,6 +213,8 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 				 color, rop);
 	if (share->dual)
 		spin_unlock(&share->slock);
+	else
+		__release(&share->slock);
 }
 
 static void lynxfb_ops_copyarea(struct fb_info *info,
@@ -235,6 +239,8 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	 */
 	if (share->dual)
 		spin_lock(&share->slock);
+	else
+		__acquire(&share->slock);
 
 	share->accel.de_copyarea(&share->accel,
 				 base, pitch, region->sx, region->sy,
@@ -242,6 +248,8 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 				 region->width, region->height, HW_ROP2_COPY);
 	if (share->dual)
 		spin_unlock(&share->slock);
+	else
+		__release(&share->slock);
 }
 
 static void lynxfb_ops_imageblit(struct fb_info *info,
@@ -282,6 +290,8 @@ _do_work:
 	 */
 	if (share->dual)
 		spin_lock(&share->slock);
+	else
+		__acquire(&share->slock);
 
 	share->accel.de_imageblit(&share->accel,
 				  image->data, image->width>>3, 0,
@@ -291,6 +301,8 @@ _do_work:
 				  fgcol, bgcol, HW_ROP2_COPY);
 	if (share->dual)
 		spin_unlock(&share->slock);
+	else
+		__release(&share->slock);
 }
 
 static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
-- 
1.8.4

