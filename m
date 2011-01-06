From: InKi Dae <daeinki@gmail.com>
Date: Thu, 06 Jan 2011 06:31:02 +0000
Subject: Re: [PATCH 5/5] S5PC110: add MIPI-DSI based sample lcd panel driver.
Message-Id: <AANLkTinQznYQgw5Hf8jT=C0Tv2=T7AcGZuQgw398Q_a6@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1293535595-24861-1-git-send-email-inki.dae@samsung.com>
	<20110106051458.GP23889@linux-sh.org>
In-Reply-To: <20110106051458.GP23889@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

thank you for your reviews.

all the problems you  pointed out would be corrected for actual lcd
panel driver.
(this lcd panel driver has being worked locally and it will be posted
in the future)

after this patch, I posted next patches.
refer to below please.
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/101521

in this patch, I removed sample driver and also have code compacting
and refactoring for MIPI-DSI driver. so could you please give me your
review about this one?

2011/1/6 Paul Mundt <lethal@linux-sh.org>:
> On Tue, Dec 28, 2010 at 08:26:35PM +0900, Inki Dae wrote:
>> this patch addes MIPI-DSI based sample panel driver.
>> to write MIPI-DSI based lcd panel driver, you can refer to
>> this sample driver.
>>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>
> Sample drivers are ok, but unless it has some sort of practical run-time
> use you are probably better off just including this along with your
> subsystem/platform documentation in Documentation somewhere. You can
> search for .c files there to see how others are doing it.
>
> Having said that ..
>
>> diff --git a/drivers/video/s5p_mipi_sample.c b/drivers/video/s5p_mipi_sa=
mple.c
>> new file mode 100644
>> index 0000000..8a8abfe
>> --- /dev/null
>> +++ b/drivers/video/s5p_mipi_sample.c
>> @@ -0,0 +1,220 @@
>> +/* linux/drivers/video/sample.c
>> + *
> This is precisely why file comments are useless, since they invariably
> fail to match up.
>
>> + * MIPI-DSI based sample AMOLED lcd panel driver.
>> + *
>> + * Inki Dae, <inki.dae@samsung.com>
>> + *
> No Copyright notice?
>
>> +static void sample_long_command(struct sample *lcd)
>> +{
>> + =A0 =A0 struct dsim_master_ops *ops =3D lcd_to_master_ops(lcd);
>> + =A0 =A0 unsigned char data_to_send[5] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 0x00, 0x00, 0x00, 0x00, 0x00
>> + =A0 =A0 };
>> +
>> + =A0 =A0 ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 (unsigned int) data_to_send, sizeof(data_to_se=
nd));
>> +}
>> +
>> +static void sample_short_command(struct sample *lcd)
>> +{
>> + =A0 =A0 struct dsim_master_ops *ops =3D lcd_to_master_ops(lcd);
>> +
>> + =A0 =A0 ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_SHORT_WRITE_PA=
RAM,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00, 0x00);
>> +}
>> +
> ops->cmd_write() can fail for any number of reasons, so you will want to
> change these to make sure that you are actually handling the error cases.
>
>> +static int sample_panel_init(struct sample *lcd)
>> +{
>> + =A0 =A0 sample_long_command(lcd);
>> + =A0 =A0 sample_short_command(lcd);
>> +
>> + =A0 =A0 return 0;
>
> At which point you can fail the initialization instead of just blowing up
> later.
>
>> +static int sample_gamma_ctrl(struct sample *lcd, int gamma)
>> +{
>> + =A0 =A0 struct dsim_master_ops *ops =3D lcd_to_master_ops(lcd);
>> +
>> + =A0 =A0 /* change transfer mode to LP mode */
>> + =A0 =A0 if (ops->change_dsim_transfer_mode)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ops->change_dsim_transfer_mode(lcd_to_master(l=
cd), 0);
>> +
> ops->change_dsim_transfer_mode() can also fail. You could do this more
> cleanly as:
>
> enum { DSIM_XFER_LP, DSIM_XFER_HS };
>
> static inline int dsim_set_xfer_mode(struct mipi_dsim_device *dsim, int m=
ode)
> {
> =A0 =A0 =A0 =A0struct mipi_dsim_master_ops *ops =3D dsim->master_ops;
>
> =A0 =A0 =A0 =A0if (!ops->change_dsim_transfer_mode)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOSYS; /* not implemented */
>
> =A0 =A0 =A0 =A0return ops->change_dsim_transfer_mode(dsim, mode);
> }
>
> Then simply do your sample_gamma_ctrl() as:
>
> =A0 =A0 =A0 =A0ret =3D dsim_set_xfer_mode(dsim, DSIM_XFER_LP);
> =A0 =A0 =A0 =A0if (ret !=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
>> + =A0 =A0 /* update gamma table. */
>> +
>
> =A0 =A0 =A0 =A0return dsim_set_xfer_mode(dsim, DSIM_XFER_HS);
>> +}
>> +
>
> Or something similar. Your sample code should really be as
> self-documenting and error-proof as possible. You don't really want to be
> in a situation where subtle bugs leak through that then everyone who uses
> this code as a reference will carry over!
>
>> +static int sample_set_brightness(struct backlight_device *bd)
>> +{
>> + =A0 =A0 int ret =3D 0, brightness =3D bd->props.brightness;
>> + =A0 =A0 struct sample *lcd =3D bl_get_data(bd);
>> +
>> + =A0 =A0 if (brightness < MIN_BRIGHTNESS ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 brightness > bd->props.max_brightness) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lcd->dev, "lcd brightness should be %d=
 to %d.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MIN_BRIGHTNESS, MAX_BRIGHTNESS=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D sample_gamma_ctrl(lcd, bd->props.brightness);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&bd->dev, "lcd brightness setting fail=
ed.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 }
>> +
> With your current approach this error condition will never be reached,
> for example.
>
>> +static int sample_probe(struct mipi_lcd_device *mipi_dev)
>> +{
>> + =A0 =A0 struct sample *lcd =3D NULL;
>> + =A0 =A0 struct backlight_device *bd =3D NULL;
>> +
>> + =A0 =A0 lcd =3D kzalloc(sizeof(struct sample), GFP_KERNEL);
>> + =A0 =A0 if (!lcd) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&mipi_dev->dev, "failed to allocate sa=
mple structure.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 lcd->mipi_dev =3D mipi_dev;
>> + =A0 =A0 lcd->ddi_pd >> + =A0 =A0 =A0 =A0 =A0 =A0 (struct mipi_ddi_plat=
form_data *)device_to_ddi_pd(mipi_dev);
>
> Does this really need to be casted?
>
>> + =A0 =A0 lcd->dev =3D &mipi_dev->dev;
>> +
>> + =A0 =A0 dev_set_drvdata(&mipi_dev->dev, lcd);
>> +
>> + =A0 =A0 bd =3D backlight_device_register("sample-bl", lcd->dev, lcd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 &sample_backlight_ops, NULL);
>> +
>> + =A0 =A0 lcd->bd =3D bd;
>> +
> And here you have no error checking for backlight registration, so you
> will get a NULL pointer deref:
>
>> + =A0 =A0 bd->props.max_brightness =3D MAX_BRIGHTNESS;
>> + =A0 =A0 bd->props.brightness =3D MAX_BRIGHTNESS;
>> +
> here. backlight_device_register() returns an ERR_PTR(), so you will want
> to do an IS_ERR() check, which you can then map back with PTR_ERR() for a
> more precise idea of why it failed.
>
>> + =A0 =A0 /* lcd power on */
>> + =A0 =A0 if (lcd->ddi_pd->lcd_power_on)
>> + =A0 =A0 =A0 =A0 =A0 =A0 lcd->ddi_pd->lcd_power_on(NULL, 1);
>> +
> You may wish to use enums for this too. It's not strictly necessary, but
> it does help to clarify which is the on and which is the off position.
>
>> + =A0 =A0 mdelay(lcd->ddi_pd->reset_delay);
>> +
>> + =A0 =A0 /* lcd reset */
>> + =A0 =A0 if (lcd->ddi_pd->lcd_reset)
>> + =A0 =A0 =A0 =A0 =A0 =A0 lcd->ddi_pd->lcd_reset(NULL);
>> +
> Reset can fail?
>
>> + =A0 =A0 sample_panel_init(lcd);
>> +
>> + =A0 =A0 return 0;
>> +}
> sample_panel_init() can fail as well, and in both cases you will need to
> clean up all of the above work.
>
>> +
>> +#ifdef CONFIG_PM
>> +static int sample_suspend(struct mipi_lcd_device *mipi_dev)
>> +{
>> + =A0 =A0 struct sample *lcd =3D dev_get_drvdata(&mipi_dev->dev);
>> +
>> + =A0 =A0 /* some work. */
>> +
>> + =A0 =A0 mdelay(lcd->ddi_pd->power_off_delay);
>> +
> Adding delays in the suspend/resume path sounds like a pretty bad idea,
> is there a technical reason for it? If so, please document it, so people
> get some idea of where their suspend/resume latencies are coming from,
> and why.
>
>> +static struct mipi_lcd_driver sample_mipi_driver =3D {
>> + =A0 =A0 .name =3D "sample",
>> +
>> + =A0 =A0 .probe =3D sample_probe,
>
> No remove?
>
>> + =A0 =A0 .suspend =3D sample_suspend,
>> + =A0 =A0 .resume =3D sample_resume,
>> +};
>> +
>> +static int sample_init(void)
>> +{
>> + =A0 =A0 s5p_mipi_register_lcd_driver(&sample_mipi_driver);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
> This should be:
>
> =A0 =A0 =A0 =A0return s5p_mipi_register_lcd_driver(&sample_mipi_driver);
>
> And sample_init should be __init annotated.
>
>> +static void sample_exit(void)
>> +{
>> + =A0 =A0 return;
>> +}
>> +
> This should be balanced with a
>
> =A0 =A0 =A0 =A0s5p_mipi_unregister_lcd_driver(&sample_mipi_driver);
>
>> +module_init(sample_init);
>> +module_exit(sample_exit);
>> +
>> +MODULE_AUTHOR("Inki Dae <inki.dae@samsung.com>");
>> +MODULE_DESCRIPTION("MIPI-DSI based sample AMOLED LCD Panel Driver");
>> +MODULE_LICENSE("GPL");
>
> Since you have a fairly complex subsystem it's probably a good idea to
> work out how your MODULE_ALIAS() is going to work, so that you can handle
> autoprobe for these things via udev. The fact you have no exit path
> definitely suggests you haven't tested this in a modular configuration,
> so there is probably going to be quite a bit of work to do here.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
