From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Dec 2010 15:49:45 +0000
Subject: Re: [PATCH 6/9] ARM i.MX51: Add IPU device support
Message-Id: <201012151649.45199.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-7-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1291902441-24712-7-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 09 December 2010, Sascha Hauer wrote:
> +#define imx51_add_ipuv3(pdata) \
> +       imx_add_ipuv3(&imx51_ipuv3_data, pdata)

This looks  like a pointless abstraction, it does not make
the code smaller or easier to read. I know it's sometimes
tempting to use macros, but in most cases, you should try
not to.

> +#define imx51_ipuv3_data_entry_single(soc)				\
> +	{								\
> +		.iobase = soc ## _IPU_CTRL_BASE_ADDR,			\
> +		.irq_err = soc ## _INT_IPU_ERR,				\
> +		.irq = soc ## _INT_IPU_SYN,				\
> +	}
> +
> +#ifdef CONFIG_SOC_IMX51
> +const struct imx_ipuv3_data imx51_ipuv3_data __initconst > +	imx51_ipuv3_data_entry_single(MX51);
> +#endif /* ifdef CONFIG_SOC_IMX35 */

This looks really strange: You define a macro that is used
in only a single place, and the only user is a data structure
that references data from other files and is used elsewhere
as well.

Avoiding the macro would make it easier to grep for the use
of the identifiers.

If you put the data structure in the place where it is used,
you can avoid the #ifdef and make it static.

Also, the comment on the #endif does not match the #if.

	Arnd
