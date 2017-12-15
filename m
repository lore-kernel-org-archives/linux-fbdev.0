From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 15 Dec 2017 14:32:00 +0000
Subject: Re: [PATCH v2 3/3] backlight: tdo24m: add model and status sysfs entries
Message-Id: <20171215143200.sm22mkifqlskjddf@oak.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171013194250.9001-1-robert.jarzmik@free.fr>
 <20171013194250.9001-3-robert.jarzmik@free.fr>
In-Reply-To: <20171013194250.9001-3-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 13, 2017 at 09:42:49PM +0200, Robert Jarzmik wrote:
> Add entries to query the panel ASIC to acquire the model number and the
> status field. This comes in handy to check that the SPI connection is
> functional and that the panel's firmware is alive.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

This feels to me somewhat like debug information being pushed into sysfs.
There are very few backlight drivers that add additional sysfs attributes
meaning the extra info here is not commonly pushed into the ABI for a
backlight and knowing the info in these properties does not really 
help userspace to *use* the hardware.

Does this kind of thing really belong in sysfs?


Daniel.

> ---
>  drivers/video/backlight/tdo24m.c | 73 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo24m.c
> index e4b2dfabf192..113c28c2145a 100644
> --- a/drivers/video/backlight/tdo24m.c
> +++ b/drivers/video/backlight/tdo24m.c
> @@ -22,7 +22,7 @@
>  
>  #define POWER_IS_ON(pwr)	((pwr) <= FB_BLANK_NORMAL)
>  
> -#define TDO24M_SPI_BUFF_SIZE	(4)
> +#define TDO24M_SPI_BUFF_SIZE	(6)
>  #define MODE_QVGA	0
>  #define MODE_VGA	1
>  
> @@ -33,6 +33,7 @@ struct tdo24m {
>  	struct spi_message	msg;
>  	struct spi_transfer	xfer;
>  	uint8_t			*buf;
> +	uint8_t			*rx_buf;
>  	struct gpio_desc	*xres;
>  
>  	int (*adj_mode)(struct tdo24m *lcd, int mode);
> @@ -219,6 +220,30 @@ static int tdo24m_writes(struct tdo24m *lcd, const uint32_t *array)
>  	return err;
>  }
>  
> +static int tdo24m_read_command(struct tdo24m *lcd, unsigned char cmd,
> +			       unsigned int *id)
> +{
> +	struct spi_transfer *x = &lcd->xfer;
> +	int err = 0, i;
> +
> +	lcd->buf[0] = cmd >> 1;
> +	lcd->buf[1] = (cmd & 0x01) << 7;
> +	lcd->buf[2] = 0;
> +	lcd->buf[3] = 0;
> +	lcd->buf[4] = 0;
> +
> +	x->len = 6;
> +	err = spi_sync(lcd->spi_dev, &lcd->msg);
> +
> +	for (i = 0; i < sizeof(lcd->rx_buf) - 2; i++)
> +		lcd->rx_buf[i] = (lcd->rx_buf[i + 1] << 2) |
> +			(lcd->rx_buf[i + 2] >> 6);
> +	*id = (lcd->rx_buf[0] << 24) | (lcd->rx_buf[1] << 16) |
> +		(lcd->rx_buf[2] << 8) | lcd->rx_buf[3];
> +
> +	return err;
> +}
> +
>  static int tdo24m_adj_mode(struct tdo24m *lcd, int mode)
>  {
>  	switch (mode) {
> @@ -327,6 +352,43 @@ static int tdo24m_set_mode(struct lcd_device *ld, struct fb_videomode *m)
>  	return lcd->adj_mode(lcd, mode);
>  }
>  
> +static ssize_t tdo24m_model_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct tdo24m *lcd = dev_get_drvdata(dev);
> +	uint32_t data;
> +	int err;
> +
> +	err = tdo24m_read_command(lcd, 0x04, &data);
> +	if (!err)
> +		return snprintf(buf, PAGE_SIZE, "0x%06x\n", data >> 8);
> +
> +	return err;
> +}
> +static DEVICE_ATTR_RO(tdo24m_model);
> +
> +static ssize_t tdo24m_status_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct tdo24m *lcd = dev_get_drvdata(dev);
> +	uint32_t data;
> +	int err;
> +
> +	err = tdo24m_read_command(lcd, 0x09, &data);
> +	if (!err)
> +		return snprintf(buf, PAGE_SIZE, "0x%08x\n", data);
> +
> +	return err;
> +}
> +static DEVICE_ATTR_RO(tdo24m_status);
> +
> +static struct attribute *tdo24m_attrs[] = {
> +	&dev_attr_tdo24m_model.attr,
> +	&dev_attr_tdo24m_status.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(tdo24m);
> +
>  static struct lcd_ops tdo24m_ops = {
>  	.get_power	= tdo24m_get_power,
>  	.set_power	= tdo24m_set_power,
> @@ -365,6 +427,9 @@ static int tdo24m_probe(struct spi_device *spi)
>  	lcd->buf = devm_kzalloc(&spi->dev, TDO24M_SPI_BUFF_SIZE, GFP_KERNEL);
>  	if (lcd->buf = NULL)
>  		return -ENOMEM;
> +	lcd->rx_buf = devm_kzalloc(&spi->dev, TDO24M_SPI_BUFF_SIZE, GFP_KERNEL);
> +	if (lcd->rx_buf = NULL)
> +		return -ENOMEM;
>  
>  	lcd->xres = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
>  	m = &lcd->msg;
> @@ -374,6 +439,7 @@ static int tdo24m_probe(struct spi_device *spi)
>  
>  	x->cs_change = 0;
>  	x->tx_buf = &lcd->buf[0];
> +	x->rx_buf = &lcd->rx_buf[0];
>  	spi_message_add_tail(x, m);
>  
>  	switch (model) {
> @@ -396,6 +462,11 @@ static int tdo24m_probe(struct spi_device *spi)
>  		return PTR_ERR(lcd->lcd_dev);
>  
>  	spi_set_drvdata(spi, lcd);
> +
> +	err = devm_device_add_groups(&spi->dev, tdo24m_groups);
> +	if (err)
> +		return err;
> +
>  	err = tdo24m_power(lcd, FB_BLANK_UNBLANK);
>  	if (err)
>  		return err;
> -- 
> 2.11.0
> 
