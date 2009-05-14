From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] staging: misplaced parentheses?
Date: Thu, 14 May 2009 09:38:27 -0700
Message-ID: <20090514093827.33a099f7.akpm@linux-foundation.org>
References: <4A0C0C4E.6070401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1M4dxd-0002Rh-1G
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 May 2009 16:39:09 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M4dxW-0004YS-5l
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 May 2009 16:39:09 +0000
In-Reply-To: <4A0C0C4E.6070401@gmail.com>
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
Cc: Benjamin, Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

> Subject: [PATCH] staging: misplaced parentheses?

The title is wrong.

On Thu, 14 May 2009 14:19:26 +0200
Roel Kluin <roel.kluin@gmail.com> wrote:

> The leftmost `+' has a higher precedence than the `?' so this returns
> (vres * hres * (1 << color_mode) + (VMODE && CMODE) ? 0x10 : 0x20) + 0x1000

That seems OK.

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> The original code looks odd, but I am not entirely certain whether my patch is
> correct. So please review.
> 
> diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
> index 03b3670..a88f4b6 100644
> --- a/drivers/video/platinumfb.c
> +++ b/drivers/video/platinumfb.c
> @@ -224,7 +224,7 @@ static inline int platinum_vram_reqd(int video_mode, int color_mode)
>  	return vmode_attrs[video_mode-1].vres *
>  	       (vmode_attrs[video_mode-1].hres * (1<<color_mode) +
>  		((video_mode == VMODE_832_624_75) &&
> -		 (color_mode > CMODE_8)) ? 0x10 : 0x20) + 0x1000;
> +		 (color_mode > CMODE_8) ? 0x10 : 0x20)) + 0x1000;
>  }
>  
>  #define STORE_D2(a, d) { \

The patch changes it to

(vres * hres * (1 << color_mode) + (VMODE && (CMODE ? 0x10 : 0x20)) + 0x1000

I think?  It makes no sense to do (foo && non-zero-value).

------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
