From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] atmel_lcdfb: Correct fifo size for
	some products
Date: Thu, 28 May 2009 00:35:26 -0700
Message-ID: <20090528003526.542d306e.akpm@linux-foundation.org>
References: <4A0D452A.4000805@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1M9a9N-0003xb-8R
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 May 2009 07:35:41 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9a9H-0008CM-UR
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 May 2009 07:35:41 +0000
In-Reply-To: <4A0D452A.4000805@atmel.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Andrew Victor <avictor.za@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, Haavard Skinnemoen <hskinnemoen@atmel.com>

On Fri, 15 May 2009 12:34:18 +0200 Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Remove wrong fifo size definition for some AT91 products.
> 
> Due to a misunderstanding of some AT91 datasheets, a fifo size of 2048 (words)
> has been introduced by mistake. In fact, all products (AT91/AT32) are sharing
> the same fifo size of 512 words.
> 

Changelog fails to describe the impact of the bug, so people who are
working out which kernel versions it should be ported into don't know
what to do.

Furthermore, people who are hitting a bug in this driver in older
kernel versions will have difficulty working out whether this patch
might fix their bug.

> Can we consider this fix for .30-final ?

Sure, but for what reason?

What about 2.6.29.x, 2.6.28.x, earlier?

> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -29,14 +29,8 @@
>  
>  /* configurable parameters */
>  #define ATMEL_LCDC_CVAL_DEFAULT		0xc8
> -#define ATMEL_LCDC_DMA_BURST_LEN	8
> -
> -#if defined(CONFIG_ARCH_AT91SAM9263) || defined(CONFIG_ARCH_AT91CAP9) || \
> -	defined(CONFIG_ARCH_AT91SAM9RL)
> -#define ATMEL_LCDC_FIFO_SIZE		2048
> -#else
> -#define ATMEL_LCDC_FIFO_SIZE		512
> -#endif
> +#define ATMEL_LCDC_DMA_BURST_LEN	8	/* words */
> +#define ATMEL_LCDC_FIFO_SIZE		512	/* words */
>  
>  #if defined(CONFIG_ARCH_AT91)
>  #define	ATMEL_LCDFB_FBINFO_DEFAULT	(FBINFO_DEFAULT \


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
