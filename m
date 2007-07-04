From: eric miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] pxafb: Add support for other palette formats
Date: Wed, 04 Jul 2007 14:38:58 +0800
Message-ID: <468B4082.9080604@gmail.com>
References: <200707031607.08511.hjk@linutronix.de>
	<200707032236.27461.hjk@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <200707032236.27461.hjk@linutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
Content-Type: text/plain; charset="iso-8859-1"
To: =?UTF-8?B?SGFucy1Kw7xyZ2VuIEtvY2g=?= <hjk@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Clemens Koller <clemens.koller@anagramm.de>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

Hans-J=C3=BCrgen Koch wrote:
> All right, next iteration.
>=20
> Changes:
> If cpuid says it's not a PXA27x, palette format is forced to 0 (which
> is the old 16-bit RGB565 format), and the driver will not access LCCR4.
>=20
> Signed-off-by: Hans J. Koch <hjk@linutronix.de>
>=20
> Index: linux-2.6.22-rc/include/asm-arm/arch-pxa/pxa-regs.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22-rc.orig/include/asm-arm/arch-pxa/pxa-regs.h	2007-07-03 2=
2:27:19.000000000 +0200
> +++ linux-2.6.22-rc/include/asm-arm/arch-pxa/pxa-regs.h	2007-07-03 22:28:=
22.000000000 +0200
> @@ -1843,6 +1843,7 @@
>  #define LCCR1		__REG(0x44000004)  /* LCD Controller Control Register 1 */
>  #define LCCR2		__REG(0x44000008)  /* LCD Controller Control Register 2 */
>  #define LCCR3		__REG(0x4400000C)  /* LCD Controller Control Register 3 */
> +#define LCCR4		__REG(0x44000010)  /* LCD Controller Control Register 4 */
>  #define DFBR0		__REG(0x44000020)  /* DMA Channel 0 Frame Branch Register=
 */
>  #define DFBR1		__REG(0x44000024)  /* DMA Channel 1 Frame Branch Register=
 */
>  #define LCSR		__REG(0x44000038)  /* LCD Controller Status Register */
> @@ -1856,6 +1857,16 @@
>  #define LCCR3_8BPP (3 << 24)
>  #define LCCR3_16BPP (4 << 24)
> =20
> +#define LCCR3_PDFOR_0 (0 << 30)
> +#define LCCR3_PDFOR_1 (1 << 30)
> +#define LCCR3_PDFOR_2 (2 << 30)
> +#define LCCR3_PDFOR_3 (3 << 30)
> +
> +#define LCCR4_PAL_FOR_0 (0 << 15)
> +#define LCCR4_PAL_FOR_1 (1 << 15)
> +#define LCCR4_PAL_FOR_2 (2 << 15)
> +#define LCCR4_PAL_FOR_MASK (3 << 15)
> +
>  #define FDADR0		__REG(0x44000200)  /* DMA Channel 0 Frame Descriptor Add=
ress Register */
>  #define FSADR0		__REG(0x44000204)  /* DMA Channel 0 Frame Source Address=
 Register */
>  #define FIDR0		__REG(0x44000208)  /* DMA Channel 0 Frame ID Register */

I think we may better surround that PXA27x specific definitions using
the #ifdef..#endif stuff, to make sure that we are not accessing those
registers if only PXA25x is defined, compiler will catch this and give
an early warning, and another good thing of doing this is that we know
how to separate these definitions into different files, suppose one day
we are going to make this pxa-regs.h much cleaner :-)

