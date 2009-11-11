From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH/RFC] fb: put framebuffer drivers back under the
 "frame buffer devices" menu
Date: Tue, 10 Nov 2009 16:51:14 -0800
Message-ID: <20091110165114.4972b8b4.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0911082339090.24656@axis700.grange>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0911082339090.24656@axis700.grange>
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>

On Sun, 8 Nov 2009 23:46:24 +0100 (CET)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> The config FB_PRE_INIT_FB entry in drivers/video/Kconfig pushes all entries
> below it out of the menuconfig selection. Fix this.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> This is _most_ _probably_ not a right fix, but rather an observation, that 
> the patch below fixes the problem, whereby all entires below 
> FB_PRE_INIT_FB get displaced from the "frame buffer devices" menu. A bug 
> in kconfig? The additional dependency on FB in this patch is certainly 
> redundant.
> 
>  drivers/video/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 9bbb285..188e1ba 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2121,7 +2121,7 @@ config FB_EP93XX
>  
>  config FB_PRE_INIT_FB
>  	bool "Don't reinitialize, use bootloader's GDC/Display configuration"
> -	depends on FB_MB862XX_LIME
> +	depends on FB && FB_MB862XX_LIME
>  	---help---
>  	  Select this option if display contents should be inherited as set by
>  	  the bootloader.

hmm, well, lots of surrounding records also have `depends on FB', and
it fixes the bug, so I see no problem with using the patch as-is.

