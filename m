From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 05 Feb 2020 18:02:10 +0000
Subject: Re: [PATCH 1/3] fbdev/g364fb: Fix build failure
Message-Id: <CAAdtpL7SpzfqSmEcuVszNyXfrRegC20txoS5j7Ss3WkCmyRH+g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1580610812.git.fthain@telegraphics.com.au>
 <d8f19ebc00a7688da739d41d584d081d1559f0d2.1580610812.git.fthain@telegraphics.com.au>
In-Reply-To: <d8f19ebc00a7688da739d41d584d081d1559f0d2.1580610812.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-fbdev@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, James Hogan <jhogan@kernel.org>, open list <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Thomas Bogendoerfer <tbogendoerfer@suse.de>, dri-devel@lists.freedesktop.org, Laurent Vivier <laurent@vivier.eu>

On Sun, Feb 2, 2020 at 3:41 AM Finn Thain <fthain@telegraphics.com.au> wrot=
e:
>
> This patch resolves these compiler errors and warnings --
>
>   CC      drivers/video/fbdev/g364fb.o
> drivers/video/fbdev/g364fb.c: In function 'g364fb_cursor':
> drivers/video/fbdev/g364fb.c:137:9: error: 'x' undeclared (first use in t=
his function)
> drivers/video/fbdev/g364fb.c:137:9: note: each undeclared identifier is r=
eported only once for each function it appears in
> drivers/video/fbdev/g364fb.c:137:7: error: implicit declaration of functi=
on 'fontwidth' [-Werror=3Dimplicit-function-declaration]
> drivers/video/fbdev/g364fb.c:137:23: error: 'p' undeclared (first use in =
this function)
> drivers/video/fbdev/g364fb.c:137:38: error: 'y' undeclared (first use in =
this function)
> drivers/video/fbdev/g364fb.c:137:7: error: implicit declaration of functi=
on 'fontheight' [-Werror=3Dimplicit-function-declaration]
> drivers/video/fbdev/g364fb.c: In function 'g364fb_init':
> drivers/video/fbdev/g364fb.c:233:24: error: 'fbvar' undeclared (first use=
 in this function)
> drivers/video/fbdev/g364fb.c:234:24: error: 'xres' undeclared (first use =
in this function)

18 years unnoticed...

> drivers/video/fbdev/g364fb.c:201:14: warning: unused variable 'j' [-Wunus=
ed-variable]
> drivers/video/fbdev/g364fb.c:197:25: warning: unused variable 'pal_ptr' [=
-Wunused-variable]
>
> The MIPS Magnum framebuffer console now works when tested in QEMU.
>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

This commit is the kernel 'git origin' import, not the proper reference.

The actual change is between v2.5.17/2.5.19:
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/diff/drive=
rs/video/g364fb.c?id=B30e6e183a728923267
Date: 2002-05-22 07:52:33...

The same commit introduced the changes in g364fb_cursor(), which was
implemented previous to v2.4.0 so it is hard to follow from there.

Nobody complains during 18 years so I doubt anyone care that
g364fb_cursor() is removed.
And by removing it, you improve the kernel quality, so:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
(Maybe remove the unhelpful 'Fixes' tag).

> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  drivers/video/fbdev/g364fb.c | 29 +++--------------------------
>  1 file changed, 3 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/video/fbdev/g364fb.c b/drivers/video/fbdev/g364fb.c
> index 223896cc5f7d..fb26230a3c7b 100644
> --- a/drivers/video/fbdev/g364fb.c
> +++ b/drivers/video/fbdev/g364fb.c
> @@ -108,7 +108,6 @@ static int g364fb_pan_display(struct fb_var_screeninf=
o *var,
>  static int g364fb_setcolreg(u_int regno, u_int red, u_int green,
>                             u_int blue, u_int transp,
>                             struct fb_info *info);
> -static int g364fb_cursor(struct fb_info *info, struct fb_cursor *cursor);
>  static int g364fb_blank(int blank, struct fb_info *info);
>
>  static struct fb_ops g364fb_ops =3D {
> @@ -119,28 +118,8 @@ static struct fb_ops g364fb_ops =3D {
>         .fb_fillrect    =3D cfb_fillrect,
>         .fb_copyarea    =3D cfb_copyarea,
>         .fb_imageblit   =3D cfb_imageblit,
> -       .fb_cursor      =3D g364fb_cursor,
>  };
>
> -int g364fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
> -{
> -
> -       switch (cursor->enable) {
> -       case CM_ERASE:
> -               *(unsigned int *) CTLA_REG |=3D CURS_TOGGLE;
> -               break;
> -
> -       case CM_MOVE:
> -       case CM_DRAW:
> -               *(unsigned int *) CTLA_REG &=3D ~CURS_TOGGLE;
> -               *(unsigned int *) CURS_POS_REG > -                   ((x =
* fontwidth(p)) << 12) | ((y * fontheight(p)) -
> -                                                 info->var.yoffset);
> -               break;
> -       }
> -       return 0;
> -}
> -
>  /*
>   *  Pan or Wrap the Display
>   *
> @@ -194,11 +173,9 @@ static int g364fb_setcolreg(u_int regno, u_int red, =
u_int green,
>   */
>  int __init g364fb_init(void)
>  {
> -       volatile unsigned int *pal_ptr > -           (volatile unsigned i=
nt *) CLR_PAL_REG;
>         volatile unsigned int *curs_pal_ptr >             (volatile unsig=
ned int *) CURS_PAL_REG;
> -       int mem, i, j;
> +       int mem, i;
>
>         if (fb_get_options("g364fb", NULL))
>                 return -ENODEV;
> @@ -230,8 +207,8 @@ int __init g364fb_init(void)
>          */
>         *(unsigned short *) (CURS_PAT_REG + 14 * 64) =3D 0xffff;
>         *(unsigned short *) (CURS_PAT_REG + 15 * 64) =3D 0xffff;
> -       fb_var.xres_virtual =3D fbvar.xres;
> -       fb_fix.line_length =3D (xres / 8) * fb_var.bits_per_pixel;
> +       fb_var.xres_virtual =3D fb_var.xres;
> +       fb_fix.line_length =3D fb_var.xres_virtual * fb_var.bits_per_pixe=
l / 8;
>         fb_fix.smem_start =3D 0x40000000; /* physical address */
>         /* get size of video memory; this is special for the JAZZ hardwar=
e */
>         mem =3D (r4030_read_reg32(JAZZ_R4030_CONFIG) >> 8) & 3;
> --
> 2.24.1
>
