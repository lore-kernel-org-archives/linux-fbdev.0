From: "A.s. Dong" <aisheng.dong@nxp.com>
Date: Fri, 25 May 2018 09:51:16 +0000
Subject: RE: [PATCH V2 3/4] clk: add managed version of clk_bulk_get_all
Message-Id: <AM0PR04MB4211BF66D1C5E025C264687080690@AM0PR04MB4211.eurprd04.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1521602391-30356-4-git-send-email-aisheng.dong@nxp.com>
 <201803231452.YBWTInPr%fengguang.wu@intel.com>
In-Reply-To: <201803231452.YBWTInPr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: kbuild test robot [mailto:lkp@intel.com]
> Sent: Friday, March 23, 2018 2:49 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: kbuild-all@01.org; linux-clk@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; hdegoede@redhat.com;
> b.zolnierkie@samsung.com; linux@armlinux.org.uk; linux-
> fbdev@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> sboyd@kernel.org; A.s. Dong <aisheng.dong@nxp.com>; Stephen Boyd
> <sboyd@codeaurora.org>
> Subject: Re: [PATCH V2 3/4] clk: add managed version of clk_bulk_get_all
> 

[...]

> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/cpufreq.h:14:0,
>                     from arch/powerpc/platforms/cell/cpufreq_spudemand.c:23:
>    include/linux/clk.h:679:1: error: expected identifier or '(' before '{' token
>     {
>     ^
> >> include/linux/clk.h:677:32: error: 'devm_clk_bulk_get_all' declared
> >> 'static' but never defined [-Werror=unused-function]
>     static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
>                                    ^~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> vim +677 include/linux/clk.h
> 
>    676
>  > 677	static inline int __must_check devm_clk_bulk_get_all(struct device
> *dev,
>    678							     struct
> clk_bulk_data **clks);

Thanks for the reporting.
Caused by the extra unneeded ';' at the end of the line.
Will fix.

Regards
Dong Aisheng

>  > 679	{
>    680
>    681		return 0;
>    682	}
>    683
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.01.org%2Fpipermail%2Fkbuild-
> all&data=02%7C01%7Caisheng.dong%40nxp.com%7Ce9e35f96c61a4c46d1790
> 8d5908a4d46%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6365738
> 46071200287&sdata=yIWEjcpE2tyJP%2BmsMPqn%2F83TCsxw64J%2Ba5ue73
> qGnN0%3D&reserved=0                   Intel Corporation
