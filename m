From: Takashi Yoshii <yoshii.takashi@renesas.com>
Subject: [PATCH] Add fb_check_var() for fixed mode
	device.
Date: Thu, 04 Sep 2008 10:56:12 +0900
Message-ID: <48BF403C.8040109@renesas.com>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin> <g94i4r$2hq$1@ger.gmane.org>
	<20080828074521.GO16680@sci.fi> <48B785DA.1030408@renesas.com>
	<Pine.LNX.4.64.0808290906370.22326@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kb45P-0002mU-Gq for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 18:56:39 -0700
Received: from mail.renesas.com ([202.234.163.13] helo=mail02.idc.renesas.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kb45N-00006Y-Vu
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 18:56:39 -0700
In-reply-to: <Pine.LNX.4.64.0808290906370.22326@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net

Take 2.

This adds sanitizing. But main effect is, as a result, adding
 FBIOPUT_VSCREENINFO on fixed mode device following functionality.
. return error when request screen is bigger than the fixed mode.
. round pan values if invalid
. do set pan
same as drivers which has own check_var.

>> > > +	/* do round _up_ */
>> > > +	if (var->xres_virtual < xoffset + var->xres)
>> > > +		var->xres_virtual = xoffset + var->xres;
>> > > +	if (var->yres_virtual < yoffset + yres)
>> > > +		var->yres_virtual = yoffset + yres;
> > 
> > Why this part? var->[xy]res{,_virtual} will be overwritten by the
> > correct values later anyway.
This was to a part of pan check rounding [xy]res_virtual up instead of
 rounding [xy]offset down, and check them in lines below there.
But as you pointed, it's weired for this(checking against constants) case.

> > +	/* pan is acceptable only if we have fb_pan_display) */
> > +	if ( (var->yoffset || var->xoffset) && !info->fbops->fb_pan_display )
> > +		return -EINVAL;
I changed this non-error, but resetting pan values with info->var.
This supports HW which can't change pan but have initial fixed offsets.
# So far, not in kernel source, though.

> > You should validate var->[xy]offset against constant->[xy]res_virtual
> > and info->fix.[xy]{pan,wrap}step.
I add explicit rounding down code this time, instead of returning error.
I am not sure which is right. But because I found 10 drivers round them down,
 6 return error, 2 set const value. 
# and 80 (20(with pan) + 60(no pan)) ignore them.

/yoshii

drivers/video/fbmem.c:fb_check_var(): New function
 for fixed mode device which doesn't provide its own check_var function.
   
Signed-off-by: Takashi YOSHII <yoshii.takashi@renesas.com>
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index c6b8e92..243e5f4 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -904,6 +904,68 @@ static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
 	return err;
 }
 
+/* Sanity check for drivers which can't change video mode */
+static int
+fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct fb_var_screeninfo *constant = &info->var;
+	struct fb_fix_screeninfo *fix = &info->fix;
+	__u32 xoffset = var->xoffset;
+	__u32 yoffset = var->yoffset;
+	__u32 activate = var->activate;
+	__u32 ywrap = var->vmode & FB_VMODE_YWRAP;
+
+	/* Bigger is error, smaller is OK */
+	if ((var->xres > constant->xres) ||
+	    (var->yres > constant->yres) ||
+	    (var->xres_virtual > constant->xres_virtual) ||
+	    (var->yres_virtual > constant->yres_virtual))
+		return -EINVAL;
+
+	/* Ohly length are checked for bitfields */
+	if ((var->bits_per_pixel > constant->bits_per_pixel) ||
+	    (var->red.length > constant->red.length) ||
+	    (var->green.length > constant->green.length) ||
+	    (var->blue.length > constant->blue.length))
+		return -EINVAL;
+
+	/* Boolean parameters can't be rounded, should be equal */
+	if ((!var->grayscale != !constant->grayscale) ||
+	    (!var->nonstd != !constant->nonstd) ||
+	    ((var->vmode ^ constant->vmode) &~FB_VMODE_YWRAP))
+		return -EINVAL;
+
+	/* round offsets */
+	if (xoffset > constant->xres_virtual - constant->xres)
+		xoffset = constant->xres_virtual - constant->xres;
+	if (fix->xpanstep)
+		xoffset -= (var->xoffset % fix->xpanstep);
+
+	if (ywrap) {
+		if (yoffset > constant->yres_virtual -1)
+			yoffset = constant->yres_virtual -1;
+		if (fix->ywrapstep)
+			yoffset -= (yoffset % fix->ywrapstep);
+	} else {
+		if (yoffset > constant->yres_virtual - constant->yres)
+			yoffset = constant->yres_virtual - constant->yres;
+		if (fix->ypanstep)
+			yoffset -= (yoffset % fix->ypanstep);
+	}
+
+	/* Copy most */
+	*var = *constant;
+	/* Restore some that are not a part of video mode */
+	var->activate = activate;
+	/*  You can't alter pan parameters without fb_pan_display() */
+	if ( info->fbops->fb_pan_display ) {
+		var->xoffset = xoffset;
+		var->yoffset = yoffset;
+		var->vmode = (constant->vmode &~FB_VMODE_YWRAP) | ywrap;
+	}
+	return 0;
+}
+
 int
 fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 {
@@ -940,9 +1002,11 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 
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
