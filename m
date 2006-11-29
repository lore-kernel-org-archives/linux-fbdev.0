From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 1/6] FB: Get the Geode GX frambuffer
 size from the BIOS
Date: Wed, 29 Nov 2006 14:21:18 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611291420530.26581@pentafluge.infradead.org>
References: <20061128230639.25769.43.stgit@cosmic.amd.com>
	<20061128231447.25769.6360.stgit@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GpQJe-0000Zz-P9 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 29 Nov 2006 06:21:38 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GpQJd-00045d-4p
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 29 Nov 2006 06:21:38 -0800
In-Reply-To: <20061128231447.25769.6360.stgit@cosmic.amd.com>
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
> Use the Geode GX BIOS virtual registers to get the actual size of the
> framebuffer.
> 
> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> ---
> 
>  drivers/video/geode/display_gx.c |   15 ++++++++++++---
>  drivers/video/geode/display_gx.h |    2 +-
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/geode/display_gx.c b/drivers/video/geode/display_gx.c
> index 825c340..0245169 100644
> --- a/drivers/video/geode/display_gx.c
> +++ b/drivers/video/geode/display_gx.c
> @@ -21,10 +21,19 @@ #include <asm/delay.h>
>  #include "geodefb.h"
>  #include "display_gx.h"
>  
> -int gx_frame_buffer_size(void)
> +unsigned int gx_frame_buffer_size(void)
>  {
> -	/* Assuming 16 MiB. */
> -	return 16*1024*1024;
> +	unsigned int val;
> +
> +	/* FB size is reported by a virtual register */
> +	/* Virtual register class = 0x02 */
> +	/* VG_MEM_SIZE(512Kb units) = 0x00 */
> +
> +	outw(0xFC53, 0xAC1C);
> +	outw(0x0200, 0xAC1C);
> +
> +	val = (unsigned int)(inw(0xAC1E)) & 0xFFl;
> +	return (val << 19);
>  }
>  
>  int gx_line_delta(int xres, int bpp)
> diff --git a/drivers/video/geode/display_gx.h b/drivers/video/geode/display_gx.h
> index 86c6233..41e79f4 100644
> --- a/drivers/video/geode/display_gx.h
> +++ b/drivers/video/geode/display_gx.h
> @@ -11,7 +11,7 @@
>  #ifndef __DISPLAY_GX_H__
>  #define __DISPLAY_GX_H__
>  
> -int gx_frame_buffer_size(void);
> +unsigned int gx_frame_buffer_size(void);
>  int gx_line_delta(int xres, int bpp);
>  
>  extern struct geode_dc_ops gx_dc_ops;
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
