From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] Free when fb can't be registered in
 video/aty/atyfb_base.c
Date: Fri, 26 Oct 2007 20:25:46 -0700
Message-ID: <20071026202546.53b78732.randy.dunlap@oracle.com>
References: <47229AAA.9020907@tiscali.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IlcK9-0002RK-QJ for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Oct 2007 20:26:57 -0700
Received: from rgminet01.oracle.com ([148.87.113.118])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IlcK8-0004Gr-De
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Oct 2007 20:26:57 -0700
In-Reply-To: <47229AAA.9020907@tiscali.nl>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@gmail.com

On Sat, 27 Oct 2007 03:55:54 +0200 Roel Kluin wrote:

> I am a bit uncertain about this one, but I think a 'free' is required here?
> --
> Free buffer when the framebuffer can't be registered
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
> index d775eb6..7ccc78e 100644
> --- a/drivers/video/aty/atyfb_base.c
> +++ b/drivers/video/aty/atyfb_base.c
> @@ -2680,10 +2680,13 @@ static int __devinit aty_init(struct fb_info *info)
>  #endif /* CONFIG_FB_ATY_CT */
>  	info->var = var;
>  
> -	fb_alloc_cmap(&info->cmap, 256, 0);
> +	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
> +		goto aty_init_exit;
>  
> -	if (register_framebuffer(info) < 0)
> +	if (register_framebuffer(info) < 0) {
> +                fb_dealloc_cmap(&info->cmap);

Use tabs for indent above, not spaces.

Yes, looks needed to me.  Hopefully Tony will correct us if we
are wrong.

Also appears to be needed in:
68328fb.c, ambaclcd.c, asiliantfb.c, atafb.c, ...
(I stopped looking for now.)


>  		goto aty_init_exit;
> +	}
>  
>  	fb_list = info;
>  



---
~Randy

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
