From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 13 Dec 2015 19:13:21 +0000
Subject: Re: [PATCH RFC 7/9] omapfb: move vrfb into omapfb
Message-Id: <26366528.DG0zY3a8a2@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
 <1449757535-5674-8-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449757535-5674-8-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi Tomi,

Thank you for the patch.

On Thursday 10 December 2015 16:25:33 Tomi Valkeinen wrote:
> VRFB is only used by omapfb, so we can move it under omapfb's directory.

Do you see any specific blocker for support of vrfb in omapdss, apart from 
finding time (and a reason) to implement it ?

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/fbdev/omap2/Kconfig             | 3 ---
>  drivers/video/fbdev/omap2/Makefile            | 2 --
>  drivers/video/fbdev/omap2/omapfb/Kconfig      | 3 +++
>  drivers/video/fbdev/omap2/omapfb/Makefile     | 1 +
>  drivers/video/fbdev/omap2/{ => omapfb}/vrfb.c | 0
>  5 files changed, 4 insertions(+), 5 deletions(-)
>  rename drivers/video/fbdev/omap2/{ => omapfb}/vrfb.c (100%)
> 
> diff --git a/drivers/video/fbdev/omap2/Kconfig
> b/drivers/video/fbdev/omap2/Kconfig index c22955d2de9a..7fbdb583de8c 100644
> --- a/drivers/video/fbdev/omap2/Kconfig
> +++ b/drivers/video/fbdev/omap2/Kconfig
> @@ -1,6 +1,3 @@
> -config OMAP2_VRFB
> -	bool
> -
>  if ARCH_OMAP2PLUS
> 
>  source "drivers/video/fbdev/omap2/dss/Kconfig"
> diff --git a/drivers/video/fbdev/omap2/Makefile
> b/drivers/video/fbdev/omap2/Makefile index c73a1e864ae8..a52b716a40c1
> 100644
> --- a/drivers/video/fbdev/omap2/Makefile
> +++ b/drivers/video/fbdev/omap2/Makefile
> @@ -1,5 +1,3 @@
> -obj-$(CONFIG_OMAP2_VRFB) += vrfb.o
> -
>  obj-y += dss/
>  obj-y += displays-new/
>  obj-y += omapfb/
> diff --git a/drivers/video/fbdev/omap2/omapfb/Kconfig
> b/drivers/video/fbdev/omap2/omapfb/Kconfig index 13d99a9e6198..e6226aeed17e
> 100644
> --- a/drivers/video/fbdev/omap2/omapfb/Kconfig
> +++ b/drivers/video/fbdev/omap2/omapfb/Kconfig
> @@ -1,3 +1,6 @@
> +config OMAP2_VRFB
> +	bool
> +
>  menuconfig FB_OMAP2
>          tristate "OMAP2+ frame buffer support"
>          depends on FB
> diff --git a/drivers/video/fbdev/omap2/omapfb/Makefile
> b/drivers/video/fbdev/omap2/omapfb/Makefile index
> 0490951f95b3..ad68ecf141af 100644
> --- a/drivers/video/fbdev/omap2/omapfb/Makefile
> +++ b/drivers/video/fbdev/omap2/omapfb/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_OMAP2_VRFB) += vrfb.o
>  obj-y += dss/
>  obj-y += displays/
>  obj-$(CONFIG_FB_OMAP2) += omapfb.o
> diff --git a/drivers/video/fbdev/omap2/vrfb.c
> b/drivers/video/fbdev/omap2/omapfb/vrfb.c similarity index 100%
> rename from drivers/video/fbdev/omap2/vrfb.c
> rename to drivers/video/fbdev/omap2/omapfb/vrfb.c

-- 
Regards,

Laurent Pinchart

