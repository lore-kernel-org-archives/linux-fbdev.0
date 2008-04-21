From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] [FB] Add the carmine FB driver.
Date: Mon, 21 Apr 2008 11:55:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804211153520.31538@anakin>
References: <20080421090124.GA11534@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jnskr-00038H-5Y for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 02:56:09 -0700
Received: from winston.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jnskp-00019b-IB
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 02:56:09 -0700
In-Reply-To: <20080421090124.GA11534@Chamillionaire.breakpoint.cc>
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
To: Sebastian Siewior <frame+buffer@ml.breakpoint.cc>
Cc: tglx@linutronix.de, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Antonino Daplas <adaplas@gmail.com>

On Mon, 21 Apr 2008, Sebastian Siewior wrote:
> +static int carmine_check_var(struct fb_var_screeninfo *var,
> +		struct fb_info *info)
> +{
> +
> +	if (var->xres_virtual < var->xres)
> +		var->xres_virtual = var->xres;
> +	if (var->yres_virtual < var->yres)
> +		var->yres_virtual = var->yres;
> +
> +	var->bits_per_pixel = 32;
> +
> +#ifdef __BIG_ENDIAN
> +	var->transp.offset = 24;
> +	var->red.offset = 0;
> +	var->green.offset = 8;
> +	var->blue.offset = 16;
> +#else
> +	var->transp.offset = 24;
> +	var->red.offset = 16;
> +	var->green.offset = 8;
> +	var->blue.offset = 0;
> +#endif
> +
> +	var->red.length = 8;
> +	var->green.length = 8;
> +	var->blue.length = 8;
> +	var->transp.length = 8;
> +
> +	var->red.msb_right = 0;
> +	var->green.msb_right = 0;
> +	var->blue.msb_right = 0;
> +	var->transp.msb_right = 0;
> +
> +	return 0;
> +}

So carmine_check_var() always returns success, even if the user
requested for a video mode that is not supported?

> +static int carmine_set_par(struct fb_info *info)
> +{
> +	struct carmine_fb *par = info->par;
> +
> +	par->new_mode = carmine_find_mode(&info->var);
> +
> +	if (par->cur_mode != par->new_mode) {
> +
> +		par->cur_mode = par->new_mode;
> +		par->res = &car_modes[par->new_mode];
> +
> +		carmine_init_display_param(par);
> +		set_display_parameters(par);
> +	}
> +
> +	info->fix.line_length = info->var.xres * info->var.bits_per_pixel / 8;
> +	return 0;
> +}

... in which case you just get the default mode, but info->var still
contains the parameters for the mode that's not supported?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
