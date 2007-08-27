From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 03/20] fbcon: Convert struct
 font_desc to use ISO C initializers
Date: Mon, 27 Aug 2007 09:11:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708270910330.19656@anakin>
References: <46D186B3.2070508@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463808512-427281352-1188198698=:19656"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPYlH-0004zk-Lf for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Aug 2007 00:11:47 -0700
Received: from agave.telenet-ops.be ([195.130.137.77])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPYlG-0007Jp-WA
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Aug 2007 00:11:47 -0700
In-Reply-To: <46D186B3.2070508@gmail.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Ralf Baechle <ralf@linux-mips.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808512-427281352-1188198698=:19656
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Aug 2007, Antonino A. Daplas wrote:
> From: Ralf Baechle <ralf@linux-mips.org>
>=20
> Akpm's patch "newport_con warning fix" got me to look at the console
> drivers again and one thing that I noticed was that none of the fonts
> was using ISO initializers for it's fonts.
>=20
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>

> diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlig=
ht/cr_bllcd.c
> index 92e201e..96f2307 100644
> --- a/drivers/video/backlight/cr_bllcd.c
> +++ b/drivers/video/backlight/cr_bllcd.c
> @@ -25,6 +25,7 @@
>   * Authors:
>   *   Thomas Hellstrom <thomas-at-tungstengraphics-dot-com>
>   *   Alan Hourihane <alanh-at-tungstengraphics-dot-com>
> + *   Michel D=E4nzer <michel-at-tungstengraphics-dot-com>
>   */
> =20
>  #include <linux/module.h>
> @@ -38,6 +39,8 @@ #include <linux/lcd.h>
>  #include <linux/pci.h>
>  #include <asm/uaccess.h>
> =20
> +#define MODULE_NAME "cr_bllcd"
> +
>  /* The LVDS- and panel power controls sits on the
>   * GPIO port of the ISA bridge.
>   */
> @@ -51,19 +54,25 @@ #define CRVML_LVDS_ON       0x00000001
>  #define CRVML_PANEL_ON      0x00000002
>  #define CRVML_BACKLIGHT_OFF 0x00000004
> =20
> -/* The PLL Clock register sits on Host bridge */
> -#define CRVML_DEVICE_MCH   0x5001
> -#define CRVML_REG_MCHBAR   0x44
> -#define CRVML_REG_MCHEN    0x54
> -#define CRVML_MCHEN_BIT    (1 << 28)
> -#define CRVML_MCHMAP_SIZE  4096
> -#define CRVML_REG_CLOCK    0xc3c
> -#define CRVML_CLOCK_SHIFT  8
> -#define CRVML_CLOCK_MASK   0x00000f00
> -
>  static struct pci_dev *lpc_dev;
>  static u32 gpio_bar;
> =20
> +#ifdef CONFIG_PM
> +
> +#define NUM_LPC_EXTRA_CONFIG_SPACE 45
> +static int lpc_saved_config_space[NUM_LPC_EXTRA_CONFIG_SPACE];
> +
> +#define CRVML_REG_RCBABAR   0xF0
> +#define CRVML_RCBAEN_BIT    (1 << 0)
> +#define CRVML_RCBAMAP_SIZE  16384
> +static u32 rcba_bar;
> +static void __iomem *rcba_regs_base;
> +
> +#define REGSAVE_SIZE (CRVML_RCBAMAP_SIZE + 4)
> +static u32 *regsave;
> +
> +#endif /* CONFIG_PM */
> +
>  struct cr_panel {
>  	struct backlight_device *cr_backlight_device;
>  	struct lcd_device *cr_lcd_device;

Doesn't look like C99 initializer conversions...

> diff --git a/drivers/video/console/font_10x18.c b/drivers/video/console=
/font_10x18.c
> index e6aa0ea..6be72bb 100644
> --- a/drivers/video/console/font_10x18.c
> +++ b/drivers/video/console/font_10x18.c
> @@ -5133,14 +5133,14 @@ static const unsigned char fontdata_10x1
> =20
> =20
>  const struct font_desc font_10x18 =3D {
> -	FONT10x18_IDX,
> -	"10x18",
> -	10,
> -	18,
> -	fontdata_10x18,
> +	.idx	=3D FONT10x18_IDX,
> +	.name	=3D "10x18",
> +	.width	=3D 10,
> +	.height	=3D 18,
> +	.data	=3D fontdata_10x18,
>  #ifdef __sparc__
> -	5
> +	.pref	=3D 5,
>  #else
> -	-1
> +	.pref	=3D -1,
>  #endif
>  };

This does.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds
---1463808512-427281352-1188198698=:19656
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
---1463808512-427281352-1188198698=:19656
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---1463808512-427281352-1188198698=:19656--
