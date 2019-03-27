From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 27 Mar 2019 09:37:46 +0000
Subject: Re: [PATCH 09/11] drm/fbdevdrm: Add primary plane
Message-Id: <ad4c06f7-d429-a453-fb95-44b96e17a1db@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UF1siukkECKI54ONYNG6TsgDx0JxM6W4M"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326091744.11542-10-tzimmermann@suse.de>
 <CA+7wUsw4s3cLyqFP7-CkV38kRuwRDpmzJaKim4L-Cg2C4HP0uA@mail.gmail.com>
In-Reply-To: <CA+7wUsw4s3cLyqFP7-CkV38kRuwRDpmzJaKim4L-Cg2C4HP0uA@mail.gmail.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: David Airlie <airlied@linux.ie>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UF1siukkECKI54ONYNG6TsgDx0JxM6W4M
Content-Type: multipart/mixed; boundary="1fmQUIgQMC51tia2XEfnIjJMhCM5SMTCX";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Mathieu Malaterre <malat@debian.org>
Cc: David Airlie <airlied@linux.ie>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ad4c06f7-d429-a453-fb95-44b96e17a1db@suse.de>
Subject: Re: [PATCH 09/11] drm/fbdevdrm: Add primary plane
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326091744.11542-10-tzimmermann@suse.de>
 <CA+7wUsw4s3cLyqFP7-CkV38kRuwRDpmzJaKim4L-Cg2C4HP0uA@mail.gmail.com>
In-Reply-To: <CA+7wUsw4s3cLyqFP7-CkV38kRuwRDpmzJaKim4L-Cg2C4HP0uA@mail.gmail.com>

--1fmQUIgQMC51tia2XEfnIjJMhCM5SMTCX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 26.03.19 um 14:33 schrieb Mathieu Malaterre:
>=20
> ...
> ../drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c:174:2: note: in expansion
> of macro 'do_div'
>   do_div(width, cpp);
>   ^~~~~~
> In file included from ./arch/powerpc/include/generated/asm/div64.h:1,
>                  from ../include/linux/kernel.h:18,
>                  from ../include/linux/list.h:9,
>                  from ../include/linux/rculist.h:10,
>                  from ../include/linux/pid.h:5,
>                  from ../include/linux/sched.h:14,
>                  from ../drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c:15:
> ../include/asm-generic/div64.h:239:22: error: passing argument 1 of
> '__div64_32' from incompatible pointer type
> [-Werror=3Dincompatible-pointer-types]
>    __rem =3D __div64_32(&(n), __base); \
>                       ^~~~
> ../drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c:174:2: note: in expansion
> of macro 'do_div'
>   do_div(width, cpp);
>   ^~~~~~
> ../include/asm-generic/div64.h:213:38: note: expected 'uint64_t *'
> {aka 'long long unsigned int *'} but argument is of type 'unsigned int
> *'
>  extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
> ...

I didn't see this error in 64-bit builds either. Could you send me your
kernel config? Thanks!

Best regards
Thomas


>=20
>> +
>> +       if (width > (__u32)-1)
>> +               return -EINVAL; /* would overflow fb_var->xres_virtual=
 */
>> +
>> +       pitch =3D fb->pitches[0];
>> +       lines =3D vram_size;
>> +       do_div(lines, pitch);
>> +
>> +       if (lines > (__u32)-1)
>> +               return -EINVAL; /* would overflow fb_var->yres_virtual=
 */
