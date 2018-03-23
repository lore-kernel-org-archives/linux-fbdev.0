From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 23 Mar 2018 16:53:13 +0000
Subject: Re: [PATCH V2 1/4] clk: bulk: add of_clk_bulk_get()
Message-Id: <152182399342.178046.13139513462419815903@swboyd.mtv.corp.google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
 <1521602391-30356-2-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1521602391-30356-2-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Quoting Dong Aisheng (2018-03-20 20:19:48)
> diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
> index 4c10456..4b357b2 100644
> --- a/drivers/clk/clk-bulk.c
> +++ b/drivers/clk/clk-bulk.c
> @@ -19,6 +19,38 @@
>  #include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/of.h>
> +
> +#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)

Do we need these defines? of_clk_get() is a stub function when these
configs are false.

> +static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
> +                                       struct clk_bulk_data *clks)
> +{
> +       int ret;
> +       int i;
> +
> +       for (i = 0; i < num_clks; i++)
> +               clks[i].clk = NULL;
> +
> +       for (i = 0; i < num_clks; i++) {
> +               clks[i].clk = of_clk_get(np, i);
> +               if (IS_ERR(clks[i].clk)) {
> +                       ret = PTR_ERR(clks[i].clk);
> +                       pr_err("%pOF: Failed to get clk index: %d ret: %d\n",
> +                              np, i, ret);
> +                       clks[i].clk = NULL;
> +                       goto err;
> +               }
> +       }
> +
> +       return 0;
> +
> +err:
> +       clk_bulk_put(i, clks);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(of_clk_bulk_get);

It's static, so don't export it.
