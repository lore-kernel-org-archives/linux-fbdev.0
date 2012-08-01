From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 01 Aug 2012 05:44:16 +0000
Subject: Re: [PATCH 1/4] video: Add support for the Solomon SSD1307 OLED Controller
Message-Id: <004701cd6fa8$b08e0a20$11aa1e60$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343730576-20494-1-git-send-email-maxime.ripard@free-electrons.com>
 <1343730576-20494-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1343730576-20494-2-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday, July 31, 2012 7:30 PM Maxime Ripard wrote:
> 
> This patch adds support for the Solomon SSD1307 OLED
> controller found on the Crystalfontz CFA10036 board.
> 
> This controller can drive a display with a resolution up
> to 128x39 and can operate over I2C or SPI.
> 
> The current driver has only been tested on the CFA-10036,
> that is using this controller over I2C to driver a 96x16
> OLED screen.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Brian Lilly <brian@crystalfontz.com>
> ---
>  .../devicetree/bindings/video/ssd1307fb.txt        |   24 ++
>  drivers/video/Kconfig                              |   14 +
>  drivers/video/Makefile                             |    1 +
>  drivers/video/ssd1307fb.c                          |  418 ++++++++++++++++++++
>  4 files changed, 457 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/ssd1307fb.txt
>  create mode 100644 drivers/video/ssd1307fb.c
> 
> diff --git a/Documentation/devicetree/bindings/video/ssd1307fb.txt
> b/Documentation/devicetree/bindings/video/ssd1307fb.txt
> new file mode 100644
> index 0000000..791e14f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/ssd1307fb.txt
> @@ -0,0 +1,24 @@
> +* Solomon SSD1307 Framebuffer Driver
> +
> +Required properties:
> +  - compatible: Should be "solomon,ssd1307fb-<bus>". The only supported bus for
> +    now is i2c.
> +  - reg: Should contain address of the controller on the I2C bus. Most likely
> +         0x3c or 0x3d
> +  - pwm: Should contain the pwm to use according to the OF device tree PWM
> +         specification [0]
> +  - oled-reset-gpio: Should contain the GPIO used to reset the OLED display
> +
> +Optional properties:
> +  - oled-reset-active-low: Is the reset gpio is active on physical low?
> +
> +[0]: Documentation/devicetree/bindings/pwm/pwm.txt
> +
> +Examples:
> +ssd1307: oled@3c {
> +        compatible = "solomon,ssd1307fb-i2c";
> +        reg = <0x3c>;
> +        pwms = <&pwm 4 3000>;
> +        oled-reset-gpio = <&gpio2 7 1>;
> +        oled-reset-active-low;
> +};
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 0217f74..21ae6dd 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2469,4 +2469,18 @@ config FB_SH_MOBILE_MERAM
>  	  Up to 4 memory channels can be configured, allowing 4 RGB or
>  	  2 YCbCr framebuffers to be configured.
> 
> +

Please remove redundant line.