> Index: linux-2.6.22-rc/drivers/video/pxafb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22-rc.orig/drivers/video/pxafb.c	2007-07-03 22:27:19.000000=
000 +0200
> +++ linux-2.6.22-rc/drivers/video/pxafb.c	2007-07-03 22:28:22.000000000 +=
0200
> @@ -106,20 +106,38 @@
>  		       u_int trans, struct fb_info *info)
>  {
>  	struct pxafb_info *fbi =3D (struct pxafb_info *)info;
> -	u_int val, ret =3D 1;
> +	u_int val;
> =20
> -	if (regno < fbi->palette_size) {
> -		if (fbi->fb.var.grayscale) {
> -			val =3D ((blue >> 8) & 0x00ff);
> -		} else {
> -			val  =3D ((red   >>  0) & 0xf800);
> -			val |=3D ((green >>  5) & 0x07e0);
> -			val |=3D ((blue  >> 11) & 0x001f);
> -		}
> +	if (regno >=3D fbi->palette_size)
> +		return 1;
> +
> +	if (fbi->fb.var.grayscale) {
> +		fbi->palette_cpu[regno] =3D ((blue >> 8) & 0x00ff);
> +		return 0;
> +	}
> +
> +	switch (fbi->lccr4 & LCCR4_PAL_FOR_MASK) {
> +	case LCCR4_PAL_FOR_0:
> +		val  =3D ((red   >>  0) & 0xf800);
> +		val |=3D ((green >>  5) & 0x07e0);
> +		val |=3D ((blue  >> 11) & 0x001f);
>  		fbi->palette_cpu[regno] =3D val;
> -		ret =3D 0;
> +		break;
> +	case LCCR4_PAL_FOR_1:
> +		val  =3D ((red   << 8) & 0x00f80000);
> +		val |=3D ((green >> 0) & 0x0000fc00);
> +		val |=3D ((blue  >> 8) & 0x000000f8);
> +		((u32*)(fbi->palette_cpu))[regno] =3D val;
> +		break;
> +	case LCCR4_PAL_FOR_2:
> +		val  =3D ((red   << 8) & 0x00fc0000);
> +		val |=3D ((green >> 0) & 0x0000fc00);
> +		val |=3D ((blue  >> 8) & 0x000000fc);
> +		((u32*)(fbi->palette_cpu))[regno] =3D val;
> +		break;
>  	}
> -	return ret;
> +
> +	return 0;
>  }

Can we also set the transparency bit along with RGB? I'm not sure if any
weird applications will use the transparency bit in palette mode, but I
think it is already there and easy to add.

> =20
>  static int
> @@ -361,7 +379,10 @@
>  	else
>  		fbi->palette_size =3D var->bits_per_pixel =3D=3D 1 ? 4 : 1 << var->bit=
s_per_pixel;
> =20
> -	palette_mem_size =3D fbi->palette_size * sizeof(u16);
> +	if ((fbi->lccr4 & LCCR4_PAL_FOR_MASK) =3D=3D LCCR4_PAL_FOR_0)
> +		palette_mem_size =3D fbi->palette_size * sizeof(u16);
> +	else
> +		palette_mem_size =3D fbi->palette_size * sizeof(u32);
> =20
>  	pr_debug("pxafb: palette_mem_size =3D 0x%08lx\n", palette_mem_size);
> =20
> @@ -676,7 +697,13 @@
> =20
>  	fbi->dmadesc_palette_cpu->fsadr =3D fbi->palette_dma;
>  	fbi->dmadesc_palette_cpu->fidr  =3D 0;
> -	fbi->dmadesc_palette_cpu->ldcmd =3D (fbi->palette_size * 2) | LDCMD_PAL;
> +	if ((fbi->lccr4 & LCCR4_PAL_FOR_MASK) =3D=3D LCCR4_PAL_FOR_0)
> +		fbi->dmadesc_palette_cpu->ldcmd =3D fbi->palette_size *
> +							sizeof(u16);
> +	else
> +		fbi->dmadesc_palette_cpu->ldcmd =3D fbi->palette_size *
> +							sizeof(u32);
> +	fbi->dmadesc_palette_cpu->ldcmd |=3D LDCMD_PAL;
> =20
>  	if (var->bits_per_pixel =3D=3D 16) {
>  		/* palette shouldn't be loaded in true-color mode */
> @@ -715,6 +742,15 @@
>  	fbi->reg_lccr1 =3D new_regs.lccr1;
>  	fbi->reg_lccr2 =3D new_regs.lccr2;
>  	fbi->reg_lccr3 =3D new_regs.lccr3;
> +
> +	if (((read_cpuid(CPUID_ID) >> 4) & 0x1f) =3D=3D 0x11) {
> +		/* PXA 27x only */
> +		fbi->reg_lccr4 =3D LCCR4 & (~LCCR4_PAL_FOR_MASK);
> +		fbi->reg_lccr4 |=3D (fbi->lccr4 & LCCR4_PAL_FOR_MASK);
> +	}
> +	else {
> +		fbi->reg_lccr4 =3D 0;
> +	}

Russell has a couple of cpu_is_pxa25x() and cpu_is_pxa27x() macros ready
for use, it will be merged into the mainline soon.

>  	set_hsync_time(fbi, pcd);
>  	local_irq_restore(flags);
> =20
> @@ -806,6 +842,8 @@
>  	pxa_set_cken(CKEN_LCD, 1);
> =20
>  	/* Sequence from 11.7.10 */
> +	if (((read_cpuid(CPUID_ID) >> 4) & 0x1f) =3D=3D 0x11)
> +		LCCR4 =3D fbi->reg_lccr4; /* PXA 27x only */
>  	LCCR3 =3D fbi->reg_lccr3;
>  	LCCR2 =3D fbi->reg_lccr2;
>  	LCCR1 =3D fbi->reg_lccr1;
> @@ -1090,10 +1128,13 @@
>  		 * dma_writecombine_mmap)
>  		 */
>  		fbi->fb.fix.smem_start =3D fbi->screen_dma;
> -
>  		fbi->palette_size =3D fbi->fb.var.bits_per_pixel =3D=3D 8 ? 256 : 16;
> =20
> -		palette_mem_size =3D fbi->palette_size * sizeof(u16);
> +		if ((fbi->lccr4 & LCCR4_PAL_FOR_MASK) =3D=3D LCCR4_PAL_FOR_0)
> +			palette_mem_size =3D fbi->palette_size * sizeof(u16);
> +		else
> +			palette_mem_size =3D fbi->palette_size * sizeof(u32);
> +
>  		pr_debug("pxafb: palette_mem_size =3D 0x%08lx\n", palette_mem_size);
> =20
>  		fbi->palette_cpu =3D (u16 *)(fbi->map_cpu + PAGE_SIZE - palette_mem_si=
ze);
> @@ -1150,6 +1191,11 @@
> =20
>  	fbi->lccr0			=3D inf->lccr0;
>  	fbi->lccr3			=3D inf->lccr3;
> +	if (((read_cpuid(CPUID_ID) >> 4) & 0x1f) =3D=3D 0x11)
> +		fbi->lccr4 =3D inf->lccr4; /* PXA27x only */
> +	else
> +		fbi->lccr4 =3D 0;
> +
>  	fbi->state			=3D C_STARTUP;
>  	fbi->task_state			=3D (u_char)-1;
> =20
> Index: linux-2.6.22-rc/drivers/video/pxafb.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22-rc.orig/drivers/video/pxafb.h	2007-07-03 22:27:19.000000=
000 +0200
> +++ linux-2.6.22-rc/drivers/video/pxafb.h	2007-07-03 22:28:22.000000000 +=
0200
> @@ -70,6 +70,7 @@
> =20
>  	u_int			lccr0;
>  	u_int			lccr3;
> +	u_int			lccr4;
>  	u_int			cmap_inverse:1,
>  				cmap_static:1,
>  				unused:30;
> @@ -78,6 +79,7 @@
>  	u_int			reg_lccr1;
>  	u_int			reg_lccr2;
>  	u_int			reg_lccr3;
> +	u_int			reg_lccr4;
> =20
>  	unsigned long	hsync_time;
> =20
> Index: linux-2.6.22-rc/include/asm-arm/arch-pxa/pxafb.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22-rc.orig/include/asm-arm/arch-pxa/pxafb.h	2007-07-03 22:2=
7:19.000000000 +0200
> +++ linux-2.6.22-rc/include/asm-arm/arch-pxa/pxafb.h	2007-07-03 22:28:22.=
000000000 +0200
> @@ -70,7 +70,12 @@
>  	 *      LCCR3_HSP, LCCR3_VSP, LCCR0_Pcd(x), LCCR3_Bpp
>  	 */
>  	u_int		lccr3;
> -
> +	/* The following should be defined in LCCR4
> +	 *	LCCR4_PAL_FOR_0 or LCCR4_PAL_FOR_1 or LCCR4_PAL_FOR_2
> +	 *
> +	 * All other bits in LCCR4 should be left alone.
> +	 */
> +	u_int		lccr4;
>  	void (*pxafb_backlight_power)(int);
>  	void (*pxafb_lcd_power)(int, struct fb_var_screeninfo *);
> =20

another thing I'm curious is there any specific reason that
LCCR4_PAL_FOR_3 format is not added in your patch?

- eric

>=20
>=20
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kern=
el
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
>=20


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
