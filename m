From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Jan 2011 05:14:58 +0000
Subject: Re: [PATCH 5/5] S5PC110: add MIPI-DSI based sample lcd panel driver.
Message-Id: <20110106051458.GP23889@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1293535595-24861-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1293535595-24861-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Dec 28, 2010 at 08:26:35PM +0900, Inki Dae wrote:
> this patch addes MIPI-DSI based sample panel driver.
> to write MIPI-DSI based lcd panel driver, you can refer to
> this sample driver.
> 
> Signed-off-by: Inki Dae <inki.dae@samsung.com>

Sample drivers are ok, but unless it has some sort of practical run-time
use you are probably better off just including this along with your
subsystem/platform documentation in Documentation somewhere. You can
search for .c files there to see how others are doing it.

Having said that ..

> diff --git a/drivers/video/s5p_mipi_sample.c b/drivers/video/s5p_mipi_sample.c
> new file mode 100644
> index 0000000..8a8abfe
> --- /dev/null
> +++ b/drivers/video/s5p_mipi_sample.c
> @@ -0,0 +1,220 @@
> +/* linux/drivers/video/sample.c
> + *
This is precisely why file comments are useless, since they invariably
fail to match up.

> + * MIPI-DSI based sample AMOLED lcd panel driver.
> + *
> + * Inki Dae, <inki.dae@samsung.com>
> + *
No Copyright notice?

> +static void sample_long_command(struct sample *lcd)
> +{
> +	struct dsim_master_ops *ops = lcd_to_master_ops(lcd);
> +	unsigned char data_to_send[5] = {
> +		0x00, 0x00, 0x00, 0x00, 0x00
> +	};
> +
> +	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
> +		(unsigned int) data_to_send, sizeof(data_to_send));
> +}
> +
> +static void sample_short_command(struct sample *lcd)
> +{
> +	struct dsim_master_ops *ops = lcd_to_master_ops(lcd);
> +
> +	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_SHORT_WRITE_PARAM,
> +				0x00, 0x00);
> +}
> +
ops->cmd_write() can fail for any number of reasons, so you will want to
change these to make sure that you are actually handling the error cases.

> +static int sample_panel_init(struct sample *lcd)
> +{
> +	sample_long_command(lcd);
> +	sample_short_command(lcd);
> +
> +	return 0;

At which point you can fail the initialization instead of just blowing up
later.

> +static int sample_gamma_ctrl(struct sample *lcd, int gamma)
> +{
> +	struct dsim_master_ops *ops = lcd_to_master_ops(lcd);
> +
> +	/* change transfer mode to LP mode */
> +	if (ops->change_dsim_transfer_mode)
> +		ops->change_dsim_transfer_mode(lcd_to_master(lcd), 0);
> +
ops->change_dsim_transfer_mode() can also fail. You could do this more
cleanly as:

enum { DSIM_XFER_LP, DSIM_XFER_HS };

static inline int dsim_set_xfer_mode(struct mipi_dsim_device *dsim, int mode)
{
	struct mipi_dsim_master_ops *ops = dsim->master_ops;

	if (!ops->change_dsim_transfer_mode)
		return -ENOSYS;	/* not implemented */

	return ops->change_dsim_transfer_mode(dsim, mode);
}

Then simply do your sample_gamma_ctrl() as:

	ret = dsim_set_xfer_mode(dsim, DSIM_XFER_LP);
	if (ret != 0)
		return ret;

> +	/* update gamma table. */
> +

	return dsim_set_xfer_mode(dsim, DSIM_XFER_HS);
> +}
> +

Or something similar. Your sample code should really be as
self-documenting and error-proof as possible. You don't really want to be
in a situation where subtle bugs leak through that then everyone who uses
this code as a reference will carry over!