> +config FB_SSD1307
> +	tristate "Solomon SSD1307 framebuffer support"
> +	depends on FB && I2C
> +	select FB_SYS_FOPS
> +	select FB_SYS_FILLRECT
> +	select FB_SYS_COPYAREA
> +	select FB_SYS_IMAGEBLIT
> +	select FB_DEFERRED_IO
> +	select PWM
> +	help
> +	  This driver implements support for the Solomon SSD1307
> +	  OLED controller over I2C.
> +
>  endmenu
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index ee8dafb..6bbb72c 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -164,6 +164,7 @@ obj-$(CONFIG_FB_BFIN_7393)        += bfin_adv7393fb.o
>  obj-$(CONFIG_FB_MX3)		  += mx3fb.o
>  obj-$(CONFIG_FB_DA8XX)		  += da8xx-fb.o
>  obj-$(CONFIG_FB_MXS)		  += mxsfb.o
> +obj-$(CONFIG_FB_SSD1307)	  += ssd1307fb.o
> 
>  # the test framebuffer is last
>  obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
> diff --git a/drivers/video/ssd1307fb.c b/drivers/video/ssd1307fb.c
> new file mode 100644
> index 0000000..c705ab4
> --- /dev/null
> +++ b/drivers/video/ssd1307fb.c
> @@ -0,0 +1,418 @@
> +/*
> + * Driver for the Solomon SSD1307 OLED controler
> + *
> + * Copyright 2012 Free Electrons
> + *
> + * Licensed under the GPLv2 or later.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/i2c.h>
> +#include <linux/fb.h>
> +#include <linux/uaccess.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/pwm.h>
> +#include <linux/delay.h>
> +
> +#define SSD1307FB_WIDTH			96
> +#define SSD1307FB_HEIGHT		16
> +
> +#define SSD1307FB_DATA			0x40
> +#define SSD1307FB_COMMAND		0x80
> +
> +#define SSD1307FB_CONTRAST		0x81
> +#define SSD1307FB_SEG_REMAP_ON		0xa1
> +#define SSD1307FB_DISPLAY_OFF		0xae
> +#define SSD1307FB_DISPLAY_ON		0xaf
> +#define SSD1307FB_START_PAGE_ADDRESS	0xb0
> +
> +struct ssd1307fb_par {
> +	struct i2c_client *client;
> +	struct fb_info *info;
> +	struct pwm_device *pwm;
> +	u32 pwm_period;
> +	int reset;
> +};
> +
> +static struct fb_fix_screeninfo ssd1307fb_fix __devinitdata = {
> +	.id		= "Solomon SSD1307",
> +	.type		= FB_TYPE_PACKED_PIXELS,
> +	.visual		= FB_VISUAL_MONO10,
> +	.xpanstep	= 0,
> +	.ypanstep	= 0,
> +	.ywrapstep	= 0,
> +	.line_length	= SSD1307FB_WIDTH / 8,
> +	.accel		= FB_ACCEL_NONE,
> +};
> +
> +static struct fb_var_screeninfo ssd1307fb_var __devinitdata = {
> +	.xres		= SSD1307FB_WIDTH,
> +	.yres		= SSD1307FB_HEIGHT,
> +	.xres_virtual	= SSD1307FB_WIDTH,
> +	.yres_virtual	= SSD1307FB_HEIGHT,
> +	.bits_per_pixel	= 1,
> +};
> +
> +static int ssd1307fb_write_array(struct i2c_client *client, u8 type, u8* cmd, u32 len)
> +{
> +	u8 *buf;
> +	int ret = 0;
> +
> +	buf = kzalloc(len + 1, GFP_KERNEL);
> +	if (!buf) {
> +		dev_err(&client->dev, "Couldn't allocate sending buffer.\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}

How about using returning - ENOMEM without goto.
It is simpler.

	if (!buf) {
		dev_err(&client->dev, "Couldn't allocate sending buffer.\n");
		return -ENOMEM;
	}


> +
> +	buf[0] = type;
> +	memcpy(buf + 1, cmd, len);
> +
> +	ret = i2c_master_send(client, buf, len + 1);
> +	if (ret != len + 1) {
> +		dev_err(&client->dev, "Couldn't send I2C command.\n");
> +		goto error;
> +	}
> +
> +error:
> +	kfree(buf);
> +out:
> +	return ret;

Please refer to above comment.
If goto out is not used, it would be simpler.

+error:
+	kfree(buf);
+	return ret;


> +}
> +
> +static inline int ssd1307fb_write_cmd_array(struct i2c_client *client, u8* cmd, u32 len)
> +{
> +	return ssd1307fb_write_array(client, SSD1307FB_COMMAND, cmd, len);
> +}
> +
> +static inline int ssd1307fb_write_cmd(struct i2c_client *client, u8 cmd)
> +{
> +	return ssd1307fb_write_cmd_array(client, &cmd, 1);
> +}
> +
> +static inline int ssd1307fb_write_data_array(struct i2c_client *client, u8* cmd, u32 len)
> +{
> +	return ssd1307fb_write_array(client, SSD1307FB_DATA, cmd, len);
> +}
> +
> +static inline int ssd1307fb_write_data(struct i2c_client *client, u8 data)
> +{
> +	return ssd1307fb_write_data_array(client, &data, 1);
> +}
> +
> +static int ssd1307fb_set(struct i2c_client *client, u8 value)
> +{
> +	int i, j, ret;
> +
> +	for (i = 1; i <= (SSD1307FB_HEIGHT / 8); i++) {
> +		ret = ssd1307fb_write_cmd(client, SSD1307FB_START_PAGE_ADDRESS + i);
> +		if (ret < 0)
> +			goto i2c_error;
> +
> +		ret = ssd1307fb_write_cmd(client, 0x00);
> +		if (ret < 0)
> +			goto i2c_error;
> +
> +		ret = ssd1307fb_write_cmd(client, 0x10);
> +		if (ret < 0)
> +			goto i2c_error;
> +
> +		for (j = 0; j < SSD1307FB_WIDTH; j++)
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
> +	u8 *vmem = par->info->screen_base;
> +	int i, j, k;
> +
> +	/*
> +	 * The screen is divided in pages, each having a height of 8
> +	 * pixels, and the width of the screen. When sending a byte of
> +	 * data to the controller, it gives the 8 bits for the current
> +	 * column. I.e, the first byte are the 8 bits of the first
> +	 * column, then the 8 bits for the second column, etc.
> +	 *
> +	 *
> +	 * Representation of the screen, assuming it is 5 bits
> +	 * wide. Each letter-number combination is a bit that controls
> +	 * one pixel.
> +	 *
> +	 * A0 A1 A2 A3 A4
> +	 * B0 B1 B2 B3 B4
> +	 * C0 C1 C2 C3 C4
> +	 * D0 D1 D2 D3 D4
> +	 * E0 E1 E2 E3 E4
> +	 * F0 F1 F2 F3 F4
> +	 * G0 G1 G2 G3 G4
> +	 * H0 H1 H2 H3 H4
> +	 *
> +	 * If you want to update this screen, you need to send 5 bytes:
> +	 *  (1) A0 B0 C0 D0 E0 F0 G0 H0
> +	 *  (2) A1 B1 C1 D1 E1 F1 G1 H1
> +	 *  (3) A2 B2 C2 D2 E2 F2 G2 H2
> +	 *  (4) A3 B3 C3 D3 E3 F3 G3 H3
> +	 *  (5) A4 B4 C4 D4 E4 F4 G4 H4
> +	 */
> +
> +	for (i = 0; i < (SSD1307FB_HEIGHT / 8); i++) {
> +		ssd1307fb_write_cmd(par->client, SSD1307FB_START_PAGE_ADDRESS + (i + 1));
> +		ssd1307fb_write_cmd(par->client, 0x00);
> +		ssd1307fb_write_cmd(par->client, 0x10);
> +
> +		for (j = 0; j < SSD1307FB_WIDTH; j++) {
> +			u8 buf = 0;
> +			for (k = 0; k < 8; k++) {
> +				u32 page_length = SSD1307FB_WIDTH * i;
> +				u32 index = page_length + (SSD1307FB_WIDTH * k + j) / 8;
> +				u8 byte = *(vmem + index);
> +				u8 bit = byte & (1 << (7 - (j % 8)));
> +				bit = bit >> (7 - (j % 8));
> +				buf |= bit << k;
> +			}
> +			ssd1307fb_write_data(par->client, buf);
> +		}
> +	}
> +
> +	return;
> +}
> +
> +

