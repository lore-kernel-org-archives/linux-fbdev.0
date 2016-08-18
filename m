From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 18 Aug 2016 11:07:48 +0000
Subject: Re: [PATCH 1/1] BACKLIGHT: Add Driver for ARCXCNN Chip
Message-Id: <20160818110748.GE27045@leverpostej>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471460799-16015-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1471460799-16015-1-git-send-email-olimpiu@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olimpiu Dejeu <olimpiu@arcticsand.com>
Cc: jg1.han@samsung.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Aug 17, 2016 at 03:06:39PM -0400, Olimpiu Dejeu wrote:
> This is the driver for the Arctic Sand Technologies Inc. ARCXCNN LED
> backlight IC family.
> 
> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
> ---
>  drivers/video/backlight/Kconfig      |   7 +
>  drivers/video/backlight/Makefile     |   1 +
>  drivers/video/backlight/arcxcnn_bl.c | 499 +++++++++++++++++++++++++++++++++++
>  include/linux/i2c/arcxcnn.h          |  41 +++
>  4 files changed, 547 insertions(+)
>  create mode 100644 drivers/video/backlight/arcxcnn_bl.c
>  create mode 100644 include/linux/i2c/arcxcnn.h

This is a one-patch series with no binding, yet the code below adds a new
compatible string ("arc,arcxcnn"), and DT parsing code assuming
uncommon, non-trivial properties.

You must write a device tree binding document for this.

Please see Documentation/devicetree/bindings/submitting-patches.txt.

> +static int arcxcnn_parse_dt(struct arcxcnn *lp)
> +{
> +	struct device *dev = lp->dev;
> +	struct device_node *node = dev->of_node;
> +	u32 prog_length;
> +
> +	if (!node) {
> +		dev_err(dev, "no platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	of_property_read_string(node, "bl-name", &lp->pdata->name);
> +	of_property_read_u16(node, "init-brt", &lp->pdata->initial_brightness);
> +	of_property_read_u32(node, "pwm-period", &lp->pdata->period_ns);
> +
> +	if (lp->pdata->initial_brightness > MAX_BRIGHTNESS)
> +		lp->pdata->initial_brightness = MAX_BRIGHTNESS;
> +
> +	/* Fill program from platform data if defined
> +	*/
> +	lp->pdata->prog_entries = 0;
> +	prog_length = of_get_child_count(node);
> +	if (prog_length > 0) {
> +		struct device_node *child;
> +		u32 i = 0;
> +
> +		for_each_child_of_node(node, child) {
> +		    	if (i >= ARCXCNN_MAX_PROGENTRIES)
> +				break;
> +			of_property_read_u8(child, "prg-addr", &lp->pdata->prog_addr[i]);
> +			of_property_read_u8(child, "prg-data", &lp->pdata->prog_data[i]);

Don't bother using u8. The DTB is padded to u32 boundaries anyway, so this
just adds an additional burden on DT authors to use /bits/ 8
consistently, which inevitably someone will get wrong.

> +static int arcxcnn_probe(struct i2c_client *cl, const struct i2c_device_id *id)
> +{
> +	struct arcxcnn *lp;
> +	int ret;
> +	u32 i;
> +	u8 regval;
> +	u16 chipid;
> +
> +	if (!i2c_check_functionality(cl->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EIO;
> +
> +	lp = devm_kzalloc(&cl->dev, sizeof(struct arcxcnn), GFP_KERNEL);

Nit: sizeof(*lp) is the preferred style.

> +static const struct of_device_id arcxcnn_dt_ids[] = {
> +	{ .compatible = "arc,arcxcnn", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, arcxcnn_dt_ids);

Thanks,
Mark.
