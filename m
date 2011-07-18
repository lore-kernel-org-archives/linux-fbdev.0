From: Kukjin Kim <kgene.kim@samsung.com>
Date: Mon, 18 Jul 2011 01:22:15 +0000
Subject: RE: [PATCH V7 1/5] ARM: EXYNOS4: Change clock name for FIMD
Message-Id: <047201cc44e9$2444a910$6ccdfb30$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1309171740-27146-1-git-send-email-jg1.han@samsung.com>
In-Reply-To: <1309171740-27146-1-git-send-email-jg1.han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Jingoo Han' <jg1.han@samsung.com>, 'Paul Mundt' <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Jonghun Han' <jonghun.han@samsung.com>
Cc: 'Thomas Abraham' <thomas.ab@samsung.com>

Jingoo Han wrote:
> 
> This patch changes clock name for FIMD from "fimd" to "lcd".
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm/mach-exynos4/clock.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
> index 871f9d5..12e6853 100644
> --- a/arch/arm/mach-exynos4/clock.c
> +++ b/arch/arm/mach-exynos4/clock.c
> @@ -433,12 +433,12 @@ static struct clk init_clocks_off[] = {
>  		.enable		= exynos4_clk_ip_cam_ctrl,
>  		.ctrlbit	= (1 << 3),
>  	}, {
> -		.name		= "fimd",
> +		.name		= "lcd",
>  		.id		= 0,
>  		.enable		= exynos4_clk_ip_lcd0_ctrl,
>  		.ctrlbit	= (1 << 0),
>  	}, {
> -		.name		= "fimd",
> +		.name		= "lcd",
>  		.id		= 1,
>  		.enable		= exynos4_clk_ip_lcd1_ctrl,
>  		.ctrlbit	= (1 << 0),
> --
> 1.7.1

This should be re-worked based on latest my for-next which includes clkdev.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