Please remove unnecessary line.

> +static ssize_t ssd1307fb_write(struct fb_info *info, const char __user *buf,
> +		size_t count, loff_t *ppos)
> +{
> +	struct ssd1307fb_par *par = info->par;
> +	unsigned long p = *ppos;
> +	void *dst;
> +	int err = 0;
> +
> +	dst = (void __force *) (info->screen_base + p);
> +
> +	if (copy_from_user(dst, buf, count))
> +		err = -EFAULT;
> +
> +	if  (!err)
> +		*ppos += count;
> +
> +	ssd1307fb_update_display(par);
> +
> +	return (err) ? err : count;
> +}
> +
> +static void ssd1307fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
> +{
> +	struct ssd1307fb_par *par = info->par;
> +	sys_fillrect(info, rect);
> +	ssd1307fb_update_display(par);
> +}
> +
> +static void ssd1307fb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
> +{
> +	struct ssd1307fb_par *par = info->par;
> +	sys_copyarea(info, area);
> +	ssd1307fb_update_display(par);
> +}
> +
> +static void ssd1307fb_imageblit(struct fb_info *info, const struct fb_image *image)
> +{
> +	struct ssd1307fb_par *par = info->par;
> +	sys_imageblit(info, image);
> +	ssd1307fb_update_display(par);
> +}
> +
> +static struct fb_ops ssd1307fb_ops = {
> +	.owner		= THIS_MODULE,
> +	.fb_read	= fb_sys_read,
> +	.fb_write	= ssd1307fb_write,
> +	.fb_fillrect	= ssd1307fb_fillrect,
> +	.fb_copyarea	= ssd1307fb_copyarea,
> +	.fb_imageblit	= ssd1307fb_imageblit,
> +};
> +
> +static void ssd1307fb_deferred_io(struct fb_info *info,
> +				struct list_head *pagelist)
> +{
> +	ssd1307fb_update_display(info->par);
> +}
> +
> +static struct fb_deferred_io ssd1307fb_defio = {
> +	.delay		= HZ,
> +	.deferred_io	= ssd1307fb_deferred_io,
> +};
> +
> +static int __devinit ssd1307fb_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct fb_info *info;
> +	u32 vmem_size = SSD1307FB_WIDTH * SSD1307FB_HEIGHT / 8;
> +	struct ssd1307fb_par *par;
> +	u8 *vmem;
> +	int ret;
> +
> +	if (!client->dev.of_node) {
> +		dev_err(&client->dev, "No device tree data found!\n");
> +		ret = -EINVAL;
> +		goto generic_error;
> +	}

