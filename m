From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] MAINTAINERS: mark framebuffer as Orphan
Date: Thu, 15 Feb 2007 22:26:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702152224570.6415@pentafluge.infradead.org>
References: <20070215132549.c182f7bf.randy.dunlap@oracle.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161532AbXBOW0N@vger.kernel.org>
In-Reply-To: <20070215132549.c182f7bf.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net


I wouldn't say it orphan. I just can't spend 8 hours a day on it. 
Alot of patches have been flowing into the layer.

On Thu, 15 Feb 2007, Randy Dunlap wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Are we ready to do this?
> I'd love for Tony to return, but he's been missing for awhile now.
> 
> So this give us the following major areas that are marked as Orphan:
> 
> Firmware loader
> Framebuffer
> Serial (8250/16x50)
> 
> and PCMCIA has a Team.  It doesn't seem to be hurting.  :)
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  MAINTAINERS |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- linux-2.6.20-git9.orig/MAINTAINERS
> +++ linux-2.6.20-git9/MAINTAINERS
> @@ -1321,11 +1321,9 @@ W:	http://www.farsite.co.uk/
>  S:	Supported
>  
>  FRAMEBUFFER LAYER
> -P:	Antonino Daplas
> -M:	adaplas@pol.net
>  L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
>  W:	http://linux-fbdev.sourceforge.net/
> -S:	Maintained
> +S:	Orphan
>  
>  FREESCALE SOC FS_ENET DRIVER
>  P:	Pantelis Antoniou
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
