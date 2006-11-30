From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Remove references to non-existent
 fbmon_valid_timings()
Date: Thu, 30 Nov 2006 16:03:33 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611301600460.11840@pentafluge.infradead.org>
References: <Pine.LNX.4.62.0611241549470.13870@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GpoNw-0005xk-Ig for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 30 Nov 2006 08:03:40 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GpoNt-0002Wj-Je
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 30 Nov 2006 08:03:40 -0800
Received: from localhost ([127.0.0.1])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1GpoNp-0006z3-Im for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 30 Nov 2006 16:03:33 +0000
In-Reply-To: <Pine.LNX.4.62.0611241549470.13870@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


I agree that we should remove fbmon_valid_timings. It has been replaced by 
code in fbmon.c. We should convert amifb and atyfb_base to use the code in
fbmon.c. rivafb_check_var is a example example of fbmon usage.

On Fri, 24 Nov 2006, Geert Uytterhoeven wrote:

> 
> Remove references to non-existent fbmon_valid_timings()
> 
> Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> ---
>  drivers/video/amifb.c          |    8 --------
>  drivers/video/aty/atyfb_base.c |    4 ----
>  include/linux/fb.h             |    2 --
>  3 files changed, 14 deletions(-)
> 
> --- ps3-linux-src.orig/drivers/video/amifb.c
> +++ ps3-linux-src/drivers/video/amifb.c
> @@ -2904,14 +2904,6 @@
>  	par->crsr.spot_x = par->crsr.spot_y = 0;
>  	par->crsr.height = par->crsr.width = 0;
>  
> -#if 0	/* fbmon not done.  uncomment for 2.5.x -brad */
> -	if (!fbmon_valid_timings(pixclock[clk_shift], htotal, vtotal,
> -				 &fb_info)) {
> -		DPRINTK("mode doesn't fit for monitor\n");
> -		return -EINVAL;
> -	}
> -#endif
> -
>  	return 0;
>  }
>  
> --- ps3-linux-src.orig/drivers/video/aty/atyfb_base.c
> +++ ps3-linux-src/drivers/video/aty/atyfb_base.c
> @@ -1495,10 +1495,6 @@
>  	else
>  		info->var.accel_flags = 0;
>  
> -#if 0 /* fbmon is not done. uncomment for 2.5.x -brad */
> -	if (!fbmon_valid_timings(pixclock, htotal, vtotal, info))
> -		return -EINVAL;
> -#endif
>  	aty_crtc_to_var(&crtc, var);
>  	var->pixclock = par->pll_ops->pll_to_var(info, &pll);
>  	return 0;
> --- ps3-linux-src.orig/include/linux/fb.h
> +++ ps3-linux-src/include/linux/fb.h
> @@ -929,8 +929,6 @@
>  #define FB_MODE_IS_FIRST	16
>  #define FB_MODE_IS_FROM_VAR     32
>  
> -extern int fbmon_valid_timings(u_int pixclock, u_int htotal, u_int vtotal,
> -			       const struct fb_info *fb_info);
>  extern int fbmon_dpms(const struct fb_info *fb_info);
>  extern int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var,
>  		       struct fb_info *info);
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
