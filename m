From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Dec 2010 00:39:13 +0000
Subject: Re: [PATCH v2] video: imxfb: Fix the maximum value for yres
Message-Id: <20101224003913.GE28151@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1293131490-2747-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1293131490-2747-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 23, 2010 at 05:11:30PM -0200, Fabio Estevam wrote:
> MX27 and MX25 have 10 bits in the YMAX field of LCDC Size Register.
> 
> Fix the maximum value for yres.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - factor out SIZE_YMAX definition
>  drivers/video/imxfb.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 5c363d0..4cddd3b 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -54,10 +54,11 @@
>  #define SIZE_XMAX(x)	((((x) >> 4) & 0x3f) << 20)
>  
>  #ifdef CONFIG_ARCH_MX1
> -#define SIZE_YMAX(y)	((y) & 0x1ff)
> +#define YMAX_MASK	0x1ff
>  #else
> -#define SIZE_YMAX(y)	((y) & 0x3ff)
> +#define YMAX_MASK	0x3ff
>  #endif
> +#define SIZE_YMAX(y)	((y) & YMAX_MASK)
>  
>  #define LCDC_VPW	0x08
>  #define VPW_VPW(x)	((x) & 0x3ff)

Do you really want to restrict this by the build-time check? Presumably
you could just do this as:

#define YMAX_MASK	(cpu_is_mx1() ? 0x1ff : 0x3ff)

to support multiple configurations.
