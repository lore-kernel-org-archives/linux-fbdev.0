From: Kukjin Kim <kgene.kim@samsung.com>
Date: Thu, 21 Jul 2011 07:16:49 +0000
Subject: RE: [PATCH V8 1/5] ARM: EXYNOS4: Change clock name for FIMD
Message-Id: <006501cc4776$2ee2a4a0$8ca7ede0$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1311202444-18137-1-git-send-email-jg1.han@samsung.com>
In-Reply-To: <1311202444-18137-1-git-send-email-jg1.han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Jingoo Han' <jg1.han@samsung.com>, 'Paul Mundt' <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: 'Jonghun Han' <jonghun.han@samsung.com>, 'Ben Dooks' <ben-linux@fluff.org>

Jingoo Han wrote:
> 
> This patch changes clock for FIMD from 'fimd' to 'lcd'.
> Also, devname for FIMD is changed from 's5pv310-fb' to 'exynos4-fb'.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm/mach-exynos4/clock.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
> index 98b5cc4..778a202 100644
> --- a/arch/arm/mach-exynos4/clock.c
> +++ b/arch/arm/mach-exynos4/clock.c
> @@ -405,13 +405,13 @@ static struct clk init_clocks_off[] = {
>  		.enable		= exynos4_clk_ip_cam_ctrl,
>  		.ctrlbit	= (1 << 3),
>  	}, {
> -		.name		= "fimd",
> -		.devname	= "s5pv310-fb.0",
> +		.name		= "lcd",
> +		.devname	= "exynos4-fb.0",
>  		.enable		= exynos4_clk_ip_lcd0_ctrl,
>  		.ctrlbit	= (1 << 0),
>  	}, {
> -		.name		= "fimd",
> -		.devname	= "s5pv310-fb.1",
> +		.name		= "lcd",

As I remember, some guys discussed about the clock name before.

Please refer to the following diagram. Before EXYNOS4210 clk 'lcd' was used
for FIMD IP core clock and source of the LCD pixel clock. But the mux used
to select source of LCD pixel clock is removed. So 'lcd' clock is only used
for core clock of FIMD IP. It isn't used for LCD pixel clock.

As a result clock name was changed from lcd to fimd in the EXYNOS4210
datasheet.

Before EXYNOS4
           ------------------------------------
                      dsys bus
           ----------------+-------------------
                           |
                           |1.clk 'lcd'
                           |
                           | FIMD block
                       +---+-----------+
4.mout_mpll |\         |   |           |
    --------|m|        | +-+-+ +----+  |
            |u|-+      | |   +-+core|  |
            |x| |      | |     +----+  |
            |/  |      | | |\          |
                |      | +-|m|  +---+  |
                |      |   |u|--+div|  |
                +------+---|x|  +---+  |
           2.SCLK_FIMD |   |/     |    |
                       |          |    |
                       +----------+----+
                                  |
           inside of SoC          |
           -----------------------+--------------------------
           outside of SoC         |
                                  | 3.LCD pixel clock
                                  |
                          +--------------+
                          | LCD module   |
                          +--------------+


EXYNOS4210
           ------------------------------------
                      dsys bus
           ----------------+-------------------
                           |
                           |1.clk 'fimd'
                           |
                           | FIMD block
                       +---+-----------+
4.mout_mpll |\         |   |           |
    --------|m|        |   |   +----+  |
            |u|-+      |   +---+core|  |
            |x| |      |       +----+  |
            |/  |      |               |
                |      |        +---+  |
                |      |     +--+div|  |
                +------+-----+  +---+  |
           2.SCLK_FIMD |          |    |
                       |          |    |
                       +----------+----+
                                  |
           inside of SoC          |
           -----------------------+--------------------------
           outside of SoC         |
                                  | 3.LCD pixel clock
                                  |
                          +--------------+
                          | LCD module   |
                          +--------------+

To change devname is ok to me. So will apply only it.

If any problems, please let me know :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> +		.devname	= "exynos4-fb.1",
>  		.enable		= exynos4_clk_ip_lcd1_ctrl,
>  		.ctrlbit	= (1 << 0),
>  	}, {
> @@ -909,7 +909,7 @@ static struct clksrc_clk clksrcs[] = {
>  	}, {
>  		.clk		= {
>  			.name		= "sclk_fimd",
> -			.devname	= "s5pv310-fb.0",
> +			.devname	= "exynos4-fb.0",
>  			.enable		= exynos4_clksrc_mask_lcd0_ctrl,
>  			.ctrlbit	= (1 << 0),
>  		},
> @@ -919,7 +919,7 @@ static struct clksrc_clk clksrcs[] = {
>  	}, {
>  		.clk		= {
>  			.name		= "sclk_fimd",
> -			.devname	= "s5pv310-fb.1",
> +			.devname	= "exynos4-fb.1",
>  			.enable		= exynos4_clksrc_mask_lcd1_ctrl,
>  			.ctrlbit	= (1 << 0),
>  		},
> --
> 1.7.1

