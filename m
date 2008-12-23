From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 3/4 v5] i.MX31: framebuffer driver
Date: Tue, 23 Dec 2008 13:54:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812231352390.17497@anakin>
References: <Pine.LNX.4.64.0812221922200.5241@axis700.grange>
 <Pine.LNX.4.64.0812221929300.5241@axis700.grange>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752130AbYLWMyV@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0812221929300.5241@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk, adaplas@gmail.com

On Mon, 22 Dec 2008, Guennadi Liakhovetski wrote:
> --- /dev/null
> +++ b/drivers/video/mx3fb.c
> @@ -0,0 +1,1853 @@

> +/**
> + * mx3fb_check_var() - check and adjust framebuffer variable parameters.
> + *
> + * @var:	framebuffer variable parameters
> + * @fbi:	framebuffer information pointer
> + */
> +static int mx3fb_check_var(struct fb_var_screeninfo *var, struct fb_info *fbi)
> +{

    [...]

> +	/* Copy nonstd field to/from sync for fbset usage */
> +	var->sync |= var->nonstd;
> +	var->nonstd |= var->sync;

What's the purpose of this (ab)use of .nonstd?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
