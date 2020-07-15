From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 15 Jul 2020 15:12:20 +0000
Subject: Re: [PATCH v2] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
Message-Id: <20200715151220.GE2571@kadam>
List-Id: <linux-fbdev.vger.kernel.org>
References: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
 <20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200715094836.GD2571@kadam>
 <9e6eac10-c5c3-f518-36cc-9ea32fb5d7fe@i-love.sakura.ne.jp>
 <b50f85c7-80e5-89c5-0aca-31d8e9892665@i-love.sakura.ne.jp>
In-Reply-To: <b50f85c7-80e5-89c5-0aca-31d8e9892665@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, George Kennedy <george.kennedy@oracle.com>, Jiri Slaby <jslaby@suse.com>, Dmitry Vyukov <dvyukov@google.com>

On Wed, Jul 15, 2020 at 11:02:58PM +0900, Tetsuo Handa wrote:
> On 2020/07/15 20:17, Tetsuo Handa wrote:
> > On 2020/07/15 18:48, Dan Carpenter wrote:
> >>> @@ -216,7 +216,7 @@ static void bit_clear_margins(struct vc_data *vc,=
 struct fb_info *info,
> >>>  	region.color =3D color;
> >>>  	region.rop =3D ROP_COPY;
> >>> =20
> >>> -	if (rw && !bottom_only) {
> >>> +	if ((int) rw > 0 && !bottom_only) {
> >>>  		region.dx =3D info->var.xoffset + rs;
> >>                             ^^^^^^^^^^^^^^^^^^^^^^
> >>
> >> If you choose a very high positive "rw" then this addition can overflo=
w.
> >> info->var.xoffset comes from the user and I don't think it's checked...
> >=20
> > Well, I think it would be checked by "struct fb_ops"->check_var hook.
> > For example, vmw_fb_check_var() has
> >=20
> > 	if ((var->xoffset + var->xres) > par->max_width ||
> > 	    (var->yoffset + var->yres) > par->max_height) {
> > 		DRM_ERROR("Requested geom can not fit in framebuffer\n");
> > 		return -EINVAL;
> > 	}
> >=20
> > check. Of course, there might be integer overflow in that check...
> > Having sanity check at caller of "struct fb_ops"->check_var might be ni=
ce.
> >=20
>=20
> Well, while
>=20
>         const int fd =3D open("/dev/fb0", O_ACCMODE);
>         struct fb_var_screeninfo var =3D { };
>         ioctl(fd, FBIOGET_VSCREENINFO, &var);
>         var.xres =3D var.yres =3D 4;
>         var.xoffset =3D 4294967292U;
>         ioctl(fd, FBIOPUT_VSCREENINFO, &var);
>=20
> bypassed
>=20
>   (var->xoffset + var->xres) > par->max_width
>=20
> check in vmw_fb_check_var(),
>=20
> ----------
> --- a/drivers/video/fbdev/core/bitblit.c
> +++ b/drivers/video/fbdev/core/bitblit.c
> @@ -216,6 +216,7 @@ static void bit_clear_margins(struct vc_data *vc, str=
uct fb_info *info,
>         region.color =3D color;
>         region.rop =3D ROP_COPY;
>=20
> +       printk(KERN_INFO "%s info->var.xoffset=3D%u rs=3D%u info->var.yof=
fset=3D%u bs=3D%u\n", __func__, info->var.xoffset, rs, info->var.yoffset, b=
s);
>         if ((int) rw > 0 && !bottom_only) {
>                 region.dx =3D info->var.xoffset + rs;
>                 region.dy =3D 0;
> ----------
>=20
> says that info->var.xoffset does not come from the user.
>=20
> ----------
>  bit_clear_margins info->var.xoffset=3D0 rs=1024 info->var.yoffset=3D0 bs=
=800
> ----------

In fb_set_var() we do:

drivers/video/fbdev/core/fbmem.c
  1055          ret =3D info->fbops->fb_check_var(var, info);
  1056 =20
  1057          if (ret)
  1058                  return ret;
  1059 =20
  1060          if ((var->activate & FB_ACTIVATE_MASK) !=3D FB_ACTIVATE_NOW)
  1061                  return 0;
  1062 =20
  1063          if (!basic_checks(var))
  1064                  return -EINVAL;
  1065 =20
  1066          if (info->fbops->fb_get_caps) {
  1067                  ret =3D fb_check_caps(info, var, var->activate);
  1068 =20
  1069                  if (ret)
  1070                          return ret;
  1071          }
  1072 =20
  1073          old_var =3D info->var;
  1074          info->var =3D *var;
                ^^^^^^^^^^^^^^^^
This should set "info->var.offset".

  1075 =20
  1076          if (info->fbops->fb_set_par) {
  1077                  ret =3D info->fbops->fb_set_par(info);
  1078 =20
  1079                  if (ret) {
  1080                          info->var =3D old_var;
  1081                          printk(KERN_WARNING "detected "

I've complained about integer overflows in fbdev for a long time...

What I'd like to see is something like the following maybe.  I don't
know how to get the vc_data in fbmem.c so it doesn't include your checks
for negative.

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fb=
mem.c
index caf817bcb05c..5c74181fea5d 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -934,6 +934,54 @@ fb_pan_display(struct fb_info *info, struct fb_var_scr=
eeninfo *var)
 }
 EXPORT_SYMBOL(fb_pan_display);
=20
+static bool basic_checks(struct fb_var_screeninfo *var)
+{
+	unsigned int v_margins, h_margins;
+
+	/* I think var->height and var->width =3D UINT_MAX means something. */
+
+	if (var->xres > INT_MAX ||
+	    var->yres > INT_MAX ||
+	    var->xres_virtual > INT_MAX ||
+	    var->yres_virtual > INT_MAX ||
+	    var->xoffset > INT_MAX ||
+	    var->yoffset > INT_MAX ||
+	    var->left_margin > INT_MAX ||
+	    var->right_margin > INT_MAX ||
+	    var->upper_margin > INT_MAX ||
+	    var->lower_margin > INT_MAX ||
+	    var->hsync_len > INT_MAX ||
+	    var->vsync_len > INT_MAX)
+		return false;
+
+	if (var->bits_per_pixel > 128)
+		return false;
+	if (var->rotate > FB_ROTATE_CCW)
+		return false;
+
+	if (var->xoffset > INT_MAX - var->xres)
+		return false;
+	if (var->yoffset > INT_MAX - var->yres)
+		return false;
+
+	if (var->left_margin > INT_MAX - var->right_margin ||
+	    var->upper_margin > INT_MAX - var->lower_margin)
+		return false;
+
+	v_margins =3D var->left_margin + var->right_margin;
+	h_margins =3D var->upper_margin + var->lower_margin;
+
+	if (var->xres > INT_MAX - var->hsync_len ||
+	    var->yres > INT_MAX - var->vsync_len)
+		return false;
+
+	if (v_margins > INT_MAX - var->hsync_len - var->xres ||
+	    h_margins > INT_MAX - var->vsync_len - var->yres)
+		return false;
+
+	return true;
+}
+
 static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *v=
ar,
 			 u32 activate)
 {
@@ -1012,6 +1060,9 @@ fb_set_var(struct fb_info *info, struct fb_var_screen=
info *var)
 	if ((var->activate & FB_ACTIVATE_MASK) !=3D FB_ACTIVATE_NOW)
 		return 0;
=20
+	if (!basic_checks(var))
+		return -EINVAL;
+
 	if (info->fbops->fb_get_caps) {
 		ret =3D fb_check_caps(info, var, var->activate);
=20
