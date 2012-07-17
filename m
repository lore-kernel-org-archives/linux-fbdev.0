From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue, 17 Jul 2012 16:22:41 +0000
Subject: Re: [PATCH 1/4] video: Add support for the Solomon SSD1307 OLED Controller
Message-Id: <20120717182241.668004dc@skate>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342540787-14930-1-git-send-email-maxime.ripard@free-electrons.com>
 <1342540787-14930-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1342540787-14930-2-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Le Tue, 17 Jul 2012 17:59:44 +0200,
Maxime Ripard <maxime.ripard@free-electrons.com> a =C3=A9crit :

> This patches adds support for the Solomon SSD1307 OLED

patches -> patch

> controller found on the Crystalfontz CFA10036 board.
>=20
> It is a monochrome 128x39 display, that can operate over
> I2C or SPI.

The display is not 128x39, but rather the SSD1307 controller can drive
monochrome displays up to 128x39 pixels.

> The current driver as only be tested on the CFA-10036,

as -> has

> that is using this controller over I2C to driver a 96x16
> OLED screen.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Brian Lilly <brian@crystalfontz.com>

Ideally, it would be nice if this driver was more separated from the
display size (i.e the display size would be passed as DT properties,
for example), and that the driver would support different display
sizes. However, having an initial implementation that works for 96x16
is probably a good starting point.

> +Required properties:
> +  - compatible: Should be "solomon,ssd1307fb-<bus>". The only supported =
bus for
> +    now is i2c.
> +  - reg: Should contain address of the controller on the I2C bus. Most l=
ikely
> +         0x3c or 0x3d
> +  - pwm: Should contain the pwm to use according to the OF device tree P=
WM
> +         specification [0]
> +  - oled-reset-gpios: Should contain the GPIO used to reset the OLED dis=
play

Since there is only one gpio for reset, is is necessary to have a 's'
at the end of oled-reset-gpios?

> +Optional properties:
> +  - reset-active-low: Is the reset gpio is active on physical low?

Shouldn't this one be called oled-reset-active-low, for consistency
with the oled-reset-gpio property?

> +static int ssd1307fb_write_cmd_array(struct i2c_client *client, u8* cmd,=
 u32 len)
> +{
> +	u8 *buf;
> +	int ret;

	int ret =3D 0;

> +
> +	buf =3D kzalloc(len + 1, GFP_KERNEL);
> +	if (!buf) {
> +		dev_err(&client->dev, "Couldn't allocate sending buffer.\n");
> +		ret =3D -ENOMEM;
> +		goto error;

		goto out;

> +	}
> +
> +	buf[0] =3D SSD1307FB_COMMAND;
> +	memcpy(buf + 1, cmd, len);
> +
> +	ret =3D i2c_master_send(client, buf, len + 1);
> +	if (ret !=3D len + 1) {
> +		dev_err(&client->dev, "Couldn't send I2C command.\n");
> +		goto error;

		goto out;

> +	}
> +
> +	kfree(buf);
> +	return 0;

delete those lines.

> +
> +error:

   out:
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static inline int ssd1307fb_write_cmd(struct i2c_client *client, u8 cmd)
> +{
> +	return ssd1307fb_write_cmd_array(client, &cmd, 1);
> +}
> +
> +static int ssd1307fb_write_data_array(struct i2c_client *client, u8* cmd=
, u32 len)
> +{
> +	u8 *buf;
> +	int ret;
> +
> +	buf =3D kzalloc(len + 1, GFP_KERNEL);
> +	if (!buf) {
> +		dev_err(&client->dev, "Couldn't allocate sending buffer.\n");
> +		ret =3D -ENOMEM;
> +		goto error;
> +	}
> +
> +	buf[0] =3D SSD1307FB_DATA;
> +	memcpy(buf + 1, cmd, len);
> +
> +	ret =3D i2c_master_send(client, buf, len + 1);
> +	if (ret !=3D len + 1) {
> +		dev_err(&client->dev, "Couldn't send I2C data.\n");
> +		goto error;
> +	}
> +
> +	kfree(buf);
> +	return 0;
> +
> +error:
> +	kfree(buf);
> +	return ret;
> +}

This looks highly duplicated from the write_cmd_array(). I'm sure some
factorization is possible here :)

