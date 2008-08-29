From: Takashi Yoshii <yoshii.takashi@renesas.com>
Subject: [PATCH] Add fb_check_var() for fixed mode
	device.
Date: Fri, 29 Aug 2008 14:15:06 +0900
Message-ID: <48B785DA.1030408@renesas.com>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin> <g94i4r$2hq$1@ger.gmane.org>
	<20080828074521.GO16680@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYwKM-0004rT-8E for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 22:15:18 -0700
Received: from mail.renesas.com ([202.234.163.13] helo=mail01.idc.renesas.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYwKJ-0000Uj-Dx
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 22:15:16 -0700
In-reply-to: <20080828074521.GO16680@sci.fi>
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
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net

Sounds good.
> 4. Provide a generic check_var() that does some basic sanity checking
> against info->var (eg. check xres, yres and bits_per_pixel).
How about this.
Any comments? Expecially about what to check, what to restore.

Cheers,
/yoshii # Restoring pixclock would be a workaround for Xorg issue :)

drivers/video/fbmem.c:fb_check_var()
 New function for fixed mode device which doesn't provide its own
 check_var function.

Signed-off-by: Takashi YOSHII <yoshii.takashi@renesas.com>

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index c6b8e92..ff94eaf 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -904,6 +904,56 @@ static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
 	return err;
 }
 
+/* Sanity check for drivers which can't change video mode */
+static int
+fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct fb_var_screeninfo *constant = &info->var;
+        __u32 xoffset = var->xoffset;
+	__u32 yoffset = var->yoffset;
+	__u32 activate = var->activate;
+	__u32 yres = (constant->vmode & FB_VMODE_YWRAP)? 0: var->yres; 
+
+	/* do round _up_ */
+	if (var->xres_virtual < xoffset + var->xres)
+		var->xres_virtual = xoffset + var->xres;
+	if (var->yres_virtual < yoffset + yres)
+		var->yres_virtual = yoffset + yres;
+
+	/* bigger is error, smaller is OK */
+	if( ( var->xres > constant->xres )
+	  ||( var->yres > constant->yres )
+	  ||( var->xres_virtual > constant->xres_virtual )
+	  ||( var->yres_virtual > constant->yres_virtual ))
+		return -EINVAL;
+
+	/* only length are checked for bitfields */
+	if( ( var->bits_per_pixel > constant->bits_per_pixel )
+	  ||( var->red.length > constant->red.length )
+	  ||( var->green.length > constant->green.length )
+	  ||( var->blue.length > constant->blue.length ))
+		return -EINVAL;
+
+	/* boolean parameters can't be rounded, should be equal */
+	if( ( !var->grayscale != !constant->grayscale )
+	  ||( !var->nonstd != !constant->nonstd )
+	  ||( var->vmode != constant->vmode ))
+		return -EINVAL;
+
+	/* pan is acceptable only if we have fb_pan_display) */
+	if ( (var->yoffset || var->xoffset) && !info->fbops->fb_pan_display )
+		return -EINVAL;
+
+	/* copy most */
+	*var = *constant;
+	/* resotore some that are not a part of viede mode */
+	var->xoffset = xoffset;
+	var->yoffset = yoffset;
+	var->activate = activate;
+
+	return 0;
+}
+
 int
 fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 {
@@ -940,9 +990,11 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 
 		if (info->fbops->fb_check_var) {
 			ret = info->fbops->fb_check_var(var, info);
-			if (ret)
-				goto done;
-		}
+		} else
+			ret = fb_check_var(var, info);
+
+		if (ret)
+			goto done;
 
 		if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
 			struct fb_videomode mode;


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
