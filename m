From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Thu, 18 Jun 2015 00:47:17 +0000
Subject: Re: [PATCH] nvidia/noveau: Fix color mask
Message-Id: <CAKb7UvjUdOSrYE4L3AqE3Q06mXyyon42U26o9t3M5XLYz2aJmw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150617190508.5205e8af@wiggum>
In-Reply-To: <20150617190508.5205e8af@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antonino Daplas <adaplas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wed, Jun 17, 2015 at 1:05 PM, Michael B=C3=BCsch <m@bues.ch> wrote:
> The expression (~0 >> x) will always yield all-ones, because the right
> shift is an arithmetic right shift that will always shift ones in.
> Accordingly ~(~0 >> x) will always be zero.
> Hence 'mask' will always be zero in this case.
>
> Fix this by forcing a logical right shift instead of an arithmetic
> right shift by using an unsigned int constant.
>
> Signed-off-by: Michael Buesch <m@bues.ch>

Confirmed that this does indeed happen with

#include <stdio.h>
int main(int argc, char *argv[]) {
  unsigned mask =3D ~(~0 >> (32 - (argv[1][0] - '0')));
  printf("%08x\n", mask);
}

I guess fbdev/nvidia/nv_accel.c was the source of all this, as the
code is identical, and it probably came first.

FWIW this is

Reviewed-by: Ilia Mirkin <imirkin@alum.mit.edu>


>
> ---
>
> This patch is untested, because I do not have the hardware.
>
>
> Index: linux/drivers/gpu/drm/nouveau/nv50_fbcon.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux.orig/drivers/gpu/drm/nouveau/nv50_fb=
con.c
> +++ linux/drivers/gpu/drm/nouveau/nv50_fbcon.c
> @@ -96,7 +96,7 @@ nv50_fbcon_imageblit(struct fb_info *inf
>         struct nouveau_drm *drm =3D nouveau_drm(nfbdev->dev);
>         struct nouveau_channel *chan =3D drm->channel;
>         uint32_t width, dwords, *data =3D (uint32_t *)image->data;
> -       uint32_t mask =3D ~(~0 >> (32 - info->var.bits_per_pixel));
> +       uint32_t mask =3D ~(~0U >> (32 - info->var.bits_per_pixel));
>         uint32_t *palette =3D info->pseudo_palette;
>         int ret;
>
> Index: linux/drivers/gpu/drm/nouveau/nvc0_fbcon.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux.orig/drivers/gpu/drm/nouveau/nvc0_fb=
con.c
> +++ linux/drivers/gpu/drm/nouveau/nvc0_fbcon.c
> @@ -96,7 +96,7 @@ nvc0_fbcon_imageblit(struct fb_info *inf
>         struct nouveau_drm *drm =3D nouveau_drm(nfbdev->dev);
>         struct nouveau_channel *chan =3D drm->channel;
>         uint32_t width, dwords, *data =3D (uint32_t *)image->data;
> -       uint32_t mask =3D ~(~0 >> (32 - info->var.bits_per_pixel));
> +       uint32_t mask =3D ~(~0U >> (32 - info->var.bits_per_pixel));
>         uint32_t *palette =3D info->pseudo_palette;
>         int ret;
>
> Index: linux/drivers/video/fbdev/nvidia/nv_accel.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux.orig/drivers/video/fbdev/nvidia/nv_a=
ccel.c
> +++ linux/drivers/video/fbdev/nvidia/nv_accel.c
> @@ -351,7 +351,7 @@ static void nvidiafb_mono_color_expand(s
>                                        const struct fb_image *image)
>  {
>         struct nvidia_par *par =3D info->par;
> -       u32 fg, bg, mask =3D ~(~0 >> (32 - info->var.bits_per_pixel));
> +       u32 fg, bg, mask =3D ~(~0U >> (32 - info->var.bits_per_pixel));
>         u32 dsize, width, *data =3D (u32 *) image->data, tmp;
>         int j, k =3D 0;
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
