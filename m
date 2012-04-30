From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 30 Apr 2012 21:30:32 +0000
Subject: Re: [PATCH v3] backlight: Add LMS501KF03 LCD panel driver
Message-Id: <20120430143032.6bf1fa53.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1335762762-20532-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1335762762-20532-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, 30 Apr 2012 10:42:42 +0530
Sachin Kamat <sachin.kamat@linaro.org> wrote:

> LMS501KF03 is a 480x800 LCD module with brightness control.
> The driver uses 3-wired SPI inteface.
> 
>
> ...
>
> +struct lms501kf03 {
> +	struct device			*dev;
> +	struct spi_device		*spi;
> +	unsigned int			power;
> +	struct lcd_device		*ld;
> +	struct lcd_platform_data	*lcd_pd;
> +};
> +
> +const unsigned short seq_password[] = {

static

> +	0xb9, 0xff, 0x83, 0x69,
> +	ENDDEF
> +};
> +
> +const unsigned short seq_power[] = {

static

> +	0xb1, 0x01, 0x00, 0x34, 0x06, 0x00, 0x14, 0x14, 0x20, 0x28,
> +	0x12, 0x12, 0x17, 0x0a, 0x01, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6,
> +	ENDDEF
> +};
> +
> +const unsigned short seq_display[] = {

static

> +	0xb2, 0x00, 0x2b, 0x03, 0x03, 0x70, 0x00, 0xff, 0x00, 0x00,
> +	0x00, 0x00, 0x03, 0x03, 0x00, 0x01,
> +	ENDDEF
> +};
> +
> +const unsigned short seq_rgb_if[] = {

etcetera.

> +	0xb3, 0x09,
> +	ENDDEF
> +};
> +
>
> ...
>
> +static int lms501kf03_panel_send_sequence(struct lms501kf03 *lcd,
> +	const unsigned short *wbuf)
> +{
> +	int ret = 0, i = 0;
> +
> +	while (wbuf[i] != ENDDEF) {
> +		if (i = 0)
> +			ret = lms501kf03_spi_write(lcd, COMMAND_ONLY, wbuf[i]);
> +		else
> +			ret = lms501kf03_spi_write(lcd, DATA_ONLY, wbuf[i]);
> +		if (ret)
> +			break;
> +
> +		udelay(100);

That's a pretty long delay.

A problem with mdelay(), udelay() etc is that it is very hard for the
reader to work out why the delay is there, and why the particular
duration was chosen.  hence code comments are useful here.


> +		i += 1;
> +	}
> +	return ret;
> +}
> +
> +static int lms501kf03_ldi_init(struct lms501kf03 *lcd)
> +{
> +	int ret, i;
> +	const unsigned short *init_seq[] = {
> +		seq_password,
> +		seq_power,
> +		seq_display,
> +		seq_rgb_if,
> +		seq_display_inv,
> +		seq_vcom,
> +		seq_gate,
> +		seq_panel,
> +		seq_col_mod,
> +		seq_w_gamma,
> +		seq_rgb_gamma,
> +		seq_sleep_out,
> +	};

Can that be made static?  If so, you'll probably find that the code
gets smaller and faster.

> +	for (i = 0; i < ARRAY_SIZE(init_seq); i++) {
> +		ret = lms501kf03_panel_send_sequence(lcd, init_seq[i]);
> +		if (ret)
> +			break;
> +	}
> +	mdelay(120);

And that's a huuuuuuuge delay!  Definitely needs a comment describeing
why we need to do such an awkward thing.

> +
> +	return ret;
> +}
> +
>
> ...
>
> +static int lms501kf03_power_is_on(int power)
> +{
> +	return ((power) <= FB_BLANK_NORMAL);

Unneeded parentheses.

> +}
> +
>
> ...
>
> +
> +static int lms501kf03_power_off(struct lms501kf03 *lcd)
> +{
> +	int ret = 0;
> +	struct lcd_platform_data *pd = NULL;
> +
> +	pd = lcd->lcd_pd;
> +	if (!pd) {

I assume this can't happen?

> +		dev_err(lcd->dev, "platform data is NULL\n");
> +		return -EFAULT;
> +	}
> +
> +	ret = lms501kf03_ldi_disable(lcd);
> +	if (ret) {
> +		dev_err(lcd->dev, "lcd setting failed.\n");
> +		return -EIO;
> +	}
> +
> +	mdelay(pd->power_off_delay);
> +
> +	if (!pd->power_on) {

And this can't happen either?

> +		dev_err(lcd->dev, "power_on is NULL.\n");
> +		return -EFAULT;
> +	} else {
> +		pd->power_on(lcd->ld, 0);
> +	}
> +
> +	return 0;
> +}
> +
> +static int lms501kf03_power(struct lms501kf03 *lcd, int power)
> +{
> +	int ret = 0;
> +
> +	if (lms501kf03_power_is_on(power) &&
> +			!lms501kf03_power_is_on(lcd->power))
> +		ret = lms501kf03_power_on(lcd);
> +	else if (!lms501kf03_power_is_on(power) &&
> +			lms501kf03_power_is_on(lcd->power))
> +		ret = lms501kf03_power_off(lcd);
> +
> +	if (!ret)
> +		lcd->power = power;
> +
> +	return ret;
> +}

This function needs a comment - what does it do and how does it
interpret its argument?

> +static int lms501kf03_get_power(struct lcd_device *ld)
> +{
> +	struct lms501kf03 *lcd = lcd_get_data(ld);
> +
> +	return lcd->power;
> +}
> +
>
> ...
>
> +#if defined(CONFIG_PM)
> +unsigned int before_power;

static.

Also, this restricts the driver to servicing a single device.  That's
probably not a problem in the real world but it's still a bit
regrettable.  Can't this be stored in `struct lms501kf03'?

>
> ...
>
> +static int lms501kf03_resume(struct spi_device *spi)
> +{
> +	int ret = 0;
> +	struct lms501kf03 *lcd = dev_get_drvdata(&spi->dev);
> +
> +	/*
> +	 * after suspended, if lcd panel status is FB_BLANK_UNBLANK

"After suspend".

> +	 * (at that time, before_power is FB_BLANK_UNBLANK) then
> +	 * it changes that status to FB_BLANK_POWERDOWN to get lcd on.
> +	 */
> +	if (before_power = FB_BLANK_UNBLANK)
> +		lcd->power = FB_BLANK_POWERDOWN;

This lokos a bit odd.  Is it a workaround for some hardware bug? 
What's actually going on here and why don't other drivers need to do
this? (IOW: needs a better comment!)

> +	dev_dbg(&spi->dev, "before_power = %d\n", before_power);
> +
> +	ret = lms501kf03_power(lcd, before_power);
> +
> +	return ret;
> +}
>
> ...
>

