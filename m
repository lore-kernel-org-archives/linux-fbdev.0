From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] atyfb: Fix power management
Date: Tue, 2 Nov 2004 19:47:27 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411021946060.2187@ppc970.osdl.org>
References: <1099451704.31629.28.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPC7R-0002Ap-1f
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 19:47:33 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPC7Q-0006xQ-G6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 19:47:32 -0800
In-Reply-To: <1099451704.31629.28.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>



On Wed, 3 Nov 2004, Benjamin Herrenschmidt wrote:
> 
> The PM code in atyfb got broken in the recent update. This is just a typo though,
> here's a fix:

Ok, this comment makes no sense. Which is it? It's certainly more than a 
typo, you're literally changing the return value behaviour to be the 
reverse of what it was.

Now, I think your fix is right, but your checkin comment doesn't make any 
sense. Can you phrase that better?

		Linus

> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Index: linux-work/drivers/video/aty/atyfb_base.c
> ===================================================================
> --- linux-work.orig/drivers/video/aty/atyfb_base.c	2004-11-03 14:13:10.319998376 +1100
> +++ linux-work/drivers/video/aty/atyfb_base.c	2004-11-03 14:13:45.491651472 +1100
> @@ -2015,7 +2015,7 @@
>  	}
>  	mdelay(500);
>  
> -	return timeout ? -1 : 0;
> +	return timeout ? 0 : -EIO;
>  }
>  
>  static int atyfb_pci_suspend(struct pci_dev *pdev, u32 state)
> 


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
