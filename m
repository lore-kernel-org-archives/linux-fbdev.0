From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 5/6] [PATCH] gxfb: Fixup flatpanel
 detection
Date: Wed, 29 Nov 2006 14:22:04 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611291422000.26581@pentafluge.infradead.org>
References: <20061128230639.25769.43.stgit@cosmic.amd.com>
	<20061128231517.25769.43800.stgit@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GpQKB-0000fi-9z for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 29 Nov 2006 06:22:11 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GpQK6-0004KW-OI
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 29 Nov 2006 06:22:11 -0800
In-Reply-To: <20061128231517.25769.43800.stgit@cosmic.amd.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: info-linux@ldcmail.amd.com, akpm@osdl.org



Acked-By: James Simmons <jsimmons@infradead.org>

On Tue, 28 Nov 2006, Jordan Crouse wrote:

> From: Jordan Crouse <jordan.crouse@amd.com>
> 
> Use the right MSR and bits to detect if the GX is strapped for TFT or CRT
> 
> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> ---
> 
>  drivers/video/geode/display_gx.h |    2 +-
>  drivers/video/geode/gxfb_core.c  |    2 +-
>  drivers/video/geode/video_gx.h   |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/geode/display_gx.h b/drivers/video/geode/display_gx.h
> index ba0ccc8..0af33f3 100644
> --- a/drivers/video/geode/display_gx.h
> +++ b/drivers/video/geode/display_gx.h
> @@ -18,7 +18,7 @@ extern struct geode_dc_ops gx_dc_ops;
>  
>  /* MSR that tells us if a TFT or CRT is attached */
>  #define GLD_MSR_CONFIG   0xC0002001
> -#define GLD_MSR_CONFIG_FMT_FP 0x01
> +#define GLD_MSR_CONFIG_DM_FP 0x40
>  
>  /* Display controller registers */
>  
> diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
> index d404f56..83ab18a 100644
> --- a/drivers/video/geode/gxfb_core.c
> +++ b/drivers/video/geode/gxfb_core.c
> @@ -328,7 +328,7 @@ static int __init gxfb_probe(struct pci_
>  
>  	rdmsrl(GLD_MSR_CONFIG, val);
>  
> -	if (val & GLD_MSR_CONFIG_FMT_FP)
> +	if ((val & GLD_MSR_CONFIG_DM_FP) == GLD_MSR_CONFIG_DM_FP)
>  		par->enable_crt = 0;
>  	else
>  		par->enable_crt = 1;
> diff --git a/drivers/video/geode/video_gx.h b/drivers/video/geode/video_gx.h
> index 8f1e85b..119d0ab 100644
> --- a/drivers/video/geode/video_gx.h
> +++ b/drivers/video/geode/video_gx.h
> @@ -14,7 +14,7 @@ #define __VIDEO_GX_H__
>  extern struct geode_vid_ops gx_vid_ops;
>  
>  /* GX Flatpanel control MSR */
> -#define GX_VP_MSR_PAD_SELECT           0x2011
> +#define GX_VP_MSR_PAD_SELECT           0xC0002011
>  #define GX_VP_PAD_SELECT_MASK          0x3FFFFFFF
>  #define GX_VP_PAD_SELECT_TFT           0x1FFFFFFF
>  
> 
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
