From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 17 Mar 2014 06:20:26 +0000
Subject: Re: [PATCH v7][ 3/5] video: mx3fb: Introduce regulator support.
Message-Id: <20140317062026.GZ17250@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394788369-5096-1-git-send-email-denis@eukrea.com>
 <1394788369-5096-3-git-send-email-denis@eukrea.com>
In-Reply-To: <1394788369-5096-3-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

[Added Mark to Cc]

On Fri, Mar 14, 2014 at 10:12:47AM +0100, Denis Carikli wrote:
>  
> +		of_property_read_string(display_np, "regulator-name",
> +					&regulator_name);
> +

[...]

> +	/* In dt mode,
> +	 * using devm_regulator_get would require that the proprety referencing
> +	 * the regulator phandle has to be inside the mx3fb node.
> +	 */
> +	if (np) {
> +		if (regulator_name)
> +			mx3fbi->reg_lcd = regulator_get(NULL, regulator_name);
> +
> +		if (IS_ERR(mx3fbi->reg_lcd))
> +			return PTR_ERR(mx3fbi->reg_lcd);
> +	} else {
> +		/* Permit that driver without a regulator in non-dt mode */
> +		mx3fbi->reg_lcd = regulator_get(dev, "lcd");
> +	}

This patch adds regulator support for the display of a i.MX3 IPU. The
problem Denis has to solve here is that he needs to get the regulator,
but the display devicenode doesn't have a struct device associated with
it, so he cannot provide one to regulator_get(). One way out here could
be a of_regulator_get(struct device_node *). Mark, would this be ok with
you?

(Of course a proper driver for the display would be nicer, but this
would immediately bring us to some Common display framework, something
which is being worked on quite a while now without success)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
