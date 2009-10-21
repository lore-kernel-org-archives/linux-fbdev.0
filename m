From: krzysztof.h1@poczta.fm
Subject: Re: 
	=?utf-8?q?=5BPATCH=5D_fbdev=3A_Wrong_test_on_?=
	=?utf-8?q?unsigned_in_fb=5Fset=5Fuser=5Fcmap=28=29=3F?=
Date: 21 Oct 2009 08:50:18 +0200
Message-ID: <20091021065018.7625046CCF3@f46.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1N0V1i-0007Ox-RY
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Oct 2009 06:50:30 +0000
Received: from smtp240.poczta.interia.pl ([217.74.64.240])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N0V1g-0001aa-Br for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Oct 2009 06:50:30 +0000
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>



"Roel Kluin" <roel.kluin@gmail.com> pisze:
> struct fb_cmap_user member start is unsigned.

> 

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

> ---

> Is this required?

> 


Drop the whole if() as exactly the same condition is checked in the fb_set_cmap() again. Anyway, the check of the cmap->start < 0 does not make any sense as the start is u32 value (most userspace addresses will be lower then 2GB on 32 bit system so the error cannot be caught by the check). I vote for removing the (cmap->start < 0) in the fb_set_cmap as well as most drivers check the start value already in driver's fb_setcolreg() function.

Best regards,
Krzysztof


> diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c

> index f53b9f1..f46f05f 100644

> --- a/drivers/video/fbcmap.c

> +++ b/drivers/video/fbcmap.c

> @@ -266,7 +266,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct
> fb_info *info)

>  		rc = -ENODEV;

>  		goto out;

>  	}

> -	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&

> +	if ((int)cmap->start < 0 || (!info->fbops->fb_setcolreg &&

>  				!info->fbops->fb_setcmap)) {

>  		rc = -EINVAL;

>  		goto out1;

> 

> ------------------------------------------------------------------------------

> Come build with us! The BlackBerry(R) Developer Conference in SF, CA

> is the only developer event you need to attend this year. Jumpstart your

> developing skills, take BlackBerry mobile applications to market and stay
> 

> ahead of the curve. Join us from November 9 - 12, 2009. Register now!

> http://p.sf.net/sfu/devconference

> _______________________________________________

> Linux-fbdev-devel mailing list

> Linux-fbdev-devel@lists.sourceforge.net

> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

> 
> 






----------------------------------------------------------------------
Zobacz najwiekszy samolot na swiecie!  
Kliknij >>> http://link.interia.pl/f238f


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
