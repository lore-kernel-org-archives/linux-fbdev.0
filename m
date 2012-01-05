From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 05 Jan 2012 01:01:03 +0000
Subject: Re: [PATCH v5 2/2] video: backlight: support s6e8ax0 panel driver
Message-Id: <20120104170103.bae938a9.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4EF15F9C.9030807@samsung.com>
In-Reply-To: <4EF15F9C.9030807@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 21 Dec 2011 13:25:00 +0900
Donghwa Lee <dh09.lee@samsung.com> wrote:

> 
> This patch is amoled panel driver based MIPI DSI interface.
> S6E8AX0 means it may includes many other ldi controllers, for example,
> S6E8AA0, S6E8AB0, and so on.
> 
> This patch can be modified depending on each panel properites. For example,
> second parameter of panel condition register can be changed depending on
> ldi controller or amoled type.
> 
>
> ...
>
> +static unsigned char s6e8ax0_22_gamma_30[] = {
> +	0xFA, 0x01, 0x60, 0x10, 0x60, 0xF5, 0x00, 0xFF, 0xAD, 0xAF,
> +	0xBA, 0xC3, 0xD8, 0xC5, 0x9F, 0xC6, 0x9E, 0xC1, 0xDC, 0xC0,
> +	0x00, 0x61, 0x00, 0x5A, 0x00, 0x74,
> +};
> +
>
> ...
>
> +static unsigned char s6e8ax0_22_gamma_300[] = {
> +	0xFA, 0x01, 0x60, 0x10, 0x60, 0xB5, 0xD3, 0xBD, 0xB1, 0xD2,
> +	0xB0, 0xC0, 0xDC, 0xC0, 0x94, 0xBA, 0x91, 0xAC, 0xC5, 0xA9,
> +	0x00, 0xC2, 0x00, 0xB7, 0x00, 0xED,
> +};
> +
> +static unsigned char *s6e8ax0_22_gamma_table[] = {
> +	s6e8ax0_22_gamma_30,
> +	s6e8ax0_22_gamma_50,
> +	s6e8ax0_22_gamma_60,
> +	s6e8ax0_22_gamma_70,
> +	s6e8ax0_22_gamma_80,
> +	s6e8ax0_22_gamma_90,
> +	s6e8ax0_22_gamma_100,
> +	s6e8ax0_22_gamma_120,
> +	s6e8ax0_22_gamma_130,
> +	s6e8ax0_22_gamma_140,
> +	s6e8ax0_22_gamma_150,
> +	s6e8ax0_22_gamma_160,
> +	s6e8ax0_22_gamma_170,
> +	s6e8ax0_22_gamma_180,
> +	s6e8ax0_22_gamma_190,
> +	s6e8ax0_22_gamma_200,
> +	s6e8ax0_22_gamma_210,
> +	s6e8ax0_22_gamma_220,
> +	s6e8ax0_22_gamma_230,
> +	s6e8ax0_22_gamma_240,
> +	s6e8ax0_22_gamma_250,
> +	s6e8ax0_22_gamma_260,
> +	s6e8ax0_22_gamma_270,
> +	s6e8ax0_22_gamma_280,
> +	s6e8ax0_22_gamma_300,
> +};

I suggest making all the above arrays const.  Otherwise the compiler
might end up deciding to needlessly allocate space in writeable storage
for them.

If that means that ops->cmd_write() needs constification as well then
let's just do that, for it is the right thing to do.

> +static void s6e8ax0_panel_cond(struct s6e8ax0 *lcd)
> +{
> +	struct mipi_dsim_master_ops *ops = lcd_to_master_ops(lcd);
> +
> +	unsigned char data_to_send[] = {
> +		0xf8, 0x3d, 0x35, 0x00, 0x00, 0x00, 0x93, 0x00, 0x3c,
> +		0x7d, 0x08, 0x27, 0x7d, 0x3f, 0x00, 0x00, 0x00, 0x20,
> +		0x04, 0x08, 0x6e, 0x00, 0x00, 0x00, 0x02, 0x08, 0x08,
> +		0x23, 0x23, 0xc0, 0xc8, 0x08, 0x48, 0xc1, 0x00, 0xc1,
> +		0xff, 0xff, 0xc8
> +	};

Arrays like this certainly should be const.  As it stands, the compiler
needs to generate room on the stack and generate a local copy of the
array each time this function is called!

> +	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
> +		data_to_send, ARRAY_SIZE(data_to_send));
> +}
> +
> +static void s6e8ax0_display_cond(struct s6e8ax0 *lcd)
> +{
> +	struct mipi_dsim_master_ops *ops = lcd_to_master_ops(lcd);
> +	unsigned char data_to_send[] = {
> +		0xf2, 0x80, 0x03, 0x0d
> +	};
> +
> +	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
> +		data_to_send, ARRAY_SIZE(data_to_send));
> +}
> +
> +/* Gamma 2.2 Setting (200cd, 7500K, 10MPCD) */
> +static void s6e8ax0_gamma_cond(struct s6e8ax0 *lcd)
> +{
> +	struct mipi_dsim_master_ops *ops = lcd_to_master_ops(lcd);
> +	unsigned int gamma = lcd->bd->props.brightness;
> +
> +	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
> +			s6e8ax0_22_gamma_table[gamma],
> +			ARRAY_SIZE(s6e8ax0_22_gamma_table));

This seems wrong.  ARRAY_SIZE(s6e8ax0_22_gamma_table) does not
represent the size of s6e8ax0_22_gamma_table[gamma]!

> +}
> +
>
> ...
>
> +static int s6e8ax0_update_gamma_ctrl(struct s6e8ax0 *lcd, int brightness)
> +{
> +	struct mipi_dsim_master_ops *ops = lcd_to_master_ops(lcd);
> +
> +	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
> +			s6e8ax0_22_gamma_table[brightness],
> +			ARRAY_SIZE(s6e8ax0_22_gamma_table));

Ditto.

> +	/* update gamma table. */
> +	s6e8ax0_gamma_update(lcd);
> +	lcd->gamma = brightness;
> +
> +	return 0;
> +}
> +
>
> ...
>
> +static void s6e8ax0_power_on(struct mipi_dsim_lcd_device *dsim_dev, int power)
> +{
> +	struct s6e8ax0 *lcd = dev_get_drvdata(&dsim_dev->dev);
> +
> +	msleep(lcd->ddi_pd->power_on_delay);
> +
> +	/* lcd power on */
> +	if (power)
> +		s6e8ax0_regulator_enable(lcd);
> +	else
> +		s6e8ax0_regulator_disable(lcd);
> +
> +	msleep(lcd->ddi_pd->reset_delay);
> +
> +	/* lcd reset */
> +	if (lcd->ddi_pd->reset)
> +		lcd->ddi_pd->reset(lcd->ld);
> +	msleep(5);
> +}

Maybe we should hold lcd->lock across this function to prevent other
code paths from getting in and fiddling with the hardware while it is
powering on?

>
> ...
>