>> +
>> +       fb_var->xres_virtual =3D width;
>> +       fb_var->yres_virtual =3D lines;
>> +
>> +       ret =3D fbdevdrm_update_fb_var_screeninfo_from_format(
>> +               fb_var, fb->format[0].format);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return 0;
>> +}
>> diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h b/drivers/gpu/d=
rm/fbdevdrm/fbdevdrm_modes.h
>> index f88a86a83858..925eea78e3f0 100644
>> --- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h
>> +++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h
>> @@ -13,8 +13,11 @@
>>  #ifndef FBDEVDRM_MODES_H
>>  #define FBDEVDRM_MODES_H
>>
>> +#include <linux/types.h>
>> +
>>  struct drm_device;
>>  struct drm_display_mode;
>> +struct drm_framebuffer;
>>  struct fb_videomode;
>>  struct fb_var_screeninfo;
>>
>> @@ -43,4 +46,8 @@ void
>>  fbdevdrm_init_fb_var_screeninfo_from_mode(struct fb_var_screeninfo *v=
ar,
>>                                           const struct drm_display_mod=
e *mode);
>>
>> +int fbdevdrm_update_fb_var_screeninfo_from_framebuffer(
>> +       struct fb_var_screeninfo *fb_var, struct drm_framebuffer *fb,
>> +       size_t vram_size);
>> +
>>  #endif
>> diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c b/drivers/gpu=
/drm/fbdevdrm/fbdevdrm_modeset.c
>> index 585f3478f190..3473b85acbf1 100644
>> --- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
>> +++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
>> @@ -20,6 +20,7 @@
>>  #include <drm/drm_modeset_helper_vtables.h>
>>  #include <drm/drm_probe_helper.h>
>>  #include <linux/fb.h>
>> +#include "fbdevdrm_primary.h"
>>
>>  /*
>>   * CRTC
>> @@ -376,7 +377,13 @@ int fbdevdrm_modeset_init(struct fbdevdrm_modeset=
 *modeset,
>>          * connect them with each other.
>>          */
>>
>> -       ret =3D drm_crtc_init_with_planes(dev, &modeset->crtc, NULL, N=
ULL,
>> +       ret =3D fbdevdrm_init_primary_plane_from_fb_info(
>> +               &modeset->primary_plane, dev, 0, fb_info);
>> +       if (ret)
>> +               goto err_drm_mode_config_cleanup;
>> +
>> +       ret =3D drm_crtc_init_with_planes(dev, &modeset->crtc,
>> +                                       &modeset->primary_plane, NULL,=

>>                                         &fbdevdrm_crtc_funcs, NULL);
>>         if (ret)
>>                 goto err_drm_mode_config_cleanup;
>> diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h b/drivers/gpu=
/drm/fbdevdrm/fbdevdrm_modeset.h
>> index 21e87caa8196..ec753014aba1 100644
>> --- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h
>> +++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h
>> @@ -16,11 +16,13 @@
>>  #include <drm/drm_connector.h>
>>  #include <drm/drm_crtc.h>
>>  #include <drm/drm_encoder.h>
>> +#include <drm/drm_plane.h>
>>
>>  struct drm_device;
>>  struct fb_info;
>>
>>  struct fbdevdrm_modeset {
>> +       struct drm_plane primary_plane;
>>         struct drm_crtc crtc;
>>         struct drm_encoder encoder;
>>         struct drm_connector connector;
>> diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c b/drivers/gpu=
/drm/fbdevdrm/fbdevdrm_primary.c
>> new file mode 100644
>> index 000000000000..8ba8e6bd1c14
>> --- /dev/null
>> +++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c
>> @@ -0,0 +1,498 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * One purpose of this driver is to allow for easy conversion of fram=
ebuffer
>> + * drivers to DRM. As a special exception to the GNU GPL, you are all=
owed to
>> + * relicense this file under the terms of a license of your choice if=
 you're
>> + * porting a framebuffer driver. In order to do so, update the SPDX l=
icense
>> + * identifier to the new license and remove this exception.
>> + *
>> + * If you add code to this file, please ensure that it's compatible w=
ith the
>> + * stated exception.
>> + */
>> +
>> +#include "fbdevdrm_primary.h"
>> +#include <drm/drm_atomic.h>
>> +#include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_fourcc.h>
>> +#include <drm/drm_plane.h>
>> +#include <linux/fb.h>
>> +#include "fbdevdrm_bo.h"
>> +#include "fbdevdrm_format.h"
>> +#include "fbdevdrm_modes.h"
>> +#include "fbdevdrm_modeset.h"
>> +
>> +static struct fbdevdrm_modeset* fbdevdrm_modeset_of_primary_plane(
>> +       struct drm_plane *primary_plane)
>> +{
>> +       return container_of(primary_plane, struct fbdevdrm_modeset,
>> +                           primary_plane);
>> +}
>> +
>> +/*
>> + * Primary plane
>> + */
>> +
>> +static int primary_plane_helper_prepare_fb(struct drm_plane *plane,
>> +                                          struct drm_plane_state *new=
_state)
>> +{
>> +        struct drm_gem_object *gem;
>> +        struct fbdevdrm_bo *fbo;
>> +       int ret;
>> +
>> +       if (!new_state->fb)
>> +               return 0;
>> +
>> +       gem =3D new_state->fb->obj[0];
>> +       fbo =3D fbdevdrm_bo_of_gem(gem);
>> +
>> +        ret =3D fbdevdrm_bo_pin(fbo, TTM_PL_FLAG_VRAM);
>> +        if (ret)
>> +                return ret;
>> +
>> +       return 0;
>> +}
>> +
>> +static void primary_plane_helper_cleanup_fb(struct drm_plane *plane,
>> +                                           struct drm_plane_state *ol=
d_state)
>> +{
>> +        struct drm_gem_object *gem;
>> +        struct fbdevdrm_bo *fbo;
>> +
>> +       if (!old_state->fb)
>> +               return;
>> +
>> +       gem =3D old_state->fb->obj[0];
>> +       fbo =3D fbdevdrm_bo_of_gem(gem);
>> +
>> +       fbdevdrm_bo_unpin(fbo);
>> +}
>> +
>> +static void fbdevdrm_update_fb_var_screeninfo_from_crtc_state(
>> +       struct fb_var_screeninfo *fb_var, struct drm_crtc_state* crtc_=
state)
>> +{
>> +       fbdevdrm_update_fb_var_screeninfo_from_mode(fb_var, &crtc_stat=
e->adjusted_mode);
>> +}
>> +
>> +static int primary_plane_helper_atomic_check(struct drm_plane *plane,=

>> +                                            struct drm_plane_state *s=
tate)
>> +{
>> +       struct drm_crtc_state *new_crtc_state;
>> +       int ret;
>> +       struct fbdevdrm_modeset *modeset;
>> +       struct fb_var_screeninfo fb_var;
>> +
>> +       if (!state->crtc)
>> +               return 0;
>> +
>> +       new_crtc_state =3D drm_atomic_get_new_crtc_state(state->state,=

>> +                                                      state->crtc);
>> +       if (!new_crtc_state)
>> +               return 0;
>> +
>> +       ret =3D drm_atomic_helper_check_plane_state(state, new_crtc_st=
ate,
>> +                                                 1 << 16, 1 << 16,
>> +                                                 false, true);
>> +       if (ret < 0) {
>> +               DRM_ERROR("fbdrmdev: %s:%d ret=3D%d:\n", __func__, __L=
INE__, ret);
>> +               return ret;
>> +       }
>> +
>> +       if (!state->visible || !state->fb)
>> +               return 0;
>> +
>> +       /* Virtual screen sizes are not supported.
>> +        */
>> +
>> +       if (drm_rect_width(&state->dst) !=3D state->fb->width ||
>> +           drm_rect_height(&state->dst) !=3D state->fb->height) {
>> +               DRM_ERROR("fbdevdrm: %s:%d: virtual screen sizes not s=
upported\n", __func__, __LINE__);
>> +               return -EINVAL;
>> +       }
>> +       if (state->dst.x1 || state->dst.y1) {
>> +               DRM_ERROR("fbdevdrm: %s:%d: virtual screen offset not =
supported\n", __func__, __LINE__);
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* Pixel formats have to be compatible with fbdev. This is
>> +        * usually some variation of XRGB.
>> +        */
>> +
>> +       if (!plane->state ||
>> +           !plane->state->fb ||
>> +           plane->state->fb->format[0].format !=3D state->fb->format[=
0].format) {
>> +
>> +               modeset =3D fbdevdrm_modeset_of_primary_plane(plane);
>> +
>> +               if (modeset->fb_info->fbops->fb_check_var) {
>> +                       memcpy(&fb_var, &modeset->fb_info->var,
>> +                              sizeof(fb_var));
>> +                       fbdevdrm_update_fb_var_screeninfo_from_crtc_st=
ate(
>> +                               &fb_var, new_crtc_state);
>> +                       fbdevdrm_update_fb_var_screeninfo_from_framebu=
ffer(
>> +                               &fb_var, state->fb,
>> +                               modeset->fb_info->fix.smem_len);
>> +                       ret =3D modeset->fb_info->fbops->fb_check_var(=

>> +                               &fb_var, modeset->fb_info);
>> +                       if (ret < 0)
>> +                               return ret;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int set_palette_cmap(struct fb_info* fb_info)
>> +{
>> +       __u32 len;
>> +       const struct fb_cmap* default_cmap;
>> +       struct fb_cmap cmap;
>> +       int ret;
>> +       const __u32 gamma_len[3] =3D {
>> +               fb_info->var.red.length,
>> +               fb_info->var.green.length,
>> +               fb_info->var.blue.length
>> +       };
>> +
>> +       len =3D max3(gamma_len[0], gamma_len[1], gamma_len[2]);
>> +       if (!len || (len > 31)) {
>> +               DRM_ERROR("fbdevdrm: gamma LUT has invalid bit count"
>> +                         " of %u\n", (unsigned int)len);
>> +               return -EINVAL;
>> +       }
>> +
>> +       default_cmap =3D fb_default_cmap(1ul << len);
>> +       if (!default_cmap)
>> +               return -EINVAL;
>> +
>> +       memset(&cmap, 0, sizeof(cmap));
>> +       ret =3D fb_alloc_cmap(&cmap, default_cmap->len, 0);
>> +       if (ret)
>> +               return ret;
>> +       ret =3D fb_copy_cmap(default_cmap, &cmap);
>> +       if (ret)
>> +               goto err_fb_dealloc_cmap;
>> +       ret =3D fb_set_cmap(&cmap, fb_info);
>> +       if (ret)
>> +               return ret;
>> +       fb_dealloc_cmap(&cmap);
>> +
>> +       return 0;
>> +
>> +err_fb_dealloc_cmap:
>> +       fb_dealloc_cmap(&cmap);
>> +       return ret;
>> +}
>> +
>> +static int set_linear_cmap(struct fb_info* fb_info)
>> +{
>> +       struct fb_cmap cmap;
>> +       int ret;
>> +       size_t i;
>> +       unsigned int j;
>> +       u16 *lut;
>> +       u16 incr;
>> +       u16 *gamma_lut[3];
>> +       __u32 len;
>> +       const __u32 gamma_len[3] =3D {
>> +               fb_info->var.red.length,
>> +               fb_info->var.green.length,
>> +               fb_info->var.blue.length
>> +       };
>> +
>> +       len =3D max3(gamma_len[0], gamma_len[1], gamma_len[2]);
>> +       if (!len || (len > 8)) {
>> +               DRM_ERROR("fbdevdrm: gamma LUT has invalid bit count"
>> +                         " of %u\n", (unsigned int)len);
>> +               return -EINVAL;
>> +       }
>> +
>> +       memset(&cmap, 0, sizeof(cmap));
>> +       ret =3D fb_alloc_cmap(&cmap, 1ul << len, 0);
>> +       if (ret)
>> +               return ret;
>> +
>> +       gamma_lut[0] =3D cmap.red;
>> +       gamma_lut[1] =3D cmap.green;
>> +       gamma_lut[2] =3D cmap.blue;
>> +
>> +       for (i =3D 0; i < ARRAY_SIZE(gamma_lut); ++i) {
>> +               lut =3D gamma_lut[i];
>> +               len =3D 1ul << gamma_len[i];
>> +               incr =3D 0x10000u >> gamma_len[i];
>> +               for (j =3D 0; j < len; ++j, ++lut) {
>> +                       *lut =3D incr * j;
>> +               }
>> +               /* In order to have no intensity at index 0 and full
>> +                * intensity at the final index of the LUT, we fix-up =
the
>> +                * table's final entries. The fix-up makes intensity g=
row
>> +                * faster near the final entries of the gamma LUT. The=
 human
>> +                * eye is more sensitive to changes to the lower inten=
sities,
>> +                * so this is probably not directly perceivable.
>> +                */
>> +               for (lut -=3D gamma_len[i], j =3D gamma_len[i]; j > 0;=
 ++lut) {
>> +                       --j;
>> +                       *lut +=3D (incr >> j) - 1; /* subtract 1 to no=
t
>> +                                                 * overflow the LUT's=

>> +                                                 * final entry */
>> +               }
>> +       }
>> +
>> +       ret =3D fb_set_cmap(&cmap, fb_info);
>> +       if (ret)
>> +               goto err_fb_dealloc_cmap;
>> +       fb_dealloc_cmap(&cmap);
>> +
>> +       return 0;
>> +
>> +err_fb_dealloc_cmap:
>> +       fb_dealloc_cmap(&cmap);
>> +       return -EINVAL;
>> +}
>> +
>> +static int set_cmap(struct fb_info *fb_info)
>> +{
>> +       int ret =3D 0;
>> +
>> +       switch (fb_info->fix.visual) {
>> +       case FB_VISUAL_PSEUDOCOLOR:
>> +               ret =3D set_palette_cmap(fb_info);
>> +               break;
>> +       case FB_VISUAL_DIRECTCOLOR:
>> +               ret =3D set_linear_cmap(fb_info);
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static void primary_plane_helper_atomic_update(
>> +       struct drm_plane *plane, struct drm_plane_state *old_state)
>> +{
>> +       struct fbdevdrm_modeset *modeset;
>> +       uint32_t format;
>> +       struct fb_var_screeninfo fb_var;
>> +       int ret;
>> +        struct drm_gem_object *gem;
>> +        struct fbdevdrm_bo *fbo;
>> +       __u32 line_length;
>> +       uint64_t yoffset;
>> +       uint32_t xoffset;
>> +
>> +       modeset =3D fbdevdrm_modeset_of_primary_plane(plane);
>> +
>> +       format =3D fbdevdrm_format_of_fb_info(modeset->fb_info);
>> +
>> +       /* DRM porting notes: Some fbdev drivers report alpha channels=
 for
>> +        * their framebuffer, even though they don't support transpare=
nt
>> +        * primary planes. For the format test below, we ignore the al=
pha
>> +        * channel and use the non-transparent equivalent of the pixel=
 format.
>> +        * If you're porting an fbdev driver to DRM, remove this switc=
h
>> +        * statement and report the correct format instead.
>> +        */
>> +       switch (format) {
>> +       case DRM_FORMAT_ARGB8888:
>> +               format =3D DRM_FORMAT_XRGB8888;
>> +               break;
>> +       case DRM_FORMAT_ABGR8888:
>> +               format =3D DRM_FORMAT_XBGR8888;
>> +               break;
>> +       case DRM_FORMAT_RGBA8888:
>> +               format =3D DRM_FORMAT_RGBX8888;
>> +               break;
>> +       case DRM_FORMAT_BGRA8888:
>> +               format =3D DRM_FORMAT_BGRX8888;
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       if ((format !=3D plane->state->fb->format[0].format) ||
>> +           (modeset->fb_info->var.xres_virtual !=3D plane->state->fb-=
>width)) {
>> +
>> +               /* Pixel format changed, update fb_info accordingly
>> +                */
>> +
>> +               memcpy(&fb_var, &modeset->fb_info->var, sizeof(fb_var)=
);
>> +               ret =3D fbdevdrm_update_fb_var_screeninfo_from_framebu=
ffer(
>> +                       &fb_var, plane->state->fb,
>> +                       modeset->fb_info->fix.smem_len);
>> +               if (ret)
>> +                       return;
>> +
>> +               fb_var.activate =3D FB_ACTIVATE_NOW;
>> +
>> +               ret =3D fb_set_var(modeset->fb_info, &fb_var);
>> +               if (ret) {
>> +                       DRM_ERROR("fbdevdrm: fb_set_var() failed: %d\n=
", ret);
>> +                       return;
>> +               }
>> +       }
>> +
>> +       if (!old_state->fb || /* first-time update */
>> +           (format !=3D plane->state->fb->format[0].format)) {
>> +
>> +               /* DRM porting notes: Below we set the LUTs for palett=
e and
>> +                * gamma correction. This is required by some fbdev dr=
ivers,
>> +                * such as nvidiafb and atyfb, which don't initialize =
the
>> +                * table to pass-through the framebuffer values unchan=
ged. This
>> +                * is actually CRTC state, but the respective function=

>> +                * crtc_helper_mode_set_nofb() is only called when a C=
RTC
>> +                * property changes, changes in color formats are not =
handled
>> +                * there. When you're porting a fbdev driver to DRM, r=
emove
>> +                * the call. Gamma LUTs are CRTC properties and should=
 be
>> +                * handled there. Either remove gamma correction or se=
t up
>> +                * the respective CRTC properties for userspace.
>> +                */
>> +               set_cmap(modeset->fb_info);
>> +       }
>> +
>> +       /* With the fb interface, we cannot directly program
>> +        * the scanout buffer's address. Instead we use the
>> +        * panning function to point the graphics card to the
>> +        * buffer's location.
>> +        */
>> +
>> +       gem =3D plane->state->fb->obj[0];
>> +       fbo =3D fbdevdrm_bo_of_gem(gem);
>> +
>> +       line_length =3D plane->state->fb->pitches[0];
>> +       yoffset =3D fbo->bo.offset;
>> +       xoffset =3D do_div(yoffset, line_length);
>> +       if (yoffset > (__u32)-1) {
>> +               /* The value of yoffset doesn't fit into a 32-bit valu=
e,
>> +                * so we cannot use it for display panning. Either the=

>> +                * graphics card has GiBs of VRAM or this is a bug wit=
h
>> +                * memory management. */
>> +               DRM_ERROR("fbdevdrm: buffer object is not aligned to a=
 "
>> +                         "multiple of the scanline size.\n");
>> +               return;
>> +       } else if (xoffset) {
>> +               /* The buffer starts in the middle of a scanline. The
>> +                * memory manager should have prevented this. This
>> +                * problem indicates a bug with the buffer aligning. *=
/
>> +               DRM_ERROR("fbdevdrm: buffer object is not aligned to a=
 "
>> +                         "multiple of the scanline size.\n");
>> +               return;
>> +       }
>> +
>> +       memcpy(&fb_var, &modeset->fb_info->var, sizeof(fb_var));
>> +       fb_var.xoffset =3D xoffset;
>> +       fb_var.yoffset =3D yoffset;
>> +
>> +       ret =3D fb_pan_display(modeset->fb_info, &fb_var);
>> +       if (ret) {
>> +               DRM_ERROR("fbdevdrm: fb_pan_display() failed: %d\n", r=
et);
>> +               return;
>> +       }
>> +}
>> +
>> +static void primary_plane_helper_atomic_disable(
>> +       struct drm_plane *plane, struct drm_plane_state *old_state)
>> +{ }
>> +
>> +static int primary_plane_helper_atomic_async_check(
>> +       struct drm_plane *plane, struct drm_plane_state *state)
>> +{
>> +       return 0;
>> +}
>> +
>> +static void primary_plane_helper_atomic_async_update(
>> +       struct drm_plane *plane, struct drm_plane_state *new_state)
>> +{
>> +       drm_plane_cleanup(plane);
>> +}
>> +
>> +static const struct drm_plane_helper_funcs primary_plane_helper_funcs=
 =3D {
>> +       .prepare_fb =3D primary_plane_helper_prepare_fb,
>> +       .cleanup_fb =3D primary_plane_helper_cleanup_fb,
>> +       .atomic_check =3D primary_plane_helper_atomic_check,
>> +       .atomic_update =3D primary_plane_helper_atomic_update,
>> +       .atomic_disable =3D primary_plane_helper_atomic_disable,
>> +       .atomic_async_check =3D primary_plane_helper_atomic_async_chec=
k,
>> +       .atomic_async_update =3D primary_plane_helper_atomic_async_upd=
ate
>> +};
>> +
>> +static void primary_plane_destroy(struct drm_plane *plane)
>> +{
>> +       drm_plane_cleanup(plane);
>> +}
>> +
>> +static const struct drm_plane_funcs primary_plane_funcs =3D {
>> +       .update_plane =3D drm_atomic_helper_update_plane,
>> +       .disable_plane =3D drm_atomic_helper_disable_plane,
>> +       .destroy =3D primary_plane_destroy,
>> +       .reset =3D drm_atomic_helper_plane_reset,
>> +       .set_property =3D NULL, /* unused */
>> +       .atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_=
state,
>> +       .atomic_destroy_state =3D drm_atomic_helper_plane_destroy_stat=
e,
>> +       .atomic_set_property =3D NULL, /* unused */
>> +       .atomic_get_property =3D NULL, /* unused */
>> +       .late_register =3D NULL, /* unused */
>> +       .early_unregister =3D NULL, /* unused */
>> +       .atomic_print_state =3D NULL, /* unused */
>> +       .format_mod_supported =3D NULL /* unused */
>> +};
>> +
>> +static const uint32_t*
>> +formats_from_fb_info(const struct fb_info* fb_info, unsigned int* for=
mat_count)
>> +{
>> +       /* TODO: Detect the actually supported formats or have some
>> +        *       sort of whitelist for known hardware devices.
>> +        */
>> +       static const uint32_t formats[] =3D {
>> +               DRM_FORMAT_XRGB8888,
>> +               DRM_FORMAT_RGB565
>> +       };
>> +
>> +       *format_count =3D ARRAY_SIZE(formats);
>> +
>> +       return formats;
>> +}
>> +
>> +int fbdevdrm_init_primary_plane_from_fb_info(struct drm_plane *plane,=

>> +                                            struct drm_device *dev,
>> +                                            uint32_t possible_crtcs,
>> +                                            struct fb_info *fb_info)
>> +{
>> +       uint32_t cur_format;
>> +       const uint32_t* format;
>> +       unsigned int format_count;
>> +       int ret;
>> +
>> +       /* We first try to find the supported pixel formats from the
>> +        * fb_info's hardware settings. If that fails, we take the
>> +        * current settings. */
>> +       format =3D formats_from_fb_info(fb_info, &format_count);
>> +       if (!format_count) {
>> +               cur_format =3D fbdevdrm_format_of_fb_info(fb_info);
>> +               format =3D &cur_format;
>> +               format_count =3D 1;
>> +       }
>> +       if (!format_count)
>> +               return -ENODEV;
>> +
>> +       ret =3D drm_universal_plane_init(dev, plane, possible_crtcs,
>> +                                      &primary_plane_funcs,
>> +                                      format, format_count,
>> +                                      NULL, DRM_PLANE_TYPE_PRIMARY, N=
ULL);
>> +       if (ret < 0)
>> +               return ret;
>> +       drm_plane_helper_add(plane, &primary_plane_helper_funcs);
>> +
>> +       ret =3D drm_plane_create_rotation_property(plane, DRM_MODE_ROT=
ATE_0,
>> +                                                DRM_MODE_ROTATE_0);
>> +       if (ret < 0)
>> +               goto err_drm_plane_cleanup;
>> +
>> +       ret =3D drm_plane_create_zpos_immutable_property(plane, 0);
>> +       if (ret < 0)
>> +               goto err_drm_plane_cleanup;
>> +
>> +       return 0;
>> +
>> +err_drm_plane_cleanup:
>> +       drm_plane_cleanup(plane);
>> +       return ret;
>> +}
>> diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h b/drivers/gpu=
/drm/fbdevdrm/fbdevdrm_primary.h
>> new file mode 100644
>> index 000000000000..529c272c6e0b
>> --- /dev/null
>> +++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h
>> @@ -0,0 +1,27 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * One purpose of this driver is to allow for easy conversion of fram=
ebuffer
>> + * drivers to DRM. As a special exception to the GNU GPL, you are all=
owed to
>> + * relicense this file under the terms of a license of your choice if=
 you're
>> + * porting a framebuffer driver. In order to do so, update the SPDX l=
icense
>> + * identifier to the new license and remove this exception.
>> + *
>> + * If you add code to this file, please ensure that it's compatible w=
ith the
>> + * stated exception.
>> + */
>> +
>> +#ifndef FBDEVDRM_PRIMARY_H
>> +#define FBDEVDRM_PRIMARY_H
>> +
>> +#include <linux/types.h>
>> +
>> +struct drm_device;
>> +struct drm_plane;
>> +struct fb_info;
>> +
>> +int fbdevdrm_init_primary_plane_from_fb_info(struct drm_plane *plane,=

>> +                                            struct drm_device *dev,
>> +                                            uint32_t possible_crtcs,
>> +                                            struct fb_info *fb_info);=

>> +
>> +#endif
>> --
>> 2.21.0
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--1fmQUIgQMC51tia2XEfnIjJMhCM5SMTCX--

--UF1siukkECKI54ONYNG6TsgDx0JxM6W4M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlybRGoACgkQaA3BHVML
eiPtEAf/WQKe0Jo922Aa3JLNp7hBm/xZ+SLEJvMiwCX12fPAmJaDspbyB/dFcqDp
aMlfILWoWWD1CBututlLvE1R3nG1gATEJc3QnEgTz74WvBqVOYwOEIHoXC4Jvlsr
+7juynKAuMsT3c/481msk3MKYdjSE1BDlc/Hbz1VPckJYS0DkytgZvPDQFtvr+Ez
f2emc80cnGuCbRuSzH6wHUE7mCgcTERFUW7Po01U1H7X8VKGCRSa/krdxkeCKDVv
dhMa2eiugl8JcPX33VlrCRjtxzAytAZ/99qh+J4a/yQ8SpywotMF/jKFz80cbbZv
NY+4+i7XsOgirtLHG3u1UWU95Z4F2A==
=pOZY
-----END PGP SIGNATURE-----

--UF1siukkECKI54ONYNG6TsgDx0JxM6W4M--
