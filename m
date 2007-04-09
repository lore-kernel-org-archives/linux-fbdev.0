From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 1/7] fbdev: Don't show logo if
	driver or
Date: Mon, 9 Apr 2007 17:29:55 +0200
Message-ID: <20070409172955.6ef76537@hyperion.delvare>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Havp8-0001eG-JC for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 08:30:30 -0700
Received: from smtp-101-monday.nerim.net ([62.4.16.101] helo=kraid.nerim.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Havp6-0001FK-S5
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 08:30:30 -0700
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
To: Antonino Daplas <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

(Sorry for the referenceless reply, but I am not subscribed to
linux-fbdev-devel.)

> It was always intended for the logo to be drawn only if both fbcon and the
> driver that is mapped to it are both compiled statically.  Currently, if fbcon
> is loaded prior to the driver, the logo is not shown.  Reverse the order, and
> the code may attempt to draw the logo which is __initdata.  By accident, this
> bug is rarely seen because this method of loading the modules is not common
> and secondly, a code in fb_prepare_logo() that checks the height of the logo
> (now a random value) rarely succeeds.
> 
> Fix by drawing the logo only if both fbcon and the driver are statically
> compiled.
> 
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> ---
> 
>  drivers/video/console/fbcon.c |   17 +++++++++++++++++
>  drivers/video/fbmem.c         |    6 ++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> index f1e3e3c..0d8e107 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -107,7 +107,9 @@ static struct display fb_display[MAX_NR_
>  
>  static signed char con2fb_map[MAX_NR_CONSOLES];
>  static signed char con2fb_map_boot[MAX_NR_CONSOLES];
> +#ifndef MODULE
>  static int logo_height;
> +#endif
>  static int logo_lines;
>  /* logo_shown is an index to vc_cons when >= 0; otherwise follows FBCON_LOGO
>     enums.  */
> @@ -576,6 +578,13 @@ static int fbcon_takeover(int show_logo)
>  	return err;
>  }
>  
> +#ifdef MODULE
> +static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
> +			       int cols, int rows, int new_cols, int new_rows)
> +{
> +	logo_shown = FBCON_LOGO_DONTSHOW;
> +}
> +#else
>  static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
>  			       int cols, int rows, int new_cols, int new_rows)
>  {
> @@ -584,6 +593,11 @@ static void fbcon_prepare_logo(struct vc
>  	int cnt, erase = vc->vc_video_erase_char, step;
>  	unsigned short *save = NULL, *r, *q;
>  
> +	if (info->flags & FBINFO_MODULE) {
> +		logo_shown = FBCON_LOGO_DONTSHOW;
> +		goto done;
> +	}
> +
>  	/*
>  	 * remove underline attribute from erase character
>  	 * if black and white framebuffer.
> @@ -654,7 +668,10 @@ static void fbcon_prepare_logo(struct vc
>  		logo_shown = FBCON_LOGO_DRAW;
>  		vc->vc_top = logo_lines;
>  	}
> +
> +done:
>  }
> +#endif /* MODULE */

This fails to compile here:
drivers/video/console/fbcon.c: In function 'fbcon_prepare_logo':
drivers/video/console/fbcon.c:668: error: label at end of compound statement

And indeed, a simple "return" instead of "goto done" sounds more
logical.

>  
>  #ifdef CONFIG_FB_TILEBLITTING
>  static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 45f3839..08c292d 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -418,7 +418,8 @@ int fb_prepare_logo(struct fb_info *info
>  
>  	memset(&fb_logo, 0, sizeof(struct logo_data));
>  
> -	if (info->flags & FBINFO_MISC_TILEBLITTING)
> +	if (info->flags & FBINFO_MISC_TILEBLITTING ||
> +	    info->flags & FBINFO_MODULE)
>  		return 0;
>  
>  	if (info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
> @@ -483,7 +484,8 @@ int fb_show_logo(struct fb_info *info, i
>  	struct fb_image image;
>  
>  	/* Return if the frame buffer is not mapped or suspended */
> -	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
> +	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING ||
> +	    info->flags & FBINFO_MODULE)
>  		return 0;
>  
>  	image.depth = 8;


-- 
Jean Delvare

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
