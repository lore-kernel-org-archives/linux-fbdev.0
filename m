From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 2/15] tdfxfb: fix memory leaks in
 removal path
Date: Sun, 8 Feb 2009 15:33:26 +0100
Message-ID: <20090208153326.4ae93d66.krzysztof.h1@poczta.fm>
References: <20090207121224.1e162373@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LWAf5-0005v4-3s
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Feb 2009 14:29:31 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LWAf0-0007zl-HQ for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Feb 2009 14:29:31 +0000
In-Reply-To: <20090207121224.1e162373@ephemeral>
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

On Sat, 7 Feb 2009 12:12:24 -0500
Andres Salomon <dilinger@queued.net> wrote:

> 
> We were leaking the cmap memory.
> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

>  drivers/video/tdfxfb.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
> index 14bd3f3..ee64771 100644
> --- a/drivers/video/tdfxfb.c
> +++ b/drivers/video/tdfxfb.c
> @@ -1393,6 +1393,7 @@ static void __devexit tdfxfb_remove(struct pci_dev *pdev)
>  	release_mem_region(pci_resource_start(pdev, 0),
>  			   pci_resource_len(pdev, 0));
>  	pci_set_drvdata(pdev, NULL);
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
