From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [REPOST PATCH] gbefb: cmap FIFO timeout
Date: Tue, 29 Jul 2008 17:37:45 -0700
Message-ID: <20080729173745.7428ce62.akpm@linux-foundation.org>
References: <20080729221204.25D97C2F34@solo.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KNzi7-0007Wu-5W for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 17:38:35 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KNzi5-0006SM-Qd
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 17:38:35 -0700
In-Reply-To: <20080729221204.25D97C2F34@solo.franken.de>
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
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@linux-mips.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

On Wed, 30 Jul 2008 00:12:04 +0200 (CEST)
Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:

> +static void gbe_loadcmap(void)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < 256; i++) {
> +		for (j = 0; j < 1000 && gbe->cm_fifo >= 63; j++)
> +			udelay(10);
> +		if (j == 1000)
> +			printk(KERN_ERR "gbefb: cmap FIFO timeout\n");
> +
> +		gbe->cmap[i] = gbe_cmap[i];
> +	}
>  }

This is polling the hardware, yes?

I'd have thought there's a terrible risk of the compiler "optimising"
the read of gbe->cm_fifo.  Shouldn't we be using readl() here?

<looks>

oh.  It's declared volatile.  ugh.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
