From: Erik Gilling <konkers@google.com>
Date: Fri, 20 Aug 2010 07:23:21 +0000
Subject: Re: [PATCH] fbdev: add a function to parse further EDID Detailed
Message-Id: <AANLkTinYiY7=qLEmLe80+bwsUnxssidhHrLgDR4+fgy1@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1008200847020.6103@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1008200847020.6103@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Guennadi,
    Not sure how you're using the edid but you can get all 4 DTDs by
calling fb_edid_to_monspecs() then calling fb_videomode_to_var() on
each of the entries in monspecs.modedb.  This is still lacking as
modern monitors/tvs can have multiple EDID blocks.  My recent patch
[1] is a proposal for addressing that.

Cheers,
    Erik

[1] http://marc.info/?l=3Dlinux-fbdev&m=128208740412602&w=3D2

On Thu, Aug 19, 2010 at 11:48 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Currently a function is available to parse the first EDID Detailed Timing
> Descriptor (DTD) block. However, EDID can contain up to four DTDs. Add a
> function to parse further DTDs.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0drivers/video/fbmon.c | =A0 74 ++++++++++++++++++++++++++++++++++++---=
---------
> =A0include/linux/fb.h =A0 =A0| =A0 =A02 +
> =A02 files changed, 57 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
> index 563a98b..03de586 100644
> --- a/drivers/video/fbmon.c
> +++ b/drivers/video/fbmon.c
> @@ -866,6 +866,29 @@ static void get_monspecs(unsigned char *edid, struct=
 fb_monspecs *specs)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static void fb_edid_to_var(unsigned char *block, struct fb_var_screeninf=
o *var)
> +{
> + =A0 =A0 =A0 var->xres =3D var->xres_virtual =3D H_ACTIVE;
> + =A0 =A0 =A0 var->yres =3D var->yres_virtual =3D V_ACTIVE;
> + =A0 =A0 =A0 var->height =3D var->width =3D 0;
> + =A0 =A0 =A0 var->right_margin =3D H_SYNC_OFFSET;
> + =A0 =A0 =A0 var->left_margin =3D (H_ACTIVE + H_BLANKING) -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH);
> + =A0 =A0 =A0 var->upper_margin =3D V_BLANKING - V_SYNC_OFFSET -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 V_SYNC_WIDTH;
> + =A0 =A0 =A0 var->lower_margin =3D V_SYNC_OFFSET;
> + =A0 =A0 =A0 var->hsync_len =3D H_SYNC_WIDTH;
> + =A0 =A0 =A0 var->vsync_len =3D V_SYNC_WIDTH;
> + =A0 =A0 =A0 var->pixclock =3D PIXEL_CLOCK;
> + =A0 =A0 =A0 var->pixclock /=3D 1000;
> + =A0 =A0 =A0 var->pixclock =3D KHZ2PICOS(var->pixclock);
> +
> + =A0 =A0 =A0 if (HSYNC_POSITIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->sync |=3D FB_SYNC_HOR_HIGH_ACT;
> + =A0 =A0 =A0 if (VSYNC_POSITIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->sync |=3D FB_SYNC_VERT_HIGH_ACT;
> +}
> +
> =A0int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
> =A0{
> =A0 =A0 =A0 =A0int i;
> @@ -884,31 +907,38 @@ int fb_parse_edid(unsigned char *edid, struct fb_va=
r_screeninfo *var)
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < 4; i++, block +=3D DETAILED_TIMING_DESCR=
IPTION_SIZE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (edid_is_timing_block(block)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->xres =3D var->xres_vir=
tual =3D H_ACTIVE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->yres =3D var->yres_vir=
tual =3D V_ACTIVE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->height =3D var->width =
=3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->right_margin =3D H_SYN=
C_OFFSET;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->left_margin =3D (H_ACT=
IVE + H_BLANKING) -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (H_ACTIVE +=
 H_SYNC_OFFSET + H_SYNC_WIDTH);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->upper_margin =3D V_BLA=
NKING - V_SYNC_OFFSET -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 V_SYNC_WIDT=
H;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->lower_margin =3D V_SYN=
C_OFFSET;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->hsync_len =3D H_SYNC_W=
IDTH;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->vsync_len =3D V_SYNC_W=
IDTH;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->pixclock =3D PIXEL_CLO=
CK;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->pixclock /=3D 1000;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->pixclock =3D KHZ2PICOS=
(var->pixclock);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (HSYNC_POSITIVE)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->sync |=
=3D FB_SYNC_HOR_HIGH_ACT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (VSYNC_POSITIVE)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var->sync |=
=3D FB_SYNC_VERT_HIGH_ACT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb_edid_to_var(block, var);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 1;
> =A0}
>
> +int fb_parse_edid_index(unsigned char *edid, struct fb_var_screeninfo *v=
ar,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int idx)
> +{
> + =A0 =A0 =A0 unsigned char *block;
> +
> + =A0 =A0 =A0 if (edid =3D NULL || var =3D NULL || idx > 3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> +
> + =A0 =A0 =A0 if (!(edid_checksum(edid)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> +
> + =A0 =A0 =A0 if (!(edid_check_header(edid)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> +
> + =A0 =A0 =A0 block =3D edid + DETAILED_TIMING_DESCRIPTIONS_START +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx * DETAILED_TIMING_DESCRIPTION_SIZE;
> +
> + =A0 =A0 =A0 if (edid_is_timing_block(block)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb_edid_to_var(block, var);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> =A0void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *spec=
s)
> =A0{
> =A0 =A0 =A0 =A0unsigned char *block;
> @@ -1285,6 +1315,11 @@ int fb_parse_edid(unsigned char *edid, struct fb_v=
ar_screeninfo *var)
> =A0{
> =A0 =A0 =A0 =A0return 1;
> =A0}
> +int fb_parse_edid_index(unsigned char *edid, struct fb_var_screeninfo *v=
ar,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int idx)
> +{
> + =A0 =A0 =A0 return 1;
> +}
> =A0void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *spec=
s)
> =A0{
> =A0 =A0 =A0 =A0specs =3D NULL;
> @@ -1395,6 +1430,7 @@ const unsigned char *fb_firmware_edid(struct device=
 *device)
> =A0EXPORT_SYMBOL(fb_firmware_edid);
>
> =A0EXPORT_SYMBOL(fb_parse_edid);
> +EXPORT_SYMBOL(fb_parse_edid_index);
> =A0EXPORT_SYMBOL(fb_edid_to_monspecs);
> =A0EXPORT_SYMBOL(fb_get_mode);
> =A0EXPORT_SYMBOL(fb_validate_mode);
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index f0268de..3649c47 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -1083,6 +1083,8 @@ extern int fb_get_mode(int flags, u32 val, struct f=
b_var_screeninfo *var,
> =A0extern int fb_validate_mode(const struct fb_var_screeninfo *var,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct fb_info *in=
fo);
> =A0extern int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo=
 *var);
> +extern int fb_parse_edid_index(unsigned char *edid, struct fb_var_screen=
info *var,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int=
 idx);
> =A0extern const unsigned char *fb_firmware_edid(struct device *device);
> =A0extern void fb_edid_to_monspecs(unsigned char *edid,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct fb_=
monspecs *specs);
> --
> 1.7.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
