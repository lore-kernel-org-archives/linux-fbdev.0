From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Thu, 23 Dec 2010 18:42:22 +0000
Subject: Re: [PATCH] video: imxfb: Fix the maximum value for yres
Message-Id: <4D13980E.4010500@ru.mvista.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1293124671-29426-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1293124671-29426-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

Fabio Estevam wrote:

> MX27 and MX25 have 10 bits in the YMAX field of LCDC Size Register.

> Fix the maximum value for yres.

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
[...]

> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 5c363d0..5d2d337 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -55,8 +55,10 @@
>  
>  #ifdef CONFIG_ARCH_MX1
>  #define SIZE_YMAX(y)	((y) & 0x1ff)
> +#define YMAX_MASK	0x1ff
>  #else
>  #define SIZE_YMAX(y)	((y) & 0x3ff)
> +#define YMAX_MASK	0x3ff
>  #endif

    I'd done the following, to avoid the code duplication:

#ifdef CONFIG_ARCH_MX1
#define YMAX_MASK	0x1ff
#else
#define YMAX_MASK	0x3ff
#endif
#define SIZE_YMAX(y)	((y) & YMAX_MASK)

WBR, Sergei
