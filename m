From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Wed, 22 Jun 2011 08:56:41 +0000
Subject: Re: [PATCH V5 5/5] ARM: EXYNOS4: Add platform data for EXYNOS4 FIMD
Message-Id: <4E01AE49.60009@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308724904-31521-1-git-send-email-jg1.han@samsung.com>
In-Reply-To: <1308724904-31521-1-git-send-email-jg1.han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, Jonghun Han <jonghun.han@samsung.com>, Anand Kumar N <anand.kn@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kmpark@infradead.org>, Inki Dae <inki.dae@samsung.com>, ARM Linux <linux@arm.linux.org.uk>, Ben Dooks <ben-linux@fluff.org>

Hello,

On 06/22/2011 08:41 AM, Jingoo Han wrote:
> From: Jonghun Han <jonghun.han@samsung.com>
> 
> This patch adds support EXYNOS4 FIMD0 and LTE480WV LCD pannel.
> 
> Signed-off-by: Jonghun Han <jonghun.han@samsung.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm/mach-exynos4/mach-smdkc210.c |  114 +++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos4/mach-smdkv310.c |  114 +++++++++++++++++++++++++++++++++
>  2 files changed, 228 insertions(+), 0 deletions(-)
...
> +static int __init smdkc210_fimd0_setup_clock(void)
> +{
> +	struct clk *sclk = NULL;
> +	struct clk *mout_mpll = NULL;

You don't need initialize to NULL here.

> +
> +	u32 rate = 0;

Other than this variable is not really needed I would make it unsigned long.

> +
> +	sclk = clk_get(&s5p_device_fimd0.dev, "sclk_fimd");
> +	if (IS_ERR(sclk)) {
> +		printk(KERN_ERR "failed to get sclk for fimd\n");
> +		goto err_clk2;

You could just do:
		return PTR_ERR(sclk);

> +	}
> +
> +	mout_mpll = clk_get(NULL, "mout_mpll");
> +	if (IS_ERR(mout_mpll)) {
> +		printk(KERN_ERR "failed to get mout_mpll\n");
> +		goto err_clk1;
> +	}
> +
> +	clk_set_parent(sclk, mout_mpll);
> +	if (!rate)
> +		rate = 134000000;

 134000000UL

> +
> +	clk_set_rate(sclk, rate);
> +
> +	clk_put(sclk);
> +	clk_put(mout_mpll);
> +
> +	return 0;
> +
> +err_clk1:
> +	clk_put(mout_mpll);

clk_put is supposed to be used only for clocks that were successfully acquired.

> +err_clk2:
> +	clk_put(sclk);

Ditto.

> +
> +	return -EINVAL;
> +}

...

> +static int __init smdkv310_fimd0_setup_clock(void)
> +{
> +	struct clk *sclk = NULL;
> +	struct clk *mout_mpll = NULL;
> +
> +	u32 rate = 0;
> +
> +	sclk = clk_get(&s5p_device_fimd0.dev, "sclk_fimd");
> +	if (IS_ERR(sclk)) {
> +		printk(KERN_ERR "failed to get sclk for fimd\n");
> +		goto err_clk2;
> +	}
> +
> +	mout_mpll = clk_get(NULL, "mout_mpll");
> +	if (IS_ERR(mout_mpll)) {
> +		printk(KERN_ERR "failed to get mout_mpll\n");
> +		goto err_clk1;
> +	}
> +
> +	clk_set_parent(sclk, mout_mpll);
> +	if (!rate)
> +		rate = 134000000;
> +
> +	clk_set_rate(sclk, rate);
> +
> +	clk_put(sclk);
> +	clk_put(mout_mpll);
> +
> +	return 0;
> +
> +err_clk1:
> +	clk_put(mout_mpll);
> +err_clk2:
> +	clk_put(sclk);
> +
> +	return -EINVAL;
> +}

We have multiple copies of same function and I suspect other boards will try
to repeat this pattern which is not that good.

It would be worth to create common function for all boards if we really
must have that, e.g.

int __init exynos4_fimd_setup_clock(struct device *dev, const char *parent,
                                    unsigned long clk_rate);
{
	struct clk *clk_parent;
	struct clk *sclk;

	sclk = clk_get(dev, "sclk_fimd");
	if (IS_ERR(sclk))
		return PTR_ERR(sclk);

	clk_parent = clk_get(NULL, parent);
	if (IS_ERR(parent_clk)) {
		clk_put(sclk);
		return PTR_ERR(clk_parent);
	}

	clk_set_parent(sclk, clk_parent);
	if (!rate)
		rate = 134000000UL;
	clk_set_rate(sclk, rate);
	clk_put(sclk);
	clk_put(clk_parent);

	return 0;
}

But I have no idea where to put that...
Perhaps we should create common mach-exynos4/setup-fimd.c file for FIMD0, FIMD1.
But then it would contain ugly #ifdef for unused FIMD1 setup functions
("#ifdef CONFIG_DEV_FIMD0 ..") if only FIMD0 is used. Maybe someone else has
better idea.


Regards,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
