From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc9 3/5] pxafb: add shared
 framebuffer interface
Date: Thu, 31 Jul 2008 17:28:41 +0200
Message-ID: <20080731172841.103671c1.krzysztof.h1@poczta.fm>
References: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
	<1217422269-11093-4-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOa09-0001PI-21 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 08:23:37 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOa07-0004Sj-Cn
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 08:23:37 -0700
In-Reply-To: <1217422269-11093-4-git-send-email-jayakumar.lkml@gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Wed, 30 Jul 2008 08:51:07 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> These changes are to make it possible for a secondary driver to share the
> pxafb framebuffer. The changes include:
> - adding extra_video_mem entry so that a driver can tell pxafb of its
>   additional needs.
> - adding share_video_mem/unshare_video_mem callbacks to notify the secondary
>   driver of the framebuffer address, to allow refcounting, and to cleanup on
>   completion.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---
> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index bb25143..f799c52 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c
> @@ -57,6 +57,8 @@
>   */
>  #define DEBUG_VAR 1
>  
> +static struct platform_driver pxafb_driver;
> +

Not needed - see below

(...)

> -static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi)
> +static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi,
> +						struct pxafb_mach_info *inf)
>  {
> +	int ret;
>  	/*
>  	 * We reserve one page for the palette, plus the size
>  	 * of the framebuffer.
>  	 */
>  	fbi->video_offset = PAGE_ALIGN(sizeof(struct pxafb_dma_buff));
> -	fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + fbi->video_offset);
> +	fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + fbi->video_offset +
> +					inf->extra_video_mem);
>  	fbi->map_cpu = dma_alloc_writecombine(fbi->dev, fbi->map_size,
>  					      &fbi->map_dma, GFP_KERNEL);
>  
> @@ -1340,6 +1346,13 @@ static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi)
>  		fbi->smart_cmds = (uint16_t *) fbi->dma_buff->cmd_buff;
>  		fbi->n_smart_cmds = 0;
>  #endif
> +		if (inf->share_video_mem) {
> +			ret = inf->share_video_mem(fbi->fb.screen_base,
> +				fbi->screen_dma, pxafb_driver.driver.owner,

You should use here either THIS_MODULE or runtime information
from fbi->fb.device.driver.owner.

> +				inf->extra_data);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  

The rest of the patch is ok.

Regards,
Krzysztof


----------------------------------------------------------------------
Partyjka w Chinczyka?
Graj >>> http://link.interia.pl/f1e67


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
