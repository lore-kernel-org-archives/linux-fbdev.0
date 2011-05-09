From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 09 May 2011 16:06:13 +0000
Subject: Re: [PATCH] OMAP2: avoid descending into disabled framebuffer dirs
Message-Id: <1304957173.2215.27.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1304952024-28296-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1304952024-28296-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-fbdev@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-omap@vger.kernel.org

On Mon, 2011-05-09 at 10:40 -0400, Mike Frysinger wrote:
> Rather than always add the omap2 dirs to the build list (and thus
> force everyone to generate a useless built-in.o), bind the dirs to
> their relevant kconfig symbol.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  drivers/video/omap2/Makefile |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/omap2/Makefile b/drivers/video/omap2/Makefile
> index d853d05..5ddef12 100644
> --- a/drivers/video/omap2/Makefile
> +++ b/drivers/video/omap2/Makefile
> @@ -1,6 +1,6 @@
>  obj-$(CONFIG_OMAP2_VRAM) += vram.o
>  obj-$(CONFIG_OMAP2_VRFB) += vrfb.o
>  
> -obj-y += dss/
> -obj-y += omapfb/
> +obj-$(CONFIG_OMAP2_DSS) += dss/
> +obj-$(CONFIG_FB_OMAP2) += omapfb/
>  obj-y += displays/

Looks fine to me, applying to DSS tree. Thanks!

 Tomi


