From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH v3] Frame Buffer driver for TI
 DA8xx/OMAP-L1xx
Date: Fri, 26 Jun 2009 07:18:55 +0200
Message-ID: <20090626071855.22518d52.krzysztof.h1@poczta.fm>
References: <1245841101-3095-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MK4Bk-0004i5-H5
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Jun 2009 05:41:28 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MK4Bg-0003r3-In for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Jun 2009 05:41:28 +0000
In-Reply-To: <1245841101-3095-1-git-send-email-sudhakar.raj@ti.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Cc: Steve Chen <schen@mvista.com>, davinci-linux-open-source@linux.davincidsp.com, linux-fbdev-devel@lists.sourceforge.net, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>

On Wed, 24 Jun 2009 06:58:21 -0400
"Rajashekhara, Sudhakar" <sudhakar.raj@ti.com> wrote:

> Adds LCD controller (LCDC) driver for TI's DA8xx/OMAP-L1xx architecture.
> LCDC specifications can be found at http://www.ti.com/litv/pdf/sprufm0a.
> 
> LCDC on DA8xx consists of two independent controllers, the Raster Controller
> and the LCD Interface Display Driver (LIDD) controller. LIDD further supports
> character and graphic displays.
> 
> This patch adds support for the graphic display (Sharp LQ035Q3DG01) found on
> the DA830 based EVM. The EVM details can be found at:
> http://support.spectrumdigital.com/boards/dskda830/revc/.
> 
> Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
> Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
> Signed-off-by: Steve Chen <schen@mvista.com>
> ---
>  Since the previous version, error paths in probing function has been
>  corected, removed set_par() function and added code in fb_setcolreg()
>  function for TRUECOLOR mode.
> 
>  drivers/video/Kconfig    |   11 +
>  drivers/video/Makefile   |    1 +
>  drivers/video/da8xx-fb.c |  887 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/video/da8xx-fb.h |  106 ++++++
>  4 files changed, 1005 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/da8xx-fb.c
>  create mode 100644 include/video/da8xx-fb.h
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> new file mode 100644
> index 0000000..a41ae62
> --- /dev/null
> +++ b/drivers/video/da8xx-fb.c
> @@ -0,0 +1,887 @@

(fast forward)

> +
> +static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
> +			      unsigned blue, unsigned transp,
> +			      struct fb_info *info)
> +{
> +	struct da8xx_fb_par *par = info->par;
> +	unsigned short *palette = (unsigned short *)par->v_palette_base;
> +	u_short pal;
> +
> +	if (regno > 255)
> +		return 1;
> +
> +	if (info->fix.visual == FB_VISUAL_DIRECTCOLOR)
> +		return 1;
> +
> +	if (info->var.bits_per_pixel == 8) {
> +		red >>= 8;
> +		green >>= 8;
> +		blue >>= 8;

This function is still incorrect. Each color component value passed to the
function is 16 bit.

I assume you have 16-bit word for each palette entry and you want
to pack 4-bit colors like this 0RGB. The shift should be

red >>= 12;

so you reduced the component length to 4 bits then

red <<= 8;

so it is put on correct position in the palette entry.
You fold these two shifts so it is

red >>= 4;

The same logic should be used for all color components.

> +
> +		pal = (red & 0x0f00);
> +		pal |= (green & 0x00f0);
> +		pal |= (blue & 0x000f);
> +
> +		palette[regno] = pal;
> +
> +	} else if ((info->var.bits_per_pixel == 16) && regno < 16) {
> +		memset(palette, 0, 16);

I do not understand what is achieved by zeroing the palette area.

This is what you should use:

red >>= (16 - info->var.red.len)
red <<= info->var.red.offset;

The same logic should be used for all color components.
Then pack them into palette register:

par->pseudo_palette[ regno ] = red | green | blue;

The true color modes do not use the palette entry. I assume
that the value below forces controller to use true color mode.

> +		palette[0] = 0x4000;
> +	}
> +
> +	return 0;
> +}
> +

Regards,
Krzysztof

----------------------------------------------------------------------
Twoja pensja x 3? Otworz Konto Direct!
Sprawdz >>  	 http://link.interia.pl/f2209


------------------------------------------------------------------------------
