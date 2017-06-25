From: Frans Klaver <fransklaver@gmail.com>
Date: Sun, 25 Jun 2017 20:20:34 +0000
Subject: Re: [PATCH] staging: sm750fb: fix sparce warning.
Message-Id: <D537A773-3D92-409B-A139-206CA21138D8@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1498417843-12060-1-git-send-email-abdallah.meziti.pro@gmail.com>
In-Reply-To: <1498417843-12060-1-git-send-email-abdallah.meziti.pro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>, sudipm.mukherjee@gmail.com
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org



On 25 June 2017 21:10:36 CEST, AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com> wrote:
>This patch fixes the following sparce warnings: different lock contexts
>for basic block.
>
>drivers/staging/sm750fb//sm750.c:159:13: warning: context imbalance in
>'lynxfb_ops_fillrect' - different lock contexts for basic block
>drivers/staging/sm750fb//sm750.c:231:9: warning: context imbalance in
>'lynxfb_ops_copyarea' - different lock contexts for basic block
>drivers/staging/sm750fb//sm750.c:235:13: warning: context imbalance in
>'lynxfb_ops_imageblit' - different lock contexts for basic block
>
>Signed-off-by: AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>
>---
>drivers/staging/sm750fb/sm750.c | 69
>++++++++++++++++++++++++++++-------------
> 1 file changed, 47 insertions(+), 22 deletions(-)
>
>diff --git a/drivers/staging/sm750fb/sm750.c
>b/drivers/staging/sm750fb/sm750.c
>index 664c220..5494a29 100644
>--- a/drivers/staging/sm750fb/sm750.c
>+++ b/drivers/staging/sm750fb/sm750.c
>@@ -186,16 +186,24 @@ static void lynxfb_ops_fillrect(struct fb_info
>*info,
> 	 * If not use spin_lock,system will die if user load driver
> 	 * and immediately unload driver frequently (dual)
> 	 */
>-	if (sm750_dev->fb_count > 1)
>+	if (sm750_dev->fb_count > 1) {
> 		spin_lock(&sm750_dev->slock);
> 
>-	sm750_dev->accel.de_fillrect(&sm750_dev->accel,
>-				     base, pitch, Bpp,
>-				     region->dx, region->dy,
>-				     region->width, region->height,
>-				     color, rop);
>-	if (sm750_dev->fb_count > 1)
>+		sm750_dev->accel.de_fillrect(&sm750_dev->accel,
>+					     base, pitch, Bpp,
>+					     region->dx, region->dy,
>+					     region->width, region->height,
>+					     color, rop);
>+
> 		spin_unlock(&sm750_dev->slock);
>+	} else {
>+		sm750_dev->accel.de_fillrect(&sm750_dev->accel,
>+					     base, pitch, Bpp,
>+					     region->dx, region->dy,
>+					     region->width, region->height,
>+					     color, rop);
>+	}
>+
> }
> 
> static void lynxfb_ops_copyarea(struct fb_info *info,
>@@ -220,16 +228,24 @@ static void lynxfb_ops_copyarea(struct fb_info
>*info,
> 	 * If not use spin_lock, system will die if user load driver
> 	 * and immediately unload driver frequently (dual)
> 	 */
>-	if (sm750_dev->fb_count > 1)
>+	if (sm750_dev->fb_count > 1) {
> 		spin_lock(&sm750_dev->slock);
> 
>-	sm750_dev->accel.de_copyarea(&sm750_dev->accel,
>-				     base, pitch, region->sx, region->sy,
>-				     base, pitch, Bpp, region->dx, region->dy,
>-				     region->width, region->height,
>-				     HW_ROP2_COPY);
>-	if (sm750_dev->fb_count > 1)
>+		sm750_dev->accel.de_copyarea(&sm750_dev->accel,
>+					     base, pitch, region->sx, region->sy,
>+					     base, pitch, Bpp, region->dx, region->dy,
>+					     region->width, region->height,
>+					     HW_ROP2_COPY);
>+
> 		spin_unlock(&sm750_dev->slock);
>+	} else {
>+		sm750_dev->accel.de_copyarea(&sm750_dev->accel,
>+					     base, pitch, region->sx, region->sy,
>+					     base, pitch, Bpp, region->dx, region->dy,
>+					     region->width, region->height,
>+					     HW_ROP2_COPY);
>+	}
>+
> }
> 
> static void lynxfb_ops_imageblit(struct fb_info *info,
>@@ -269,17 +285,26 @@ static void lynxfb_ops_imageblit(struct fb_info
>*info,
> 	 * If not use spin_lock, system will die if user load driver
> 	 * and immediately unload driver frequently (dual)
> 	 */
>-	if (sm750_dev->fb_count > 1)
>+	if (sm750_dev->fb_count > 1) {
> 		spin_lock(&sm750_dev->slock);
> 
>-	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
>-				      image->data, image->width >> 3, 0,
>-				      base, pitch, Bpp,
>-				      image->dx, image->dy,
>-				      image->width, image->height,
>-				      fgcol, bgcol, HW_ROP2_COPY);
>-	if (sm750_dev->fb_count > 1)
>+		sm750_dev->accel.de_imageblit(&sm750_dev->accel,
>+					      image->data, image->width >> 3, 0,
>+					      base, pitch, Bpp,
>+					      image->dx, image->dy,
>+					      image->width, image->height,
>+					      fgcol, bgcol, HW_ROP2_COPY);
>+
> 		spin_unlock(&sm750_dev->slock);
>+	} else {
>+		sm750_dev->accel.de_imageblit(&sm750_dev->accel,
>+					      image->data, image->width >> 3, 0,
>+					      base, pitch, Bpp,
>+					      image->dx, image->dy,
>+					      image->width, image->height,
>+					      fgcol, bgcol, HW_ROP2_COPY);
>+	}
>+
> }
> 
> static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,

I believe a similar change has been NACKed on the basis that you're duplicating code to work around some warning a tool generated. I think we should always take the lock, if we do anything about this. Since it's a spin lock, the penalty should not be very high. 

Frans 
