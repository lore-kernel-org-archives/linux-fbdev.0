From: Kukjin Kim <kgene.kim@samsung.com>
Date: Thu, 17 Mar 2011 08:23:09 +0000
Subject: RE: [PATCH 1/2] s5pc110: add clock gate for MIPI-DSI controller.
Message-Id: <00af01cbe47c$8fde0180$af9a0480$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294223690-31860-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1294223690-31860-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Inki Dae wrote:
> 
> the clock gate for MIPI-DSI controller is placed at CLK_GATE_IP1[2]
> so it adds a clock object to clock framework for MIPI-DSI clock gating.
> 
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/clock.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index dab6ef3..a8d5235 100644
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

According to coding-style, should be added blank around "<<" like (1 << 2),
even though there are wrong things to others.

> +	}, {	
>  		.name		= "cfcon",
>  		.id		= 0,
>  		.parent		= &clk_hclk_psys.clk,
> --
> 1.7.0.4

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

