From: Oliver Neukum <oneukum@suse.de>
Date: Fri, 27 Feb 2015 08:58:38 +0000
Subject: Re: [PATCH v11 2/6] backlight: Add support Skyworks SKY81452 backlight driver
Message-Id: <1425027518.12236.5.camel@linux-0dmf.site>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425019346-4559-1-git-send-email-jack.yoo@skyworksinc.com>
	 <1425019346-4559-3-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1425019346-4559-3-git-send-email-jack.yoo@skyworksinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gyungoh@gmail.com
Cc: sameo@linux.intel.com, lee.jones@linaro.org, robh+dt@kernel.org, jg1.han@samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, trivial@kernel.org, broonie@kernel.org, florian.vaussard@epfl.ch, andrew@lunn.ch, antonynpavlov@gmail.com, hytszk@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jack.yoo@skyworksinc.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, treding@nvidia.com, p.zabel@pengutronix.de, arno@natisbad.org, kuninori.morimoto.gx@renesas.com

On Fri, 2015-02-27 at 15:42 +0900, gyungoh@gmail.com wrote:
> +static ssize_t sky81452_bl_store_enable(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t
> count)
> +{
> +       struct regmap *regmap = bl_get_data(to_backlight_device(dev));
> +       unsigned long value;
> +       int ret;
> +
> +       ret = kstrtoul(buf, 16, &value);
> +       if (IS_ERR_VALUE(ret))
> +               return ret;

No range checking?

> +
> +       ret = regmap_update_bits(regmap, SKY81452_REG1, SKY81452_EN,
> +                                       value << CTZ(SKY81452_EN));
> +       if (IS_ERR_VALUE(ret))
> +               return ret;
> +
> +       return count;
> +}

	Regards
		Oliver



