From: Sebastian Siewior <frame+buffer@ml.breakpoint.cc>
Subject: Re: [PATCH v2] [FB] Add the carmine FB driver.
Date: Mon, 21 Apr 2008 12:19:53 +0200
Message-ID: <20080421101953.GB11534@Chamillionaire.breakpoint.cc>
References: <20080421090124.GA11534@Chamillionaire.breakpoint.cc>
	<Pine.LNX.4.64.0804211153520.31538@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jnt83-0006Gt-0A for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 03:20:10 -0700
Received: from chamillionaire.breakpoint.cc ([85.10.199.196]
	ident=G2wL6ZuayTZo\z0haXx|IP)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jnt81-0006jw-6g
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 03:20:06 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0804211153520.31538@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: tglx@linutronix.de, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Antonino Daplas <adaplas@gmail.com>

* Geert Uytterhoeven | 2008-04-21 11:55:56 [+0200]:

>On Mon, 21 Apr 2008, Sebastian Siewior wrote:
>> +static int carmine_check_var(struct fb_var_screeninfo *var,
>> +		struct fb_info *info)
>> +{
>> +
>> +	if (var->xres_virtual < var->xres)
>> +		var->xres_virtual = var->xres;
>> +	if (var->yres_virtual < var->yres)
>> +		var->yres_virtual = var->yres;
>> +
>> +	var->bits_per_pixel = 32;
>> +
>> +#ifdef __BIG_ENDIAN
>> +	var->transp.offset = 24;
>> +	var->red.offset = 0;
>> +	var->green.offset = 8;
>> +	var->blue.offset = 16;
>> +#else
>> +	var->transp.offset = 24;
>> +	var->red.offset = 16;
>> +	var->green.offset = 8;
>> +	var->blue.offset = 0;
>> +#endif
>> +
>> +	var->red.length = 8;
>> +	var->green.length = 8;
>> +	var->blue.length = 8;
>> +	var->transp.length = 8;
>> +
>> +	var->red.msb_right = 0;
>> +	var->green.msb_right = 0;
>> +	var->blue.msb_right = 0;
>> +	var->transp.msb_right = 0;
>> +
>> +	return 0;
>> +}
>
>So carmine_check_var() always returns success, even if the user
>requested for a video mode that is not supported?
I though *var points to something that is from my carmine_modedb[].

>> +static int carmine_set_par(struct fb_info *info)
>> +{
>> +	struct carmine_fb *par = info->par;
>> +
>> +	par->new_mode = carmine_find_mode(&info->var);
>> +
>> +	if (par->cur_mode != par->new_mode) {
>> +
>> +		par->cur_mode = par->new_mode;
>> +		par->res = &car_modes[par->new_mode];
>> +
>> +		carmine_init_display_param(par);
>> +		set_display_parameters(par);
>> +	}
>> +
>> +	info->fix.line_length = info->var.xres * info->var.bits_per_pixel / 8;
>> +	return 0;
>> +}
>
>... in which case you just get the default mode, but info->var still
>contains the parameters for the mode that's not supported?

Oh. Okey, so let me change carmine_check_var() and carmine_set_par() to
fail in case of an unsupported mode.

>
>Gr{oetje,eeting}s,
>
>						Geert

Sebastian

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