How about using returning -EINVAL without goto.
It is simpler.

	if (!client->dev.of_node) {
		dev_err(&client->dev, "No device tree data found!\n");
		return -EINVAL;
	}


> +
> +	info = framebuffer_alloc(sizeof(struct ssd1307fb_par), &client->dev);
> +	if (!info) {
> +		ret = -ENOMEM;
> +		goto generic_error;
> +	}


Ditto.


> +
> +	vmem = devm_kzalloc(&client->dev, vmem_size, GFP_KERNEL);
> +	if (!vmem) {
> +		dev_err(&client->dev, "Couldn't allocate graphical memory.\n");
> +		ret = -ENOMEM;
> +		goto generic_error;
> +	}

Please fix this 'goto generic_error'. goto generic_error cannot call
framebuffer_release(). If framebuffer_alloc() is already called,
framebuffer_release() should be called when error happens.


> +
> +	info->fbops = &ssd1307fb_ops;
> +	info->fix = ssd1307fb_fix;
> +	info->fbdefio = &ssd1307fb_defio;
> +
> +	info->var = ssd1307fb_var;
> +	info->var.red.length = 1;
> +	info->var.red.offset = 0;
> +	info->var.green.length = 1;
> +	info->var.green.offset = 0;
> +	info->var.blue.length = 1;
> +	info->var.blue.offset = 0;
> +
> +	info->screen_base = (u8 __force __iomem *)vmem;
> +	info->fix.smem_start = (unsigned long)vmem;
> +	info->fix.smem_len = vmem_size;
> +
> +	fb_deferred_io_init(info);
> +
> +	par = info->par;
> +	par->info = info;
> +	par->client = client;
> +
> +	par->reset = of_get_named_gpio(client->dev.of_node,
> +					 "oled-reset-gpio", 0);
> +	if (gpio_is_valid(par->reset)) {
> +		int flags = GPIOF_OUT_INIT_HIGH;
> +		if (of_get_property(client->dev.of_node,
> +				    "oled-reset-active-low", NULL))
> +			flags = GPIOF_OUT_INIT_LOW;
> +		ret = devm_gpio_request_one(&client->dev, par->reset,
> +					    flags, "oled-reset");
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"failed to request gpio %d: %d\n",
> +				par->reset, ret);
> +			goto reset_oled_error;
> +		}
> +	}
> +
> +	par->pwm = pwm_get(&client->dev, NULL);
> +	if (IS_ERR(par->pwm)) {
> +		dev_err(&client->dev, "Could not get PWM from device tree!\n");
> +		ret = PTR_ERR(par->pwm);
> +		goto pwm_error;
> +	}
> +
> +	par->pwm_period = pwm_get_period(par->pwm);
> +
> +	dev_dbg(&client->dev, "Using PWM%d with a %dns period.\n", par->pwm->pwm, par->pwm_period);
> +
> +	ret = register_framebuffer(info);
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
> +	ret = ssd1307fb_write_cmd(client, SSD1307FB_SEG_REMAP_ON);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Couldn't remap the screen.\n");
> +		goto remap_error;
> +	}
> +
> +	/* Turn on the display */
> +	ret = ssd1307fb_write_cmd(client, SSD1307FB_DISPLAY_ON);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Couldn't turn the display on.\n");
> +		goto remap_error;
> +	}
> +
> +	dev_info(&client->dev, "fb%d: %s framebuffer device registered, using %d bytes of video memory\n",
> info->node, info->fix.id, vmem_size);
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
> +	struct fb_info *info = i2c_get_clientdata(client);
> +	struct ssd1307fb_par *par = info->par;


How about insert new line between variables and functions
to enhance the readability?


> +	unregister_framebuffer(info);
> +	pwm_disable(par->pwm);
> +	pwm_put(par->pwm);
> +	fb_deferred_io_cleanup(info);
> +	framebuffer_release(info);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ssd1307fb_i2c_id[] = {
> +	{ "ssd1307fb", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ssd1307fb_i2c_id);
> +
> +static const struct of_device_id ssd1307fb_of_match[] = {
> +	{ .compatible = "solomon,ssd1307fb-i2c" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ssd1307fb_of_match);
> +
> +static struct i2c_driver ssd1307fb_driver = {
> +	.probe = ssd1307fb_probe,
> +	.remove = __devexit_p(ssd1307fb_remove),
> +	.id_table = ssd1307fb_i2c_id,
> +	.driver = {
> +		.name = "ssd1307fb",
> +		.of_match_table = of_match_ptr(ssd1307fb_of_match),
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +module_i2c_driver(ssd1307fb_driver);
> +
> +MODULE_DESCRIPTION("FB driver for the Solomon SSD1307 OLED controler");
> +MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
> +MODULE_LICENSE("GPL");
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

