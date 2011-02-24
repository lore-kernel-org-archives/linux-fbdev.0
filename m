From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 24 Feb 2011 23:42:50 +0000
Subject: Re: [PATCH] drivers: ld9040 amoled driver support
Message-Id: <20110224154250.266b2688.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294893628-16998-1-git-send-email-dh09.lee@samsung.com>
In-Reply-To: <1294893628-16998-1-git-send-email-dh09.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 13 Jan 2011 13:40:28 +0900
Donghwa Lee <dh09.lee@samsung.com> wrote:

> This patch is ld9040 amoled panel driver.
> I resend because there was no comment.
> 
> It is similar to s6e63m0 panel driver and use spi gpio to send panel
> information.
> 
>
> ...
>
> +#define POWER_IS_ON(pwr)	((pwr) <= FB_BLANK_NORMAL)

This could and should be implemented as a regular lower-case C function.

> +struct ld9040 {
> +	struct device			*dev;
> +	struct spi_device		*spi;
> +	unsigned int			power;
> +	unsigned int			gamma_mode;
> +	unsigned int			current_brightness;
> +	unsigned int			gamma_table_count;
> +
> +	struct lcd_device		*ld;
> +	struct backlight_device		*bd;
> +	struct lcd_platform_data	*lcd_pd;
> +};
> +
> +static const unsigned short SEQ_SWRESET[] = {
> +	0x01, COMMAND_ONLY,
> +	ENDDEF, 0x00
> +};

It's strange that all these tables have upper-case names.  Unless
there's some special reason for doing it this way, please make them
regular lower-case identifiers.

