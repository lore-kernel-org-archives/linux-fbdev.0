From: Mandeep Singh Baines <msb@chromium.org>
Date: Mon, 20 Jun 2011 22:15:13 +0000
Subject: Regression in panic
Message-Id: <BANLkTingstCoWk0H20nN1J7t3H=mndSdnL2YpeW2R46fhL2kpA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Dave Airlie <airlied@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Olof Johansson <olofj@chromium.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.sf.net, linux-kernel@vger.kernel.org

On Tue, Jun 22, 2010 at 8:12 PM, Dave Airlie <airlied@gmail.com> wrote:
> From: Jesse Barnes <jbarnes@virtuousgeek.org>
>
> Jesse's initial patch commit said:
>
> "At panic time (i.e. when oops_in_progress is set) we should try a bit
> harder to update the screen and make sure output gets to the VT, since
> some drivers are capable of flipping back to it.
>
> So make sure we try to unblank and update the display if called from a
> panic context."
>
> I've enhanced this to add a flag to the vc that console layer can set
> to indicate they want this behaviour to occur. This also adds support
> to fbcon for that flag and adds an fb flag for drivers to indicate
> they want to use the support. It enables this for KMS drivers.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>

Hi Dave,

I think this change is causing a regression I'm seeing in panic.
Before this change, I'd get a
reboot on panic (we've configured as such).

With this change, my machine gets wedged if the machine is running in
X when the panic occurs.

I traced the code flow to this:

bust_spinlocks(0);
 ->unblank_screen();
   ->do_unblank_screen(0);
     ->vc->vc_sw->con_blank(vc, 0, 0);
       ->fbcon_blank(vc, 0, 0);
         ->update_screen(vc);
           ->redraw_screen(vc, 0);
             ->vc->vc_sw->con_switch(vc);
               ->fbcon_switch(vc);
                 ->ops->update_start(info);
                   ->bit_update_start(info);
                    ->fb_pan_display(info, &ops->var);
                      ->info->fbops->fb_pan_display(var, info);
                        ->drm_fb_helper_pan_display(var, info);
                          ->mutex_lock(&dev->mode_config.mutex); *this bloc=
ks*

With this change, there is now a lot going on in the panic path. Stuff
that I'm not sure is safe when panicking. In addition to the
mutex_lock, there is also a del_timer_sync()
now happening in the context of panic().

I see this bug with a 2.6.38 kernel but did a quick scan of a newer
kernels and did not see anything that changed in this path so I
suspect its still there.

Reverting this change fixes the regression.

Regards,
Mandeep

> ---
> =A0drivers/char/vt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 13=
 +++++++++----
> =A0drivers/gpu/drm/i915/intel_fb.c =A0 =A0 =A0 =A0 | =A0 =A04 +---
> =A0drivers/gpu/drm/nouveau/nouveau_fbcon.c | =A0 =A01 +
> =A0drivers/gpu/drm/radeon/radeon_fb.c =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/video/console/fbcon.c =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +++-
> =A0include/linux/console_struct.h =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0include/linux/fb.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A04 ++++
> =A0include/linux/vt_kern.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A07 +++=
++++
> =A08 files changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/char/vt.c b/drivers/char/vt.c
> index 7cdb6ee..6e04c9e 100644
> --- a/drivers/char/vt.c
> +++ b/drivers/char/vt.c
> @@ -698,7 +698,10 @@ void redraw_screen(struct vc_data *vc, int is_switch)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0update_attr(vc);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clear_buffer_attributes(vc=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (update && vc->vc_mode !=3D KD_GRAPHICS)
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Forcibly update if we're panicing */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((update && vc->vc_mode !=3D KD_GRAPHICS=
) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vt_force_oops_output(vc))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do_update_region(vc, vc->v=
c_origin, vc->vc_screenbuf_size / 2);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0set_cursor(vc);
> @@ -736,6 +739,7 @@ static void visual_init(struct vc_data *vc, int num, =
int init)
> =A0 =A0 =A0 =A0vc->vc_hi_font_mask =3D 0;
> =A0 =A0 =A0 =A0vc->vc_complement_mask =3D 0;
> =A0 =A0 =A0 =A0vc->vc_can_do_color =3D 0;
> + =A0 =A0 =A0 vc->vc_panic_force_write =3D false;
> =A0 =A0 =A0 =A0vc->vc_sw->con_init(vc, init);
> =A0 =A0 =A0 =A0if (!vc->vc_complement_mask)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vc->vc_complement_mask =3D vc->vc_can_do_c=
olor ? 0x7700 : 0x0800;
> @@ -2498,7 +2502,7 @@ static void vt_console_print(struct console *co, co=
nst char *b, unsigned count)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto quit;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (vc->vc_mode !=3D KD_TEXT)
> + =A0 =A0 =A0 if (vc->vc_mode !=3D KD_TEXT && !vt_force_oops_output(vc))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto quit;
>
> =A0 =A0 =A0 =A0/* undraw cursor first */
> @@ -3703,7 +3707,8 @@ void do_unblank_screen(int leaving_gfx)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0vc =3D vc_cons[fg_console].d;
> - =A0 =A0 =A0 if (vc->vc_mode !=3D KD_TEXT)
> + =A0 =A0 =A0 /* Try to unblank in oops case too */
> + =A0 =A0 =A0 if (vc->vc_mode !=3D KD_TEXT && !vt_force_oops_output(vc))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return; /* but leave console_blanked !=3D =
0 */
>
> =A0 =A0 =A0 =A0if (blankinterval) {
> @@ -3712,7 +3717,7 @@ void do_unblank_screen(int leaving_gfx)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0console_blanked =3D 0;
> - =A0 =A0 =A0 if (vc->vc_sw->con_blank(vc, 0, leaving_gfx))
> + =A0 =A0 =A0 if (vc->vc_sw->con_blank(vc, 0, leaving_gfx) || vt_force_oo=
ps_output(vc))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Low-level driver cannot restore -> do i=
t ourselves */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0update_screen(vc);
> =A0 =A0 =A0 =A0if (console_blank_hook)
> diff --git a/drivers/gpu/drm/i915/intel_fb.c b/drivers/gpu/drm/i915/intel=
_fb.c
> index c3c5052..bd5d87a 100644
> --- a/drivers/gpu/drm/i915/intel_fb.c
> +++ b/drivers/gpu/drm/i915/intel_fb.c
> @@ -128,7 +128,7 @@ static int intelfb_create(struct intel_fbdev *ifbdev,
>
> =A0 =A0 =A0 =A0strcpy(info->fix.id, "inteldrmfb");
>
> - =A0 =A0 =A0 info->flags =3D FBINFO_DEFAULT;
> + =A0 =A0 =A0 info->flags =3D FBINFO_DEFAULT | FBINFO_CAN_FORCE_OUTPUT;
> =A0 =A0 =A0 =A0info->fbops =3D &intelfb_ops;
>
> =A0 =A0 =A0 =A0/* setup aperture base/size for vesafb takeover */
> @@ -146,8 +146,6 @@ static int intelfb_create(struct intel_fbdev *ifbdev,
> =A0 =A0 =A0 =A0info->fix.smem_start =3D dev->mode_config.fb_base + obj_pr=
iv->gtt_offset;
> =A0 =A0 =A0 =A0info->fix.smem_len =3D size;
>
> - =A0 =A0 =A0 info->flags =3D FBINFO_DEFAULT;
> -
> =A0 =A0 =A0 =A0info->screen_base =3D ioremap_wc(dev->agp->base + obj_priv=
->gtt_offset,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 size);
> =A0 =A0 =A0 =A0if (!info->screen_base) {
> diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/no=
uveau/nouveau_fbcon.c
> index c9a4a0d..9b2d3b7 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
> @@ -250,6 +250,7 @@ nouveau_fbcon_create(struct nouveau_fbdev *nfbdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->flags =3D FBINFO_DEFAULT | FBINFO_HW=
ACCEL_COPYAREA |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FBINFO_HWACCEL=
_FILLRECT |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FBINFO_HWACCEL=
_IMAGEBLIT;
> + =A0 =A0 =A0 info->flags |=3D FBINFO_CAN_FORCE_OUTPUT;
> =A0 =A0 =A0 =A0info->fbops =3D &nouveau_fbcon_ops;
> =A0 =A0 =A0 =A0info->fix.smem_start =3D dev->mode_config.fb_base + nvbo->=
bo.offset -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_priv->vm_=
vram_base;
> diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/=
radeon_fb.c
> index dc1634b..dbf8696 100644
> --- a/drivers/gpu/drm/radeon/radeon_fb.c
> +++ b/drivers/gpu/drm/radeon/radeon_fb.c
> @@ -224,7 +224,7 @@ static int radeonfb_create(struct radeon_fbdev *rfbde=
v,
>
> =A0 =A0 =A0 =A0drm_fb_helper_fill_fix(info, fb->pitch, fb->depth);
>
> - =A0 =A0 =A0 info->flags =3D FBINFO_DEFAULT;
> + =A0 =A0 =A0 info->flags =3D FBINFO_DEFAULT | FBINFO_CAN_FORCE_OUTPUT;
> =A0 =A0 =A0 =A0info->fbops =3D &radeonfb_ops;
>
> =A0 =A0 =A0 =A0tmp =3D radeon_bo_gpu_offset(rbo) - rdev->mc.vram_start;
> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> index b0a3fa0..7eadb35 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -283,7 +283,8 @@ static inline int fbcon_is_inactive(struct vc_data *v=
c, struct fb_info *info)
> =A0 =A0 =A0 =A0struct fbcon_ops *ops =3D info->fbcon_par;
>
> =A0 =A0 =A0 =A0return (info->state !=3D FBINFO_STATE_RUNNING ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vc->vc_mode !=3D KD_TEXT || ops->graphics);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vc->vc_mode !=3D KD_TEXT || ops->graphics) =
&&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 !vt_force_oops_output(vc);
> =A0}
>
> =A0static inline int get_color(struct vc_data *vc, struct fb_info *info,
> @@ -1073,6 +1074,7 @@ static void fbcon_init(struct vc_data *vc, int init)
> =A0 =A0 =A0 =A0if (p->userfont)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0charcnt =3D FNTCHARCNT(p->fontdata);
>
> + =A0 =A0 =A0 vc->vc_panic_force_write =3D !!(info->flags & FBINFO_CAN_FO=
RCE_OUTPUT);
> =A0 =A0 =A0 =A0vc->vc_can_do_color =3D (fb_get_color_depth(&info->var, &i=
nfo->fix)!=3D1);
> =A0 =A0 =A0 =A0vc->vc_complement_mask =3D vc->vc_can_do_color ? 0x7700 : =
0x0800;
> =A0 =A0 =A0 =A0if (charcnt =3D 256) {
> diff --git a/include/linux/console_struct.h b/include/linux/console_struc=
t.h
> index 38fe59d..d7d9acd 100644
> --- a/include/linux/console_struct.h
> +++ b/include/linux/console_struct.h
> @@ -105,6 +105,7 @@ struct vc_data {
> =A0 =A0 =A0 =A0struct vc_data **vc_display_fg; =A0 =A0 =A0 =A0 /* [!] Ptr=
 to var holding fg console for this display */
> =A0 =A0 =A0 =A0unsigned long =A0 vc_uni_pagedir;
> =A0 =A0 =A0 =A0unsigned long =A0 *vc_uni_pagedir_loc; =A0/* [!] Location =
of uni_pagedir variable for this console */
> + =A0 =A0 =A0 bool vc_panic_force_write; /* when oops/panic this VC can a=
ccept forced output/blanking */
> =A0 =A0 =A0 =A0/* additional information is in vt_kern.h */
> =A0};
>
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 8e5a9df..25f4950 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -812,6 +812,10 @@ struct fb_tile_ops {
> =A0*/
> =A0#define FBINFO_BE_MATH =A00x100000
>
> +/* report to the VT layer that this fb driver can accept forced console
> + =A0 output like oopses */
> +#define FBINFO_CAN_FORCE_OUTPUT =A0 =A0 0x200000
> +
> =A0struct fb_info {
> =A0 =A0 =A0 =A0int node;
> =A0 =A0 =A0 =A0int flags;
> diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
> index 7f56db4..56cce34 100644
> --- a/include/linux/vt_kern.h
> +++ b/include/linux/vt_kern.h
> @@ -100,6 +100,13 @@ extern int unbind_con_driver(const struct consw *csw=
, int first, int last,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int deflt);
> =A0int vty_init(const struct file_operations *console_fops);
>
> +static inline bool vt_force_oops_output(struct vc_data *vc)
> +{
> + =A0 =A0 =A0 if (oops_in_progress && vc->vc_panic_force_write)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> + =A0 =A0 =A0 return false;
> +}
> +
> =A0/*
> =A0* vc_screen.c shares this temporary buffer with the console write code=
 so that
> =A0* we can easily avoid touching user space while holding the console sp=
inlock.
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
