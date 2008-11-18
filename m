From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: LCD: fix oops if driver only interested
	in	.set_power
Date: Tue, 18 Nov 2008 18:31:47 +0000
Message-ID: <20081118183147.GB15652@fluff.org.uk>
References: <20081118180350.390792130@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ben@fluff.org.uk>) id 1L2VMe-00074e-MD
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Nov 2008 18:31:52 +0000
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L2VMc-0004fw-8k
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Nov 2008 18:31:51 +0000
Content-Disposition: inline
In-Reply-To: <20081118180350.390792130@fluff.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ben Dooks <ben-linux@fluff.org>
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, Nov 18, 2008 at 06:03:50PM +0000, Ben Dooks wrote:
> The LCD driver core calls LCD drivers when either the
> blanking state or the display mode has changed, but
> does not make any check to see if the called driver
> has a .set_mode method.
> 
> This means if a driver only has a .set_power method
> then the system will OOPS on changing mode (and with
> the console semaphore held so you cannot easily see
> the problem).
> 
> Fix the problem by ensuring that either callback is
> valid before calling it.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> Index: linux.git/drivers/video/backlight/lcd.c
> ===================================================================
> --- linux.git.orig/drivers/video/backlight/lcd.c	2008-11-18 12:59:21.000000000 +0000
> +++ linux.git/drivers/video/backlight/lcd.c	2008-11-18 15:07:25.000000000 +0000
> @@ -43,9 +43,11 @@ static int fb_notifier_callback(struct n
>  	mutex_lock(&ld->ops_lock);
>  	if (!ld->ops->check_fb || ld->ops->check_fb(ld, evdata->info)) {
>  		if (event == FB_EVENT_BLANK)
> -			ld->ops->set_power(ld, *(int *)evdata->data);
> +			if (ld->ops->set_power)
> +				ld->ops->set_power(ld, *(int *)evdata->data);
>  		else

sorry, needed to put {} around the outer if block to keep gcc
happy.

> -			ld->ops->set_mode(ld, evdata->data);
> +			if (ld->ops->set_mode)
> +				ld->ops->set_mode(ld, evdata->data);
>  	}
>  	mutex_unlock(&ld->ops_lock);
>  	return 0;
> 
> -- 
> Ben (ben@fluff.org, http://www.fluff.org/)
> 
>   'a smiley only costs 4 bytes'
> 
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
