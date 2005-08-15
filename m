From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 2/2] intelfb/fbdev: Save info->flags
 in a local variable
Date: Mon, 15 Aug 2005 17:31:54 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508151729060.7300@pentafluge.infradead.org>
References: <430098A7.1080102@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4hsV-0006tg-9G
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 09:31:59 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E4hsV-0007yh-1K
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 09:31:59 -0700
In-Reply-To: <430098A7.1080102@gmail.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, Pavel Kysilka <goldenfish@bsys.cz>


> fbmem.c |    6 +++---
> 1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -643,8 +643,8 @@ fb_pan_display(struct fb_info *info, str
>  int
>  fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>  {
> -	int err;
> -
> +	int err, flags = info->flags;
> +
>  	if (var->activate & FB_ACTIVATE_INV_MODE) {
>  		struct fb_videomode mode1, mode2;
>  		int ret = 0;
> @@ -697,7 +697,7 @@ fb_set_var(struct fb_info *info, struct 
>  			    !list_empty(&info->modelist))
>  				err = fb_add_videomode(&mode, &info->modelist);
>  
> -			if (!err && info->flags & FBINFO_MISC_USEREVENT) {
> +			if (!err && flags & FBINFO_MISC_USEREVENT) {
>  				struct fb_event event;
>  				int evnt = (var->activate & FB_ACTIVATE_ALL) ?
>  					FB_EVENT_MODE_CHANGE_ALL :

I take that back. I misread the code. You are not overwriting the new 
flag. The patch is good :-)



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
