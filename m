From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Re: atyfb h/vsync polarity
Date: Sat, 30 Jul 2005 16:19:32 -0700
Message-ID: <20050730161932.1eebf909.akpm@osdl.org>
References: <20050622140842.GV20191@midgar.lan.raphnet.net>
	<200507221206.44358.adaplas@gmail.com>
	<200507310107.16442.alex.kern@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dz0dF-0003Oz-Ls
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 16:20:41 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1Dz0dE-0000gZ-9K
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 16:20:41 -0700
In-Reply-To: <200507310107.16442.alex.kern@gmx.de>
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
To: Alexander Kern <alex.kern@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, raph@raphnet.net


> --- linux-2.6.12/drivers/video/aty/atyfb_base.c.orig	2005-06-17 21:48:29.000000000 +0200
> +++ linux-2.6.12/drivers/video/aty/atyfb_base.c	2005-07-31 01:01:47.000000000 +0200
> @@ -911,20 +911,6 @@
>  		vdisplay  = par->lcd_height;
>  #endif
>  
> -	if(vdisplay < 400) {
> -		h_sync_pol = 1;
> -		v_sync_pol = 0;
> -	} else if(vdisplay < 480) {
> -		h_sync_pol = 0;
> -		v_sync_pol = 1;
> -	} else if(vdisplay < 768) {
> -		h_sync_pol = 0;
> -		v_sync_pol = 0;
> -	} else {
> -		h_sync_pol = 1;
> -		v_sync_pol = 1;
> -	}
> -
>  	v_disp--;
>  	v_sync_strt--;
>  	v_sync_end--;
> 

I'll duck this one for now.  Tony, please resend when it's had approproate
testing at your end.

Alex, please include a nice changelog with your patches?  Someone has to
write one for this patch now.



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
