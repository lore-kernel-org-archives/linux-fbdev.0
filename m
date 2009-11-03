From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fbdev: Fix test on unsigned in
	fb_do_show_logo()
Date: Mon, 2 Nov 2009 16:32:52 -0800
Message-ID: <20091102163252.e76491e6.akpm@linux-foundation.org>
References: <4AD8F77A.3010802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1N57L9-0005sS-0x
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Nov 2009 00:33:39 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N57L2-0005fB-AQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Nov 2009 00:33:37 +0000
In-Reply-To: <4AD8F77A.3010802@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>

On Sat, 17 Oct 2009 00:45:14 +0200
Roel Kluin <roel.kluin@gmail.com> wrote:

> image->d[xy] are unsigned so the check was wrong.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 99bbd28..9f20641 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -403,7 +403,8 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
>  			image->dx += image->width + 8;
>  		}
>  	} else if (rotate == FB_ROTATE_UD) {
> -		for (x = 0; x < num && image->dx >= 0; x++) {
> +		for (x = 0; x < num && image->dx + image->width + 8 >= 0;
> +				x++) {
>  			info->fbops->fb_imageblit(info, image);
>  			image->dx -= image->width + 8;
>  		}
> @@ -415,7 +416,8 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
>  			image->dy += image->height + 8;
>  		}
>  	} else if (rotate == FB_ROTATE_CCW) {
> -		for (x = 0; x < num && image->dy >= 0; x++) {
> +		for (x = 0; x < num && image->dy + image->height + 8 >= 0;
> +				x++) {
>  			info->fbops->fb_imageblit(info, image);
>  			image->dy -= image->height + 8;
>  		}

Presumably that test isn't needed at all?

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
