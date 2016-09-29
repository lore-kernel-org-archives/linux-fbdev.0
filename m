From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 29 Sep 2016 19:32:05 +0000
Subject: Re: [PATCH 1/2] backlight: arcxcnn: add support for ArticSand devices
Message-Id: <20160929193204.GB3405@remoulade>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1475166879-6255-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1475166879-6255-1-git-send-email-olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olimpiu Dejeu <olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org

On Thu, Sep 29, 2016 at 12:34:39PM -0400, Olimpiu Dejeu wrote:
> Resubmition of arcxcnn backliught driver adding definitions of the
>  internal registers of the chip. 

s/backliught/backlight/

[...]

> +#ifdef CONFIG_OF
> +static int arcxcnn_parse_dt(struct arcxcnn *lp)
> +{
> +	struct device *dev = lp->dev;
> +	struct device_node *node = dev->of_node;
> +	u32 prog_length, prog_val, num_entry, sources[6];
> +	int ret;
> +
> +	if (!node) {
> +		dev_err(dev, "no platform data.\n");
> +		return -EINVAL;
> +	}
> +	of_property_read_string(node, "label", &lp->pdata->name);
> +	of_property_read_u32(node, "default-brightness", &prog_val);
> +	lp->pdata->initial_brightness = prog_val;

You must check the return value of the of_ accessors. If there's no
default-brightness property in the DT, prog_val will be uninitialised here.

> +	of_property_read_u32(node, "pwm-period", &lp->pdata->period_ns);

This was not in the binding document.

> +	/* Fill program from platform data if defined
> +	*/
> +	lp->pdata->prog_entries = 0;
> +	prog_length = of_get_child_count(node);
> +	if (prog_length > 0) {
> +		struct device_node *child;
> +		u32 i = 0;
> +
> +		for_each_child_of_node(node, child) {
> +			if (i >= ARCXCNN_MAX_PROGENTRIES)
> +				break;
> +			of_property_read_u32(child, "reg", &prog_val);
> +			lp->pdata->prog_addr[i] = (u8)prog_val;
> +			of_property_read_u32(child, "val", &prog_val);
> +			lp->pdata->prog_data[i] = (u8)prog_val;
> +			i++;
> +		}
> +		lp->pdata->prog_entries = i;
> +	}

This was also not documented.

What is this? What is it used for? Why is it in the DT?

> +	/* playback program now that its all installed */
> +	for (i = 0; i < lp->pdata->prog_entries; i++) {
> +		arcxcnn_write_byte(lp, lp->pdata->prog_addr[i],
> +				lp->pdata->prog_data[i]);
> +		/*
> +		printk(KERN_ALERT "%02X, %02X\n",
> +			lp->pdata->prog_addr[i], lp->pdata->prog_data[i]);
> +		*/
> +	}

Why is it necessary to have an arbitrary register programming sequence? What
exactly varies between parts?

I don't think this is the right way to solve your problem.

Thanks,
Mark.
