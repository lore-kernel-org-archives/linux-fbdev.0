From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev: fix the fb_find_nearest_mode()
 function
Date: Mon, 10 Oct 2005 16:21:51 +0800
Message-ID: <434A249F.4060503@gmail.com>
References: <20051009092949.GA9610@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOsvY-0002hv-Fy
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Oct 2005 01:22:32 -0700
Received: from zproxy.gmail.com ([64.233.162.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EOsvE-0006ls-6z
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Oct 2005 01:22:40 -0700
Received: by zproxy.gmail.com with SMTP id 14so725351nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 10 Oct 2005 01:22:03 -0700 (PDT)
In-Reply-To: <20051009092949.GA9610@spock.one.pl>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Michal Januszewski <spock@gentoo.org>

Michal Januszewski wrote:
> Currently the fb_find_nearest_mode() function finds a mode with
> screen resolution closest to that described by the 'var' argument
> and with some arbitrary refresh rate (eg. in the following sequence
> of refresh rates: 70 60 53 85 75, 53 is selected).
> 
> This patch fixes the function so that it looks for the closest mode as 
> far as both resolution and refresh rate are concerned. The function's
> first argument is changed to fb_videomode so that the refresh rate can
> be specified by the caller, as fb_var_screeninfo doesn't have any fields
> that could directly hold this data.
> 

I like it. I always wanted to fix this but I keep on forgetting :-)

> Signed-off-by: Michal Januszewski <spock@gentoo.org>
> ---
> 
> diff -Nurp fbdev-orig/drivers/video/console/fbcon.c fbdev/drivers/video/console/fbcon.c
> --- fbdev-orig/drivers/video/console/fbcon.c	2005-10-08 23:14:29.000000000 +0200
> +++ fbdev/drivers/video/console/fbcon.c	2005-10-09 01:03:22.000000000 +0200
> @@ -2758,7 +2758,7 @@ static void fbcon_new_modelist(struct fb
>  			continue;
>  		vc = vc_cons[i].d;
>  		display_to_var(&var, &fb_display[i]);
> -		mode = fb_find_nearest_mode(&var, &info->modelist);
> +		mode = fb_find_nearest_mode(fb_display[i].mode, &info->modelist);
>  		fb_videomode_to_var(&var, mode);
>  
>  		if (vc)
> diff -Nurp fbdev-orig/drivers/video/modedb.c fbdev/drivers/video/modedb.c
> --- fbdev-orig/drivers/video/modedb.c	2005-10-08 23:14:29.000000000 +0200
> +++ fbdev/drivers/video/modedb.c	2005-10-09 01:25:16.000000000 +0200
> @@ -663,6 +663,7 @@ void fb_var_to_videomode(struct fb_video
>  {
>  	u32 pixclock, hfreq, htotal, vtotal;
>  
> +	mode->refresh = 0;

Any reason why you need to set mode->refresh to 0?

Tony


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