> +static inline int ssd1307fb_write_data(struct i2c_client *client, u8 dat=
a)
> +{
> +	return ssd1307fb_write_data_array(client, &data, 1);
> +}
> +
> +static int ssd1307fb_set(struct i2c_client *client, u8 value)
> +{
> +	int i, j, ret;
> +
> +	for (i =3D 1; i <=3D (SSD1307FB_HEIGHT / 8); i++) {
> +		ret =3D ssd1307fb_write_cmd(client, SSD1307FB_START_PAGE_ADDRESS + i);
> +		if (ret)
> +			goto i2c_error;
> +
> +		ret =3D ssd1307fb_write_cmd(client, 0x00);
> +		if (ret)
> +			goto i2c_error;
> +
> +		ret =3D ssd1307fb_write_cmd(client, 0x10);
> +		if (ret)
> +			goto i2c_error;
> +
> +		for (j =3D 0; j < SSD1307FB_WIDTH; j++)
> +			ssd1307fb_write_data(client, value);
> +	}
> +
> +	return 0;
> +
> +i2c_error:
> +	dev_err(&client->dev, "Couldn't send i2c command: %d\n", ret);
> +	return ret;
> +}
> +
> +static void ssd1307fb_update_display(struct ssd1307fb_par *par)
> +{
> +	u8 *vmem =3D par->info->screen_base;
> +	int i, j, k;
> +
> +	/*=20
> +	 * A page is 8 bit large and covers all the line. In order to

by "large", you mean the "height", so I wouldn't use the word "large",
which I think is typically associated with "width" rather than "height".

> +	 * update the screen, you have to send a byte, each byte
> +	 * containing a bit per pixel to set, on the same column. That
> +	 * way, by sending a byte, you will only portion of the screen

English issue.

> +	 * that has a height of 8 bit and a width of 1, the right-most
> +	 * bit being on the top of this frame. So we have to do a bit
> +	 * of magic here...

How about summarizing this by something like:

 The screen is divided in pages, each having a height of 8 pixels, and
 the width of the screen. When sending a byte of data to the
 controller, it gives the 8 bits for the current column. I.e, the first
 byte are the 8 bits of the first column, then the 8 bits for the
 second column, etc.

And even add some ASCII art to it:

 Representation of the screen, assuming it is 5 bits wide. Each
 letter-number combination is a bit that controls one pixel.

 A0 A1 A2 A3 A4
 B0 B1 B2 B3 B4
 C0 C1 C2 C3 C4
 D0 D1 D2 D3 D4
 E0 E1 E2 E3 E4
 F0 F1 F2 F3 F4
 G0 G1 G2 G3 G4
 H0 H1 H2 H3 H4

 If you want to update this screen, you need to send 5 bytes:
  (1) A0 B0 C0 D0 E0 F0 G0 H0
  (2) A1 B1 C1 D1 E1 F1 G1 H1
  (3) A2 B2 C2 D2 E2 F2 G2 H2
  (4) A3 B3 C3 D3 E3 F3 G3 H3
  (5) A4 B4 C4 D4 E4 F4 G4 H4

> +	for (i =3D 0; i < (SSD1307FB_HEIGHT / 8); i++) {
> +		ssd1307fb_write_cmd(par->client, SSD1307FB_START_PAGE_ADDRESS + (i + 1=
));
> +		ssd1307fb_write_cmd(par->client, 0x00);
> +		ssd1307fb_write_cmd(par->client, 0x10);
> +
> +		for (j =3D 0; j < SSD1307FB_WIDTH; j++) {
> +			u8 buf =3D 0;
> +			for (k =3D 0; k < 8; k++) {
> +				u32 page_length =3D SSD1307FB_WIDTH * i;
> +				u32 index =3D page_length + (SSD1307FB_WIDTH * k + j) / 8;
> +				u8 byte =3D *(vmem + index);
> +				u8 bit =3D byte & (1 << (7 - (j % 8)));
> +				bit =3D bit >> (7 - (j % 8));
> +				buf |=3D bit << k;
> +			}
> +			ssd1307fb_write_data(par->client, buf);
> +		}
> +	}
> +
> +	return;
> +}
> +
> +
> +static ssize_t ssd1307fb_write(struct fb_info *info, const char __user *=
buf,
> +		size_t count, loff_t *ppos)
> +{
> +	struct ssd1307fb_par *par =3D info->par;
> +	unsigned long p =3D *ppos;
> +	void *dst;
> +	int err =3D 0;
> +
> +	dst =3D (void __force *) (info->screen_base + p);
> +
> +	if (copy_from_user(dst, buf, count))
> +		err =3D -EFAULT;
> +
> +	if  (!err)
> +		*ppos +=3D count;
> +
> +	ssd1307fb_update_display(par);
> +
> +	return (err) ? err : count;
> +}
> +
> +static void ssd1307fb_fillrect(struct fb_info *info, const struct fb_fil=
lrect *rect)
> +{
> +	struct ssd1307fb_par *par =3D info->par;
> +	sys_fillrect(info, rect);
> +	ssd1307fb_update_display(par);
> +}
> +
> +static void ssd1307fb_copyarea(struct fb_info *info, const struct fb_cop=
yarea *area)=20
> +{
> +	struct ssd1307fb_par *par =3D info->par;
> +	sys_copyarea(info, area);
> +	ssd1307fb_update_display(par);
> +}
> +
> +static void ssd1307fb_imageblit(struct fb_info *info, const struct fb_im=
age *image)=20
> +{
> +	struct ssd1307fb_par *par =3D info->par;
> +	sys_imageblit(info, image);
> +	ssd1307fb_update_display(par);
> +}
> +
> +static struct fb_ops ssd1307fb_ops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.fb_read	=3D fb_sys_read,
> +	.fb_write	=3D ssd1307fb_write,
> +	.fb_fillrect	=3D ssd1307fb_fillrect,
> +	.fb_copyarea	=3D ssd1307fb_copyarea,
> +	.fb_imageblit	=3D ssd1307fb_imageblit,
> +};
> +
> +static void ssd1307fb_deferred_io(struct fb_info *info,
> +				struct list_head *pagelist)
> +{
> +	ssd1307fb_update_display(info->par);
> +}
> +
> +static struct fb_deferred_io ssd1307fb_defio =3D {
> +	.delay		=3D HZ,
> +	.deferred_io	=3D ssd1307fb_deferred_io,
> +};
> +
> +static int __devinit ssd1307fb_probe(struct i2c_client *client, const st=
ruct i2c_device_id *id)
> +{
> +	struct fb_info *info;
> +	u32 vmem_size =3D SSD1307FB_WIDTH * SSD1307FB_HEIGHT / 8;
> +	struct ssd1307fb_par *par;
> +	u8 *vmem;
> +	int ret;
> +
> +	if (!client->dev.of_node) {
> +		dev_err(&client->dev, "No device tree data found!\n");
> +		ret =3D -EINVAL;
> +		goto generic_error;
> +	}
> +
> +	info =3D framebuffer_alloc(sizeof(struct ssd1307fb_par), &client->dev);
> +	if (!info) {
> +		ret =3D -ENOMEM;
> +		goto generic_error;
> +	}
> +
> +	vmem =3D devm_kzalloc(&client->dev, vmem_size, GFP_KERNEL);

Error checking?

> +	info->fbops =3D &ssd1307fb_ops;
> +	info->fix =3D ssd1307fb_fix;
> +	info->fbdefio =3D &ssd1307fb_defio;
> +
> +	info->var =3D ssd1307fb_var;
> +	info->var.red.length =3D 1;
> +	info->var.red.offset =3D 0;
> +	info->var.green.length =3D 1;
> +	info->var.green.offset =3D 0;
> +	info->var.blue.length =3D 1;
> +	info->var.blue.offset =3D 0;
> +
> +	info->screen_base =3D (u8 __force __iomem *)vmem;
> +	info->fix.smem_len =3D vmem_size;
> +
> +	fb_deferred_io_init(info);
> +
> +	par =3D info->par;
> +	par->info =3D info;
> +	par->client =3D client;
> +
> +	par->reset =3D of_get_named_gpio(client->dev.of_node,
> +					 "oled-reset-gpios", 0);
> +	if (gpio_is_valid(par->reset)) {
> +		int flags =3D GPIOF_OUT_INIT_HIGH;
> +		if (of_get_property(client->dev.of_node,
> +				    "reset-active-low", NULL))
> +			flags =3D GPIOF_OUT_INIT_LOW;
> +		ret =3D devm_gpio_request_one(&client->dev, par->reset,
> +					    flags, "oled-reset");
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"failed to request gpio %d: %d\n",
> +				par->reset, ret);
> +			goto reset_oled_error;
> +		}
> +	}
> +
> +	par->pwm =3D pwm_get(&client->dev, NULL);
> +	if (IS_ERR(par->pwm)) {
> +		dev_err(&client->dev, "Could not get PWM from device tree!\n");
> +		ret =3D PTR_ERR(par->pwm);
> +		goto pwm_error;
> +	}
> +
> +	par->pwm_period =3D pwm_get_period(par->pwm);
> +
> +	dev_dbg(&client->dev, "Using PWM%d with a %dns period.\n", par->pwm->pw=
m, par->pwm_period);
> +
> +	ret =3D register_framebuffer(info);
> +	if (ret) {
> +		dev_err(&client->dev, "Couldn't register the framebuffer\n");
> +		goto fbreg_error;
> +	}
> +
> +	i2c_set_clientdata(client, info);
> +
> +	/* Reset the screen */
> +	gpio_set_value(par->reset, 1);
> +	udelay(4);
> +	gpio_set_value(par->reset, 0);
> +	udelay(4);
> +
> +	/* Enable the PWM */
> +	pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
> +	pwm_enable(par->pwm);
> +
> +	/* Map column 127 of the OLED to segment 0 */
> +	ret =3D ssd1307fb_write_cmd(client, SSD1307FB_SEG_REMAP_ON);
> +	if (ret) {
> +		dev_err(&client->dev, "Couldn't remap the screen.\n");
> +		goto remap_error;
> +	}
> +
> +	/* Turn on the display */
> +	ret =3D ssd1307fb_write_cmd(client, SSD1307FB_DISPLAY_ON);
> +	if (ret) {
> +		dev_err(&client->dev, "Couldn't turn the display on.\n");
> +		goto remap_error;
> +	}
> +
> +	dev_info(&client->dev, "fb%d: %s framebuffer device registered, using %=
d bytes of video memory\n", info->node, info->fix.id, vmem_size);
> +
> +	return 0;
> +
> +remap_error:
> +	unregister_framebuffer(info);
> +	pwm_disable(par->pwm);
> +fbreg_error:
> +	pwm_put(par->pwm);
> +pwm_error:
> +reset_oled_error:
> +	fb_deferred_io_cleanup(info);
> +	framebuffer_release(info);
> +generic_error:
> +	return ret;
> +}
> +
> +static int __devexit ssd1307fb_remove(struct i2c_client *client)
> +{
> +	struct fb_info *info =3D i2c_get_clientdata(client);
> +	struct ssd1307fb_par *par =3D info->par;
> +	unregister_framebuffer(info);
> +	pwm_disable(par->pwm);
> +	pwm_put(par->pwm);
> +	fb_deferred_io_cleanup(info);
> +	framebuffer_release(info);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ssd1307fb_i2c_id[] =3D {
> +	{ "ssd1307fb", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ssd1307fb_i2c_id);
> +
> +static const struct of_device_id ssd1307fb_of_match[] =3D {
> +	{ .compatible =3D "solomon,ssd1307fb-i2c" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ssd1307fb_of_match);
> +
> +static struct i2c_driver ssd1307fb_driver =3D {
> +	.probe =3D ssd1307fb_probe,
> +	.remove =3D __devexit_p(ssd1307fb_remove),
> +	.id_table =3D ssd1307fb_i2c_id,
> +	.driver =3D {
> +		.name =3D "ssd1307fb",
> +		.of_match_table =3D of_match_ptr(ssd1307fb_of_match),
> +		.owner =3D THIS_MODULE,
> +	},
> +};
> +
> +module_i2c_driver(ssd1307fb_driver);
> +
> +MODULE_DESCRIPTION("FB driver for the Solomon SSD1307 OLED controler");
> +MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
> +MODULE_LICENSE("GPL");



--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
