From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [patch 1/1] SM501: Update debugging/low
 information messages
Date: Fri, 8 Aug 2008 18:59:47 +0200
Message-ID: <20080808185947.478db561.krzysztof.h1@poczta.fm>
References: <20080806144728.525306982@fluff.org>
	<20080806144728.620509911@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRVED-00086N-Tq for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 09:54:14 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KRVEA-0007hG-GY
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 09:54:13 -0700
In-Reply-To: <20080806144728.620509911@fluff.org>
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
To: Ben Dooks <ben-linux@fluff.org>
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, 06 Aug 2008 15:47:29 +0100
$mailname@fluff.org wrote:

> Make the default output of the SM501 driver to be less noisy wrt to
> message that have low informational value, or simply should be debug.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


> Index: linux-2.6.26-quilt7/drivers/mfd/sm501.c
> ===================================================================
> --- linux-2.6.26-quilt7.orig/drivers/mfd/sm501.c	2008-08-05 11:54:26.000000000 +0100
> +++ linux-2.6.26-quilt7/drivers/mfd/sm501.c	2008-08-05 11:56:09.000000000 +0100
> @@ -624,8 +624,8 @@ unsigned long sm501_set_clock(struct dev
>  
>  	sm501_sync_regs(sm);
>  
> -	dev_info(sm->dev, "gate %08lx, clock %08lx, mode %08lx\n",
> -		 gate, clock, mode);
> +	dev_dbg(sm->dev, "gate %08lx, clock %08lx, mode %08lx\n",
> +		gate, clock, mode);
>  
>  	sm501_mdelay(sm, 16);
>  	mutex_unlock(&sm->clock_lock);
> @@ -743,7 +743,7 @@ static int sm501_register_device(struct 
>  	int ret;
>  
>  	for (ptr = 0; ptr < pdev->num_resources; ptr++) {
> -		printk("%s[%d] flags %08lx: %08llx..%08llx\n",
> +		printk(KERN_DEBUG "%s[%d] flags %08lx: %08llx..%08llx\n",
>  		       pdev->name, ptr,
>  		       pdev->resource[ptr].flags,
>  		       (unsigned long long)pdev->resource[ptr].start,
> 
> -- 
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
> 

----------------------------------------------------------------------
Taniej na zagraniczne komorki!
Sprawdz >>> http://link.interia.pl/f1ece


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
