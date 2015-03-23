From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 23 Mar 2015 11:17:27 +0000
Subject: Re: [PATCH 01/13] staging: sm750: Reintend
Message-Id: <20150323111727.GC10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150322230807.GA16817@x230-arch.club.entropia.de>
In-Reply-To: <20150322230807.GA16817@x230-arch.club.entropia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Mar 23, 2015 at 12:08:07AM +0100, Michel von Czettritz wrote:
> The reintend fixes the

Spelling.  re-indent.

>  typedef void (*PROC_SPEC_SETUP)(struct lynx_share*,char *);
> @@ -76,54 +76,54 @@ static inline void myspin_unlock(spinlock_t * sl){
>  static const struct fb_videomode lynx750_ext[] = {
>  	/*  	1024x600-60 VESA 	[1.71:1]	*/
>  	{NULL,  60, 1024, 600, 20423, 144,  40, 18, 1, 104, 3,
> -	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
> +		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
>  

Do it like this:

	{NULL,  60, 1024, 600, 20423, 144,  40, 18, 1, 104, 3,
	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},

> @@ -141,8 +141,8 @@ static int lynxfb_ops_cursor(struct fb_info* info,struct fb_cursor* fbcursor)
>  	cursor = &crtc->cursor;
>  
>  	if(fbcursor->image.width > cursor->maxW ||
> -		fbcursor->image.height > cursor->maxH ||
> -		 fbcursor->image.depth > 1){
> +			fbcursor->image.height > cursor->maxH ||
> +			fbcursor->image.depth > 1){


This should be:

	if (fbcursor->image.width > cursor->maxW ||
            fbcursor->image.height > cursor->maxH ||
	    fbcursor->image.depth > 1)
		return -ENXIO;

The new indenting is whacky.


>  		return -ENXIO;
>  	}
>  
> @@ -153,19 +153,19 @@ static int lynxfb_ops_cursor(struct fb_info* info,struct fb_cursor* fbcursor)
>  
>  	if(fbcursor->set & FB_CUR_SETPOS){
>  		cursor->setPos(cursor,fbcursor->image.dx - info->var.xoffset,
> -								fbcursor->image.dy - info->var.yoffset);
> +				fbcursor->image.dy - info->var.yoffset);
>  	}

This should be:

		cursor->setPos(cursor, fbcursor->image.dx - info->var.xoffset,
			       fbcursor->image.dy - info->var.yoffset);

[tab][tab][tab][space][space][space][space][space][space][space]fbcursor->


Etc.

regards,
dan carpenter