> +static int sample_set_brightness(struct backlight_device *bd)
> +{
> +	int ret = 0, brightness = bd->props.brightness;
> +	struct sample *lcd = bl_get_data(bd);
> +
> +	if (brightness < MIN_BRIGHTNESS ||
> +		brightness > bd->props.max_brightness) {
> +		dev_err(lcd->dev, "lcd brightness should be %d to %d.\n",
> +			MIN_BRIGHTNESS, MAX_BRIGHTNESS);
> +		return -EINVAL;
> +	}
> +
> +	ret = sample_gamma_ctrl(lcd, bd->props.brightness);
> +	if (ret) {
> +		dev_err(&bd->dev, "lcd brightness setting failed.\n");
> +		return -EIO;
> +	}
> +
With your current approach this error condition will never be reached,
for example.

> +static int sample_probe(struct mipi_lcd_device *mipi_dev)
> +{
> +	struct sample *lcd = NULL;
> +	struct backlight_device *bd = NULL;
> +
> +	lcd = kzalloc(sizeof(struct sample), GFP_KERNEL);
> +	if (!lcd) {
> +		dev_err(&mipi_dev->dev, "failed to allocate sample structure.\n");
> +		return -ENOMEM;
> +	}
> +
> +	lcd->mipi_dev = mipi_dev;
> +	lcd->ddi_pd > +		(struct mipi_ddi_platform_data *)device_to_ddi_pd(mipi_dev);

Does this really need to be casted?

> +	lcd->dev = &mipi_dev->dev;
> +
> +	dev_set_drvdata(&mipi_dev->dev, lcd);
> +
> +	bd = backlight_device_register("sample-bl", lcd->dev, lcd,
> +		&sample_backlight_ops, NULL);
> +
> +	lcd->bd = bd;
> +
And here you have no error checking for backlight registration, so you
will get a NULL pointer deref:

> +	bd->props.max_brightness = MAX_BRIGHTNESS;
> +	bd->props.brightness = MAX_BRIGHTNESS;
> +
here. backlight_device_register() returns an ERR_PTR(), so you will want
to do an IS_ERR() check, which you can then map back with PTR_ERR() for a
more precise idea of why it failed.

> +	/* lcd power on */
> +	if (lcd->ddi_pd->lcd_power_on)
> +		lcd->ddi_pd->lcd_power_on(NULL, 1);
> +
You may wish to use enums for this too. It's not strictly necessary, but
it does help to clarify which is the on and which is the off position.

> +	mdelay(lcd->ddi_pd->reset_delay);
> +
> +	/* lcd reset */
> +	if (lcd->ddi_pd->lcd_reset)
> +		lcd->ddi_pd->lcd_reset(NULL);
> +
Reset can fail?

> +	sample_panel_init(lcd);
> +
> +	return 0;
> +}
sample_panel_init() can fail as well, and in both cases you will need to
clean up all of the above work.

> +
> +#ifdef CONFIG_PM
> +static int sample_suspend(struct mipi_lcd_device *mipi_dev)
> +{
> +	struct sample *lcd = dev_get_drvdata(&mipi_dev->dev);
> +
> +	/* some work. */
> +
> +	mdelay(lcd->ddi_pd->power_off_delay);
> +
Adding delays in the suspend/resume path sounds like a pretty bad idea,
is there a technical reason for it? If so, please document it, so people
get some idea of where their suspend/resume latencies are coming from,
and why.

> +static struct mipi_lcd_driver sample_mipi_driver = {
> +	.name = "sample",
> +
> +	.probe = sample_probe,

No remove?

> +	.suspend = sample_suspend,
> +	.resume = sample_resume,
> +};
> +
> +static int sample_init(void)
> +{
> +	s5p_mipi_register_lcd_driver(&sample_mipi_driver);
> +
> +	return 0;
> +}
> +
This should be:

	return s5p_mipi_register_lcd_driver(&sample_mipi_driver);

And sample_init should be __init annotated.

> +static void sample_exit(void)
> +{
> +	return;
> +}
> +
This should be balanced with a

	s5p_mipi_unregister_lcd_driver(&sample_mipi_driver);

> +module_init(sample_init);
> +module_exit(sample_exit);
> +
> +MODULE_AUTHOR("Inki Dae <inki.dae@samsung.com>");
> +MODULE_DESCRIPTION("MIPI-DSI based sample AMOLED LCD Panel Driver");
> +MODULE_LICENSE("GPL");

Since you have a fairly complex subsystem it's probably a good idea to
work out how your MODULE_ALIAS() is going to work, so that you can handle
autoprobe for these things via udev. The fact you have no exit path
definitely suggests you haven't tested this in a modular configuration,
so there is probably going to be quite a bit of work to do here.
