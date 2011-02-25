From: Donghwa Lee <dh09.lee@samsung.com>
Date: Fri, 25 Feb 2011 02:31:16 +0000
Subject: Re: [PATCH] drivers: ld9040 amoled driver support
Message-Id: <4D671474.6090907@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294893628-16998-1-git-send-email-dh09.lee@samsung.com>
	<20110224154250.266b2688.akpm@linux-foundation.org>
In-Reply-To: <20110224154250.266b2688.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

 On Fri, 25 Feb 2011 8:42 @t, Andrew Morton wrote:
> On Thu, 13 Jan 2011 13:40:28 +0900
> Donghwa Lee <dh09.lee@samsung.com> wrote:
>
>>  +#define POWER_IS_ON(pwr)	((pwr) <= FB_BLANK_NORMAL)
> This could and should be implemented as a regular lower-case C function.
>
Ok, I will change to lower-case.
>> +
>> +static const unsigned short SEQ_SWRESET[] = {
>> +	0x01, COMMAND_ONLY,
>> +	ENDDEF, 0x00
>> +};
> It's strange that all these tables have upper-case names.  Unless
> there's some special reason for doing it this way, please make them
> regular lower-case identifiers.
>
It means specific register setting tables, but, on second thoughts, it is meaningless. I will change it.
>> ...
>>
>> +static int ld9040_ldi_init(struct ld9040 *lcd)
>> +{
>> +	int ret, i;
>> +	const unsigned short *init_seq[] = {
>> +		SEQ_USER_SETTING,
>> +		SEQ_PANEL_CONDITION,
>> +		SEQ_DISPCTL,
>> +		SEQ_MANPWR,
>> +		SEQ_PWR_CTRL,
>> +		SEQ_ELVSS_ON,
>> +		SEQ_GTCON,
>> +		SEQ_GAMMA_SET1,
>> +		SEQ_GAMMA_CTRL,
>> +		SEQ_SLPOUT,
>> +	};
> Make this table static so the compiler doesn't rebuild it on the stack
> each time the function is called.  The compiler probably already
> performs that optimisation, but it doesn't hurt to be explicit.
>
Ok, I will modify it.
>  +static ssize_t ld9040_sysfs_show_gamma_mode(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct ld9040 *lcd = dev_get_drvdata(dev);
> +	char temp[10];
> +
> +	switch (lcd->gamma_mode) {
> +	case 0:
> +		sprintf(temp, "2.2 mode\n");
> +		strcat(buf, temp);
> Could do sprintf(buf + strlen(buf)) and eliminate temp[].
Current gamma table is only one, so I remove all about gamma mode.
>> +static ssize_t ld9040_sysfs_store_gamma_mode(struct device *dev,
>> +				       struct device_attribute *attr,
>> +				       const char *buf, size_t len)
>> +{
>> +	struct ld9040 *lcd = dev_get_drvdata(dev);
>> +	struct backlight_device *bd = NULL;
>> +	int brightness, rc;
>> +
>> +	rc = strict_strtoul(buf, 0, (unsigned long *)&lcd->gamma_mode);
> That's a bug.  gamma_mode has type int, which is 4 bytes, but you're
> telling strict_strtoul() to write eight bytes - it will corrupt *lcd on
> a 64-bit machine.  Use a temporary.
>
Current gamma table is only one, so I remove all about gamma mode.
>> +
>> +static DEVICE_ATTR(gamma_mode, 0644,
>> +		ld9040_sysfs_show_gamma_mode, ld9040_sysfs_store_gamma_mode);
>> +
>> +static ssize_t ld9040_sysfs_show_gamma_table(struct device *dev,
>> +				      struct device_attribute *attr, char *buf)
>> +{
>> +	struct ld9040 *lcd = dev_get_drvdata(dev);
>> +	char temp[3];
>> +
>> +	sprintf(temp, "%d\n", lcd->gamma_table_count);
>> +	strcpy(buf, temp);
> sprintf(buf + strlen(buf), remove temp[].
>
Current gamma table is only one, so I remove all about gamma mode.
>> +	return strlen(buf);
>> +}
>> +
>> +static DEVICE_ATTR(gamma_table, 0644,
>> +		ld9040_sysfs_show_gamma_table, NULL);
>> +
>> +static int ld9040_probe(struct spi_device *spi)
>> +{
>> +	int ret = 0;
>> +	struct ld9040 *lcd = NULL;
>> +	struct lcd_device *ld = NULL;
>> +	struct backlight_device *bd = NULL;
>> +
>> +	lcd = kzalloc(sizeof(struct ld9040), GFP_KERNEL);
>> +	if (!lcd)
>> +		return -ENOMEM;
>> +
>> +	/* ld9040 lcd panel uses 3-wire 9bits SPI Mode. */
>> +	spi->bits_per_word = 9;
>> +
>> +	ret = spi_setup(spi);
>> +	if (ret < 0) {
>> +		dev_err(&spi->dev, "spi setup failed.\n");
>> +		goto out_free_lcd;
>> +	}
>> +
>> +	lcd->spi = spi;
>> +	lcd->dev = &spi->dev;
>> +
>> +	lcd->lcd_pd = (struct lcd_platform_data *)spi->dev.platform_data;
> Unneeded and undesirable typecast.
>
Ok, I will modify it.
>> +	/*
>> +	 * it gets gamma table count available so it gets user
>> +	 * know that.
>> +	 */
>> +	lcd->gamma_table_count >> +	    sizeof(gamma_table) / (MAX_GAMMA_LEVEL * sizeof(int));
>> +
>> +	ret = device_create_file(&(spi->dev), &dev_attr_gamma_mode);
>> +	if (ret < 0)
>> +		dev_err(&(spi->dev), "failed to add sysfs entries\n");
>> +
>> +	ret = device_create_file(&(spi->dev), &dev_attr_gamma_table);
>> +	if (ret < 0)
>> +		dev_err(&(spi->dev), "failed to add sysfs entries\n");
> These errors are just ignored.  It would be better to perform cleanup
> and to then return the correct errno.
>
Above, creating sysfs node is unneeded. I will remove it.
>> +
>> +#if defined(CONFIG_PM)
>> +unsigned int beforepower;
> This should be static.
>
> Also, it shouldn't exist.  Its presence assumes that there will only be
> one device controlled by this driver.  It should be moved into the
> per-device data area.
>
Yes, you're right. beforepower variable is unneeded, I will remove it.
>> ...
>>
>> +struct ld9040_gamma {
>> +	unsigned int *gamma_22_table[MAX_GAMMA_LEVEL];
>> +};
>> +
>> +static struct ld9040_gamma gamma_table = {
> Could do
>
> static struct ld9040_gamma {
> 	unsigned int *gamma_22_table[MAX_GAMMA_LEVEL];
> } gamma_table = {
>
> here.
>
Ok, I will move it.
>> +	.gamma_22_table[0] = (unsigned int *)&ld9040_22_50,
>> +	.gamma_22_table[1] = (unsigned int *)&ld9040_22_70,
>> +	.gamma_22_table[2] = (unsigned int *)&ld9040_22_80,
>> +	.gamma_22_table[3] = (unsigned int *)&ld9040_22_90,
>> +	.gamma_22_table[4] = (unsigned int *)&ld9040_22_100,
>> +	.gamma_22_table[5] = (unsigned int *)&ld9040_22_110,
>> +	.gamma_22_table[6] = (unsigned int *)&ld9040_22_120,
>> +	.gamma_22_table[7] = (unsigned int *)&ld9040_22_130,
>> +	.gamma_22_table[8] = (unsigned int *)&ld9040_22_140,
>> +	.gamma_22_table[9] = (unsigned int *)&ld9040_22_150,
>> +	.gamma_22_table[10] = (unsigned int *)&ld9040_22_160,
>> +	.gamma_22_table[11] = (unsigned int *)&ld9040_22_170,
>> +	.gamma_22_table[12] = (unsigned int *)&ld9040_22_180,
>> +	.gamma_22_table[13] = (unsigned int *)&ld9040_22_190,
>> +	.gamma_22_table[14] = (unsigned int *)&ld9040_22_200,
>> +	.gamma_22_table[15] = (unsigned int *)&ld9040_22_210,
>> +	.gamma_22_table[16] = (unsigned int *)&ld9040_22_220,
>> +	.gamma_22_table[17] = (unsigned int *)&ld9040_22_230,
>> +	.gamma_22_table[18] = (unsigned int *)&ld9040_22_240,
>> +	.gamma_22_table[19] = (unsigned int *)&ld9040_22_250,
>> +	.gamma_22_table[20] = (unsigned int *)&ld9040_22_260,
>> +	.gamma_22_table[21] = (unsigned int *)&ld9040_22_270,
>> +	.gamma_22_table[22] = (unsigned int *)&ld9040_22_280,
>> +	.gamma_22_table[23] = (unsigned int *)&ld9040_22_290,
>> +	.gamma_22_table[24] = (unsigned int *)&ld9040_22_300,
>> +};
>> +
>> +#endif
> Defining static tables in a header file is strange.  It would be very
> wrong if that header was ever included by more than a single .c file,
> so why not just eliminate this file and move its contents into that .c
> file?
>
But, if its contents moved into that .c file, ld9040.c  becomes very long file.
Ld9040.c file already had many register set data variable, I think readability is less than
before.


I'm very grateful to you for your review.
Thank you.

Donghwa Lee
