From: Kukjin Kim <kgene.kim@samsung.com>
Date: Fri, 31 Dec 2010 06:19:02 +0000
Subject: RE: [PATCH 2/5] S5PC110: add MIPI-DSI clock.
Message-Id: <013801cba8b2$a1d24c30$e576e490$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1293535577-24751-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1293535577-24751-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Inki Dae wrote:
> 
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> ---
>  arch/arm/mach-s5pv210/clock.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index 019c3a6..58a7c60 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c
> @@ -365,6 +365,12 @@ static struct clk init_clocks_disable[] = {
>  		.enable		= s5pv210_clk_ip1_ctrl,
>  		.ctrlbit	= (1<<0),
>  	}, {
> +		.name		= "dsim",
> +		.id		= -1,
> +		.parent		= &clk_hclk_dsys.clk,
> +		.enable		= s5pv210_clk_ip1_ctrl,
> +		.ctrlbit	= (1<<2),

Please add blank around <<

> +	}, {
>  		.name		= "cfcon",
>  		.id		= 0,
>  		.parent		= &clk_hclk_psys.clk,
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

