From: Kukjin Kim <kgene.kim@samsung.com>
Date: Wed, 29 Dec 2010 00:50:38 +0000
Subject: RE: [PATCH 1/5] S5PC110: add MIPI-DSI system register definitions.
Message-Id: <003201cba6f2$6b532a60$41f97f20$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1293535562-24715-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1293535562-24715-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Inki Dae wrote:
> 
Please keep myself in Cc on this. I already noticed that to you before.
I think you should check whether mail loop is suitable or not...

And would be better if you could add #0 patch to understand your patches.

> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> ---
>  arch/arm/mach-s5pv210/include/mach/regs-clock.h |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
b/arch/arm/mach-
> s5pv210/include/mach/regs-clock.h
> index ebaabe0..09680d9 100644
> --- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> +++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> @@ -146,6 +146,7 @@
>  #define S5P_OM_STAT		S5P_CLKREG(0xE100)
>  #define S5P_USB_PHY_CONTROL	S5P_CLKREG(0xE80C)
>  #define S5P_DAC_CONTROL		S5P_CLKREG(0xE810)
> +#define S5P_MIPI_DPHY_CONTROL		S5P_CLKREG(0xE814)
> 
>  #define S5P_INFORM0		S5P_CLKREG(0xF000)
>  #define S5P_INFORM1		S5P_CLKREG(0xF004)
> @@ -196,7 +197,10 @@
>  #define S5P_OTHERS_USB_SIG_MASK		(1 << 16)
> 
>  /* MIPI */
> -#define S5P_MIPI_DPHY_EN		(3)
> +#define S5P_MIPI_DPHY_EN		(3 << 0)
> +
> +/* S5P_MIPI_PHY_CON0 */
> +#define S5P_MIPI_M_RESETN		(1 << 1)
> 
>  /* S5P_DAC_CONTROL */
>  #define S5P_DAC_ENABLE			(1)
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

