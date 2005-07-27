From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2]][RESEND] vesafb: Add blanking
 support
Date: Wed, 27 Jul 2005 10:09:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0507271007530.9140@numbat.sonytel.be>
References: <42E6D8CE.5080007@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxgzC-0003ki-NF
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 01:09:54 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dxgz9-0008On-US
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 01:09:54 -0700
In-Reply-To: <42E6D8CE.5080007@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

On Wed, 27 Jul 2005, Antonino A. Daplas wrote:
>  Add rudimentary support by manipulating the VGA registers. However,
>  not all vesa modes are VGA compatible, so VGA compatiblity is
>  checked first. Only 2 levels are supported, powerup and powerdown.

> +static int vesafb_blank(int blank, struct fb_info *info)
> +{
> +	int err = 1;
> +
> +	if (vga_compat) {
> +		int loop = 10000;
> +		u8 seq = 0, crtc17 = 0;
> +	    +		err = 0;
> +
> +		if (blank) {
> +			seq = 0x20;
> +			crtc17 = 0x00;
> +		} else {
> +			seq = 0x00;
> +			crtc17 = 0x80;
> +		}
> +		+		vga_wseq(NULL, 0x00, 0x01);
> +		seq |= vga_rseq(NULL, 0x01) & ~0x20;
> +		vga_wseq(NULL, 0x00, seq);
> +		+		crtc17 |= vga_rcrt(NULL, 0x17) & ~0x80;
> +		while (loop--);
> +		vga_wcrt(NULL, 0x17, crtc17);
> +		vga_wseq(NULL, 0x00, 0x03);		  +	}
> +
> +	return err;
> +}
> +
> static void vesa_setpalette(int regno, unsigned red, unsigned green,
> 			    unsigned blue)
> {
> @@ -176,6 +209,7 @@
> 	.owner		= THIS_MODULE,
> 	.fb_setcolreg	= vesafb_setcolreg,
> 	.fb_pan_display	= vesafb_pan_display,
> +	.fb_blank       = vesafb_blank,

Is the screen still blanked (by setting all color registers to black in CLUT
mode) if vga_compat is false?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