>
> ...
>
> +static int ld9040_ldi_init(struct ld9040 *lcd)
> +{
> +	int ret, i;
> +	const unsigned short *init_seq[] = {
> +		SEQ_USER_SETTING,
> +		SEQ_PANEL_CONDITION,
> +		SEQ_DISPCTL,
> +		SEQ_MANPWR,
> +		SEQ_PWR_CTRL,
> +		SEQ_ELVSS_ON,
> +		SEQ_GTCON,
> +		SEQ_GAMMA_SET1,
> +		SEQ_GAMMA_CTRL,
> +		SEQ_SLPOUT,
> +	};

Make this table static so the compiler doesn't rebuild it on the stack
each time the function is called.  The compiler probably already
performs that optimisation, but it doesn't hurt to be explicit.


> +	for (i = 0; i < ARRAY_SIZE(init_seq); i++) {
> +		ret = ld9040_panel_send_sequence(lcd, init_seq[i]);
> +		/* workaround: minimum delay time for transferring CMD */
> +		udelay(300);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
>
> ...
>
> +static ssize_t ld9040_sysfs_show_gamma_mode(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct ld9040 *lcd = dev_get_drvdata(dev);
> +	char temp[10];
> +
> +	switch (lcd->gamma_mode) {
> +	case 0:
> +		sprintf(temp, "2.2 mode\n");
> +		strcat(buf, temp);

Could do sprintf(buf + strlen(buf)) and eliminate temp[].

> +		break;
> +	default:
> +		dev_info(dev, "gamma mode could be 0:2.2\n");
> +		break;
> +	}
> +
> +	return strlen(buf);
> +}
> +
> +static ssize_t ld9040_sysfs_store_gamma_mode(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct ld9040 *lcd = dev_get_drvdata(dev);
> +	struct backlight_device *bd = NULL;
> +	int brightness, rc;
> +
> +	rc = strict_strtoul(buf, 0, (unsigned long *)&lcd->gamma_mode);

That's a bug.  gamma_mode has type int, which is 4 bytes, but you're
telling strict_strtoul() to write eight bytes - it will corrupt *lcd on
a 64-bit machine.  Use a temporary.


> +	if (rc < 0)
> +		return rc;
> +
> +	bd = lcd->bd;
> +
> +	brightness = bd->props.brightness;
> +
> +	switch (lcd->gamma_mode) {
> +	case 0:
> +		_ld9040_gamma_ctl(lcd, gamma_table.gamma_22_table[brightness]);
> +		break;
> +	default:
> +		dev_info(dev, "gamma mode could be 0:2.2\n");
> +		_ld9040_gamma_ctl(lcd, gamma_table.gamma_22_table[brightness]);
> +		break;
> +	}
> +	return len;
> +}
> +
> +static DEVICE_ATTR(gamma_mode, 0644,
> +		ld9040_sysfs_show_gamma_mode, ld9040_sysfs_store_gamma_mode);
> +
> +static ssize_t ld9040_sysfs_show_gamma_table(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct ld9040 *lcd = dev_get_drvdata(dev);
> +	char temp[3];
> +
> +	sprintf(temp, "%d\n", lcd->gamma_table_count);
> +	strcpy(buf, temp);

sprintf(buf + strlen(buf), remove temp[].

> +	return strlen(buf);
> +}
> +
> +static DEVICE_ATTR(gamma_table, 0644,
> +		ld9040_sysfs_show_gamma_table, NULL);
> +
> +static int ld9040_probe(struct spi_device *spi)
> +{
> +	int ret = 0;
> +	struct ld9040 *lcd = NULL;
> +	struct lcd_device *ld = NULL;
> +	struct backlight_device *bd = NULL;
> +
> +	lcd = kzalloc(sizeof(struct ld9040), GFP_KERNEL);
> +	if (!lcd)
> +		return -ENOMEM;
> +
> +	/* ld9040 lcd panel uses 3-wire 9bits SPI Mode. */
> +	spi->bits_per_word = 9;
> +
> +	ret = spi_setup(spi);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "spi setup failed.\n");
> +		goto out_free_lcd;
> +	}
> +
> +	lcd->spi = spi;
> +	lcd->dev = &spi->dev;
> +
> +	lcd->lcd_pd = (struct lcd_platform_data *)spi->dev.platform_data;

Unneeded and undesirable typecast.

> +	if (!lcd->lcd_pd) {
> +		dev_err(&spi->dev, "platform data is NULL.\n");
> +		goto out_free_lcd;
> +	}
> +
> +	ld = lcd_device_register("ld9040", &spi->dev, lcd, &ld9040_lcd_ops);
> +	if (IS_ERR(ld)) {
> +		ret = PTR_ERR(ld);
> +		goto out_free_lcd;
> +	}
> +
> +	lcd->ld = ld;
> +
> +	bd = backlight_device_register("ld9040-bl", &spi->dev,
> +		lcd, &ld9040_backlight_ops, NULL);
> +	if (IS_ERR(ld)) {
> +		ret = PTR_ERR(ld);
> +		goto out_free_lcd;
> +	}
> +
> +	bd->props.max_brightness = MAX_BRIGHTNESS;
> +	bd->props.brightness = MAX_BRIGHTNESS;
> +	lcd->bd = bd;
> +
> +	/*
> +	 * it gets gamma table count available so it gets user
> +	 * know that.
> +	 */
> +	lcd->gamma_table_count > +	    sizeof(gamma_table) / (MAX_GAMMA_LEVEL * sizeof(int));
> +
> +	ret = device_create_file(&(spi->dev), &dev_attr_gamma_mode);
> +	if (ret < 0)
> +		dev_err(&(spi->dev), "failed to add sysfs entries\n");
> +
> +	ret = device_create_file(&(spi->dev), &dev_attr_gamma_table);
> +	if (ret < 0)
> +		dev_err(&(spi->dev), "failed to add sysfs entries\n");

These errors are just ignored.  It would be better to perform cleanup
and to then return the correct errno.

> +	/*
> +	 * if lcd panel was on from bootloader like u-boot then
> +	 * do not lcd on.
> +	 */
> +	if (!lcd->lcd_pd->lcd_enabled) {
> +		/*
> +		 * if lcd panel was off from bootloader then
> +		 * current lcd status is powerdown and then
> +		 * it enables lcd panel.
> +		 */
> +		lcd->power = FB_BLANK_POWERDOWN;
> +
> +		ld9040_power(lcd, FB_BLANK_UNBLANK);
> +	} else
> +		lcd->power = FB_BLANK_UNBLANK;
> +
> +	dev_set_drvdata(&spi->dev, lcd);
> +
> +	dev_info(&spi->dev, "ld9040 panel driver has been probed.\n");
> +	return 0;
> +
> +out_free_lcd:
> +	kfree(lcd);
> +	return ret;
> +}
> +
> +static int __devexit ld9040_remove(struct spi_device *spi)
> +{
> +	struct ld9040 *lcd = dev_get_drvdata(&spi->dev);
> +
> +	ld9040_power(lcd, FB_BLANK_POWERDOWN);
> +	lcd_device_unregister(lcd->ld);
> +	kfree(lcd);
> +
> +	return 0;
> +}
> +
> +#if defined(CONFIG_PM)
> +unsigned int beforepower;

This should be static.

Also, it shouldn't exist.  Its presence assumes that there will only be
one device controlled by this driver.  It should be moved into the
per-device data area.

>
> ...
>
> +struct ld9040_gamma {
> +	unsigned int *gamma_22_table[MAX_GAMMA_LEVEL];
> +};
> +
> +static struct ld9040_gamma gamma_table = {

Could do

static struct ld9040_gamma {
	unsigned int *gamma_22_table[MAX_GAMMA_LEVEL];
} gamma_table = {

here.

> +	.gamma_22_table[0] = (unsigned int *)&ld9040_22_50,
> +	.gamma_22_table[1] = (unsigned int *)&ld9040_22_70,
> +	.gamma_22_table[2] = (unsigned int *)&ld9040_22_80,
> +	.gamma_22_table[3] = (unsigned int *)&ld9040_22_90,
> +	.gamma_22_table[4] = (unsigned int *)&ld9040_22_100,
> +	.gamma_22_table[5] = (unsigned int *)&ld9040_22_110,
> +	.gamma_22_table[6] = (unsigned int *)&ld9040_22_120,
> +	.gamma_22_table[7] = (unsigned int *)&ld9040_22_130,
> +	.gamma_22_table[8] = (unsigned int *)&ld9040_22_140,
> +	.gamma_22_table[9] = (unsigned int *)&ld9040_22_150,
> +	.gamma_22_table[10] = (unsigned int *)&ld9040_22_160,
> +	.gamma_22_table[11] = (unsigned int *)&ld9040_22_170,
> +	.gamma_22_table[12] = (unsigned int *)&ld9040_22_180,
> +	.gamma_22_table[13] = (unsigned int *)&ld9040_22_190,
> +	.gamma_22_table[14] = (unsigned int *)&ld9040_22_200,
> +	.gamma_22_table[15] = (unsigned int *)&ld9040_22_210,
> +	.gamma_22_table[16] = (unsigned int *)&ld9040_22_220,
> +	.gamma_22_table[17] = (unsigned int *)&ld9040_22_230,
> +	.gamma_22_table[18] = (unsigned int *)&ld9040_22_240,
> +	.gamma_22_table[19] = (unsigned int *)&ld9040_22_250,
> +	.gamma_22_table[20] = (unsigned int *)&ld9040_22_260,
> +	.gamma_22_table[21] = (unsigned int *)&ld9040_22_270,
> +	.gamma_22_table[22] = (unsigned int *)&ld9040_22_280,
> +	.gamma_22_table[23] = (unsigned int *)&ld9040_22_290,
> +	.gamma_22_table[24] = (unsigned int *)&ld9040_22_300,
> +};
> +
> +#endif

Defining static tables in a header file is strange.  It would be very
wrong if that header was ever included by more than a single .c file,
so why not just eliminate this file and move its contents into that .c
file?

