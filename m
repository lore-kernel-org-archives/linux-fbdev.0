From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: mono, gray and index configs
Date: Mon, 22 Aug 2005 12:17:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508221203410.24432@numbat.sonytel.be>
References: <9e47339105081020216574ac7e@mail.gmail.com> <42FAE3F8.8080902@gmail.com>
 <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be>
 <b00ca3bd05081104086fa9e639@mail.gmail.com> <Pine.LNX.4.62.0508111344070.1037@numbat.sonytel.be>
 <42FB8C29.4070503@gmail.com> <9e47339105081112142c67e1a8@mail.gmail.com><43069BE0.80604@gmail.com>
 <9e473391050819200950020d7@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E79NS-0003tj-Vj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 03:18:02 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E79NS-000140-Dl
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 03:18:02 -0700
In-Reply-To: <9e473391050819200950020d7@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 19 Aug 2005, Jon Smirl wrote:
> The patch is just for testing, don't send it on. The radeonfb portion
> is definitely not finished.
> 
> This adds an optional function to each driver that advertises what
> configs it offers.
> 
> +char *radeonfb_getconfigs(struct fb_info *info)
> +{
> +	return "I4\nI8\nA1R5G5B5\nR5G6B5\nR8G8B8\nA8R8G8B8\nA4R4G4B4\nA8I8\nA2R10G10B10\n";
> +}
>  
>   static struct fb_ops radeonfb_ops = {
>  	.owner			= THIS_MODULE,
> @@ -1873,6 +1909,7 @@ static struct fb_ops radeonfb_ops = {
>  	.fb_fillrect		= radeonfb_fillrect,
>  	.fb_copyarea		= radeonfb_copyarea,
>  	.fb_imageblit		= radeonfb_imageblit,
> +	.fb_get_configs		= radeonfb_getconfigs,
>  };

Do we really need this?

You can easily write a `probe loop' to find out about all supported configs for
a driver like this:

    for_all_possible_configs(config) {
	struct fb_var_screeninfo var;
	set_up_var(var, config);
	var.activate |= FB_ACTIVATE_TEST;
	if (ioctl(FBIOPUT_VSCREENINFO)) {
	    /* config not supported */
	} else if (config_has_changed(var, config) {
	    /* config not supported */
	} else {
	    /* config is supported */
	}
    }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
