From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 3/15] tridentfb: fix memory leaks in
 removal path
Date: Sun, 8 Feb 2009 15:34:34 +0100
Message-ID: <20090208153434.4b28a2f1.krzysztof.h1@poczta.fm>
References: <20090207121233.0a93b4db@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LWAg4-0005yK-Ph
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Feb 2009 14:30:32 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LWAg2-00042l-6d for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Feb 2009 14:30:32 +0000
In-Reply-To: <20090207121233.0a93b4db@ephemeral>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andres Salomon <dilinger@queued.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Sat, 7 Feb 2009 12:12:33 -0500
Andres Salomon <dilinger@queued.net> wrote:

> 
> We were leaking the cmap memory.
> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>
> ---


Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


>  drivers/video/tridentfb.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
> index 479b2e7..c5369ba 100644
> --- a/drivers/video/tridentfb.c
> +++ b/drivers/video/tridentfb.c
> @@ -1563,6 +1563,7 @@ static void __devexit trident_pci_remove(struct pci_dev *dev)
>  	release_mem_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
>  	pci_set_drvdata(dev, NULL);
>  	kfree(info->pixmap.addr);
> +	fb_dealloc_cmap(&info->cmap);
>  	framebuffer_release(info);
>  }
>  


----------------------------------------------------------------------
Zostan mistrzem parkowania w Bombaju!
Zagraj >> http://link.interia.pl/f204e 


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
